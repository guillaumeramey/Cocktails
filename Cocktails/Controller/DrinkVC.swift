//
//  DrinkVC.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

class DrinkVC: UIViewController {

    var drink: Drink!

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.load(url: drink.thumbnail)
        nameLabel.text = drink.name
    }
    
}

