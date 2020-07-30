//
//  Drink.swift
//  MyCocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

// MARK: - Drink

struct Drink: Decodable {
    let id: String
    let name: String
    let thumbnail: String
    let alcoholic: String?
    let glass: String?
    let instructions: String?
    private let ingredient1, ingredient2, ingredient3, ingredient4, ingredient5: String?
    private let ingredient6, ingredient7, ingredient8, ingredient9, ingredient10: String?
    private let ingredient11, ingredient12, ingredient13, ingredient14, ingredient15: String?
    private let measure1, measure2, measure3, measure4, measure5: String?
    private let measure6, measure7, measure8, measure9, measure10: String?
    private let measure11, measure12, measure13, measure14, measure15: String?
    
    var ingredients: [String] {
        [ingredient1, ingredient2, ingredient3, ingredient4, ingredient5,
         ingredient6, ingredient7, ingredient8, ingredient9, ingredient10,
         ingredient11, ingredient12, ingredient13, ingredient14, ingredient15
        ].compactMap { $0 }
    }
    var measures: [String] {
        [measure1, measure2, measure3, measure4, measure5, measure6, measure7,
         measure8, measure9, measure10, measure11, measure12, measure13, measure14, measure15
        ].compactMap { $0 }
    }
}

extension Drink {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case alcoholic = "strAlcoholic"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case thumbnail = "strDrinkThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
    }
}


// MARK: - SearchDrink

struct SearchDrink: Decodable {
    let drinks: [Drink]?
}
