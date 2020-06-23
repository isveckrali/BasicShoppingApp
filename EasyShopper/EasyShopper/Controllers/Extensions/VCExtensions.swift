//
//  VCExtensions.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-23.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //Add spinner to all view controller to show on user interface while data is loading
    func addSpinner(activityIndicator: UIActivityIndicatorView) {
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .red
        activityIndicator.color = .black
      
        self.view.addSubview(activityIndicator)
        
        let constraints = [
            activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
       
    }
}
