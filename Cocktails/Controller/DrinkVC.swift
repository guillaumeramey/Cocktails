//
//  DrinkVC.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

class DrinkVC: UITableViewController {
    
    // MARK: - PROPERTIES
    
    var drink: Drink!
    
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!

    
    // MARK: - METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if drink.ingredients.isEmpty {
            fetchDrink()
        } else {
            displayDrink()
        }
    }
    
    private func fetchDrink() {
        NetworkController().fetchDrinks(.byId, query: drink.id) { result in
            switch result {
            case .success(let drinks):
                self.drink = drinks.first
                self.displayDrink()
                self.tableView.reloadData()
            case .failure(let errorMessage):
                self.alert(title: "Erreur", message: errorMessage.rawValue)
            }
        }
    }
    
    private func displayDrink() {
        imageView.load(url: drink.image)
        nameLabel.text = drink.name
        instructionsLabel.text = drink.instructions
        var formattedIngredients = [String]()
        for (ingredient, measure) in zip(drink.ingredients, drink.measures) {
            if ingredient.isEmpty { continue }
            formattedIngredients.append(ingredient + " : " + measure)
        }
        ingredientsLabel.text = formattedIngredients.joined(separator: "\n")
    }
}

