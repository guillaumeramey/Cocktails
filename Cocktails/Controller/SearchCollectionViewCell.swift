//
//  SearchCollectionViewCell.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: Item! {
        didSet {
            displayItem()
        }
    }
    
    private func displayItem() {
        contentView.layer.cornerRadius = 10
        nameLabel.text = item.name
        imageView.load(url: item.imagePreview)
        imageView.layer.cornerRadius = 10
        //        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}
