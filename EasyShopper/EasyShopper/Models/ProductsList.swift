//
//  Products.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-16.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation

struct ProductsObject: Codable {
     
    #warning("Complete this data structure")
}

struct Product: Codable {
    var name: String?
    var barcode: String?
    var description: String?
    var id: String?
    var imageUrl: String?
    var retailPrice: Int?
    var size:Int?
    
    //Turn to camelCase which not camelCase format
    enum CodingKeys: String, CodingKey {
        case retailPrice = "retail_price"
        case imageUrl = "image_url"
        case name, barcode, description, id, size
    }
       
}
