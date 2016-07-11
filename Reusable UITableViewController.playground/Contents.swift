import UIKit
import XCPlayground

let pokedex:[Pokemon] = [
    Pokemon(name: "Pikachu", ability: "electric"),
    Pokemon(name: "Charizard", ability: "fire"),
    Pokemon(name: "Mewtwo", ability: "phsychic"),
    Pokemon(name: "Lucario", ability: "fighting"),
    Pokemon(name: "Ghengar", ability: "ghost")
]

// This is great for testability and reusability! And because it's a struct,we can do things like:
// var myConfig = config; myConfig.style = .Grouped
// Note: This is a powerful technique in general. When we have a complex initializer, re-factoring
// the initializer into a struct allows us to have very reusable and testable code
let config = TableViewConfiguration(items: pokedex, style: .Plain, cellStyle: .Subtitle, editable: true) { cell, item in
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = item.ability
}

let pokemonTableVC = TableViewController(configuration: config)

pokemonTableVC.title = "Pokemon"

let navigationController = UINavigationController(rootViewController: pokemonTableVC)

navigationController.view.frame = CGRect(x: 0, y: 0, width: 325, height: 650.0)

XCPlaygroundPage.currentPage.liveView = navigationController.view