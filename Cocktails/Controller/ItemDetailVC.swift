//
//  ItemDetailVC.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

class ItemDetailVC: UITableViewController {

    var item: Item!
    private var drink: Drink!
    private var ingredient: Ingredient!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayItem()
        if let drink = item as? Drink {
            self.drink = drink
            displayDrink()
        }
        else if let ingredient = item as? Ingredient {
            self.ingredient = ingredient
            displayIngredient()
        }
    }
    
    private func displayItem() {
        imageView.load(url: item.image)
        nameLabel.text = item.name
    }
    
    private func displayDrink() {
        descriptionLabel.text = drink.instructions
        var formattedIngredients = ""
        for (ingredient, measure) in zip(drink.ingredients, drink.measures) {
            formattedIngredients += ingredient + " : " + measure + "\n"
        }
        ingredientsLabel.text = formattedIngredients
    }
    
    private func displayIngredient() {
        descriptionLabel.text = ingredient.description
    }
}

