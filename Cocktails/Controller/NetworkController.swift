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

enum SearchCriteria {
    case byId
    case byName
    case byIngredient
    case random
}

struct NetworkController {
    private var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchDrinks(_ criteria: SearchCriteria, query: String = "", completion: @escaping (Result<[Drink], NetworkError>) -> Void) {
        
        guard let url = createUrl(query, criteria) else {
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
                    guard let drinks = result.drinks else {
                        completion(.failure(.noResult))
                        return
                    }
                    completion(.success(drinks))
                } catch {
                    completion(.failure(.badJson))
                }
            }
        }.resume()
    }
    
    func createUrl(_ query: String, _ criteria: SearchCriteria) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.thecocktaildb.com"
        
        switch criteria {
        case .byId:
            components.path = "/api/json/v1/1/lookup.php"
            components.queryItems = [URLQueryItem(name: "i", value: query)]
        case .byName:
            components.path = "/api/json/v1/1/search.php"
            components.queryItems = [URLQueryItem(name: "s", value: query)]
        case .byIngredient:
            components.path = "/api/json/v1/1/filter.php"
            components.queryItems = [URLQueryItem(name: "i", value: query)]
        case .random:
            components.path = "/api/json/v1/1/random.php"
        }
        
        return components.url
    }
}
