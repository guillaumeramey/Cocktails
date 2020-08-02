//
//  ItemCell.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 01/08/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var drink: Drink! {
        didSet {
            displayDrink()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func displayDrink() {
        background.layer.cornerRadius = 10
        nameLabel.text = drink.name
        loadingIndicator.startAnimating()
        imageView.load(url: drink.imagePreview) {
            self.loadingIndicator.stopAnimating()
        }
        imageView.layer.cornerRadius = 10
    }
}
