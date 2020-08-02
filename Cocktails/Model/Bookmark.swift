//
//  Bookmark.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 02/08/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import Foundation
import CoreData

class Bookmark: NSManagedObject {
    
    static var drinks: [Drink]? {
        let request: NSFetchRequest<Bookmark> = Bookmark.fetchRequest()
        guard let bookmarks = try? AppDelegate.viewContext.fetch(request) else {
            return nil
        }
        return bookmarks.map {$0.drink}
    }
    
    var drink: Drink {
        get {
            Drink(from: self)
        }
        set {
            id = newValue.id
            name = newValue.name
            image = newValue.image
        }
    }
}
