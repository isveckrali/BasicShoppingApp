//
//  Helper.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-19.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    
    //Show dialog message to user
    static func dialogMessage(message:String, vc: UIViewController) {
        
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    
    //Download data from server and set incoming view
    static func imageLoad(imageView:UIImageView, url:String) {
        
        let downloadTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, urlResponse, error) in
            if error == nil && data != nil {
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        downloadTask.resume()
    }
    
}
