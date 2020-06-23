//
//  Product.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-13.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation

class ProductVM {
    
    //Define variables.
    var product: Product?
    var productName: String = ""
    var imageURL: String?
    var productDescription: String = ""
    var productPrice: String = ""
    var productSize: Int?
    
    init(productList: Product) {
        self.product = productList
        setValues()
    }
    
    //Set variables content how we need to show user on user interface
    func setValues() {
        guard let productItem = product else {return}
         if let name = productItem.name {
             //profileImageView.image = UIImage(named: name)
             productName = name
         }
        
         if let desc = productItem.description {
            productDescription = desc
         }
        
         if let image = productItem.imageUrl {
           imageURL = image
         }
        
        if let price = productItem.retailPrice {
            productPrice = " \(price) $ "
        }
        
        if let size = productItem.size {
            if let price = productItem.retailPrice {
                productPrice = " \(price * size) $ "
            }
        }
    }
}
