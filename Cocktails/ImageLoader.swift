//
//  ImageLoader.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

private let imageCache = NSCache<NSURL, UIImage>()

extension UIImageView {

    func load(url urlString: String) {
        
        guard let url = URL(string: urlString) else {
            self.image = UIImage(systemName: "questionmark")
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: url as NSURL)
                        self?.image = image
                    }
                }
            }
        }
    }
}
