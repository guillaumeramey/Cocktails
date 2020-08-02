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
    let image: String
    var alcoholic: String? = nil
    var glass: String? = nil
    var instructions: String? = nil
    private var ingredient1: String? = nil
    private var ingredient2: String? = nil
    private var ingredient3: String? = nil
    private var ingredient4: String? = nil
    private var ingredient5: String? = nil
    private var ingredient6: String? = nil
    private var ingredient7: String? = nil
    private var ingredient8: String? = nil
    private var ingredient9: String? = nil
    private var ingredient10: String? = nil
    private var ingredient11: String? = nil
    private var ingredient12: String? = nil
    private var ingredient13: String? = nil
    private var ingredient14: String? = nil
    private var ingredient15: String? = nil
    private var measure1: String? = nil
    private var measure2: String? = nil
    private var measure3: String? = nil
    private var measure4: String? = nil
    private var measure5: String? = nil
    private var measure6: String? = nil
    private var measure7: String? = nil
    private var measure8: String? = nil
    private var measure9: String? = nil
    private var measure10: String? = nil
    private var measure11: String? = nil
    private var measure12: String? = nil
    private var measure13: String? = nil
    private var measure14: String? = nil
    private var measure15: String? = nil
    
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
    
    var imagePreview: String {
        "\(image)/preview"
    }
    
//    let imageData: Data?
    
    init(from bookmark: Bookmark) {
        id = bookmark.id ?? ""
        name = bookmark.name ?? ""
        image = bookmark.image ?? ""
    }
}

extension Drink {
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case alcoholic = "strAlcoholic"
        case glass = "strGlass"
        case instructions = "strInstructions"
        case image = "strDrinkThumb"
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
