//
//  NetworkController.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation

enum NetworkError: String, Error {
    case internalError = "Erreur interne"
    case invalidUrl = "Caractères non autorisés."
    case noResponse = "Pas de réponse du serveur. Vérifiez votre connexion."
    case error = "Un problème est survenu."
    case noData = "Aucune donnée reçue."
    case noResult = "Aucun résultat."
    case badJson = "Problème JSON."
}

struct NetworkController {
    
    private var urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetchRandomDrink(completion: @escaping (Result<Drink, NetworkError>) -> Void) {
        
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard response != nil else {
                    completion(.failure(.noResponse))
                    return
                }
                
                guard error == nil else {
                    completion(.failure(.error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(SearchDrink.self, from: data)
                    guard let randomDrink = result.drinks?.first else {
                        completion(.failure(.noResult))
                        return
                    }
                    completion(.success(randomDrink))
                } catch {
                    completion(.failure(.badJson))
                }
            }
        }.resume()
    }
    
    func fetchItems<T: Item>(_ itemType: T.Type, query: String, completion: @escaping (Result<[Item], NetworkError>) -> Void) {
        
        var urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?"
        urlString += T.self == Drink.self ? "s=" : ""
        urlString += T.self == Ingredient.self ? "i=" : ""
        urlString += query
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        urlSession.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard response != nil else {
                    completion(.failure(.noResponse))
                    return
                }
                
                guard error == nil else {
                    completion(.failure(.error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    if T.self == Drink.self {
                        let result = try JSONDecoder().decode(SearchDrink.self, from: data)
                        guard let drinks = result.drinks as? [T] else {
                            completion(.failure(.noResult))
                            return
                        }
                        completion(.success(drinks))
                    }
                    else if T.self == Ingredient.self {
                        let result = try JSONDecoder().decode(SearchIngredient.self, from: data)
                        guard let ingredients = result.ingredients as? [T] else {
                            completion(.failure(.noResult))
                            return
                        }
                        completion(.success(ingredients))
                    }
                } catch {
                    completion(.failure(.badJson))
                }
            }
        }.resume()
    }
}
