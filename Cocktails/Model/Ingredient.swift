//
//  Ingredient.swift
//  MyCocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation


// MARK: - Ingredient

struct Ingredient: Decodable {
    var id: String
    var name: String
    var description: String?
    
    var image: String {
        "https://www.thecocktaildb.com/images/ingredients/\(name).png"
    }
    var imagePreview: String {
        "https://www.thecocktaildb.com/images/ingredients/\(name)-Small.png"
    }
}

extension Ingredient {
    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case name = "strIngredient"
        case description = "strDescription"
    }
}


// MARK: - SearchIngredient

struct SearchIngredient: Decodable {
    let ingredients: [Ingredient]?
}
