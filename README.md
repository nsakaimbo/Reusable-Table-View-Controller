# Reusable Table View Controller

This is an interactive playground based on Chris Eidhof's great [*try!Swift* 2016 talk](https://github.com/nsakaimbo/Reusable-Table-View-Controller.git) on implementing a reusable, generic table view controller. Highlights include generic table view and cell configuration, as well implementing editing history (track/undo changes).

### Generic Table View Configuration

  * Making a *generic* `UITableViewController` subclass that can handle any data type specified at initialization
  * Generalizing the configuration of the table view controller using a `TableViewConfiguration` struct. *Re-factoring complex initializers into structs is a great technique to enable highly reusable and highly testable code!*

  ```
  public struct TableViewConfiguration<Item> {
      
      ...
      
      public init(items: [Item], style: UITableViewStyle, cellStyle: UITableViewCellStyle, editable: Bool, configureCell: (UITableViewCell, Item) -> ()) {
        self.items = items
        self.style = style
        self.cellStyle = cellStyle
        self.editable = editable
        self.configureCell = configureCell
    }
  }
    ```
 
* The generic `TableViewConfiguration` also includes a closure to allow further flexibility in how the cell should be updated as it is dequeued, like so:
 
 ```
 let config = TableViewConfiguration(items: pokedex, style: .Plain, cellStyle: .Subtitle, editable: true) { cell, item in
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = item.ability
}
```

### Undo History
 * This example also makes use of an `UndoHistory` struct, which allows us to monitor and revert to changes in our data source (for example, deleting and un-deleting a record).
 
 ```
 struct UndoHistory<Item> {
    
    let initialValue: [Item]
    var history: [[Item]] = []
    
    init(_ initialValue: [Item]) {
        self.initialValue = initialValue
    }
    
    var currentValue: [Item] {
        get { return history.last ?? initialValue }
        set { history.append(newValue) }
    }
    
    var canUndo: Bool {
        return !history.isEmpty
    }
    
    mutating func undo() {
        history.popLast()
    }
}
```
