import UIKit

public final class TableViewController<Item>: UITableViewController {
    
    var history: UndoHistory<Item> {
        didSet {
            tableView.reloadData()
            
            navigationItem.rightBarButtonItem = history.canUndo ? UIBarButtonItem(barButtonSystemItem: .Undo, target: self, action: #selector(self.undo(_:))) : nil
        }
    }
    var items: [Item] {
        get { return history.currentValue }
        set { history.currentValue = newValue }
    }
    let configureCell: (cell: UITableViewCell, item: Item) -> ()
    let cellStyle: UITableViewCellStyle
    
    public init(configuration: TableViewConfiguration<Item>) {
        
        self.history = UndoHistory(configuration.items)
        self.cellStyle = configuration.cellStyle
        self.configureCell = configuration.configureCell
        
        super.init(style: configuration.style)
        
        if configuration.editable {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: #selector(self.edit(_:)))
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // For this playground, we initalize and return the cells as needed. This is for example only and we should always dequeue our cells in production code!
        
        let cell = UITableViewCell(style: cellStyle, reuseIdentifier: nil)
       
        let item = items[indexPath.row]
        
        configureCell(cell: cell, item: item)
        
        return cell
    }
    
    override public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        guard editingStyle == .Delete else { return }
        
        items.removeAtIndex(indexPath.row)
    }
    
    func edit(sender: AnyObject) {
       tableView.editing = !tableView.editing
    }
    
    func undo(sender: AnyObject) {
        history.undo()
    }
}