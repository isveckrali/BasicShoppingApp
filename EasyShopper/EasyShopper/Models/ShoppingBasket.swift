//
//  ShoppingBasket.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation

#warning("Feel free to model a ShoppingBasket any way you like")

struct ShoppingBasket: Decodable {
    var id:String?
    var price:String?
    var imageUrl:String?
    var imageName:String?
    var productDescription:String?
}
