import UIKit

public struct TableViewConfiguration<Item> {
    public var items: [Item]
    public var style: UITableViewStyle
    public var cellStyle: UITableViewCellStyle
    public var editable: Bool
    public var configureCell: (UITableViewCell, Item) -> ()
    
    public init(items: [Item], style: UITableViewStyle, cellStyle: UITableViewCellStyle, editable: Bool, configureCell: (UITableViewCell, Item) -> ()) {
        self.items = items
        self.style = style
        self.cellStyle = cellStyle
        self.editable = editable
        self.configureCell = configureCell
    }
}