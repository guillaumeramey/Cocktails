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
    var id: String? = nil
    var name: String? = nil
    var description: String? = nil
    var type: String? = nil
    var alcohol: String? = nil
    var abv: String? = nil
}

extension Ingredient {
    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case name = "strIngredient"
        case description = "strDescription"
        case type = "strType"
        case alcohol = "strAlcohol"
        case abv = "strABV"
    }
}

// MARK: - SearchIngredient

struct SearchIngredient: Decodable {
    let ingredients: [Ingredient]
}

// MARK: - SearchDrinkByIngredient

struct SearchDrinkByIngredient: Decodable {
    let drinks: [Drink]
}
