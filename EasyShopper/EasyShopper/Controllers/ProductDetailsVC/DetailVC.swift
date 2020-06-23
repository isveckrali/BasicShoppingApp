//
//  DetailVC.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-13.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    //Define varialbes
    var scrollView:UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
       return scroll
    }()
    
    var productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        image.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    let nameLabel:UILabel = {
               let label = UILabel()
               label.font = UIFont.boldSystemFont(ofSize: 20)
               label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
               label.translatesAutoresizingMaskIntoConstraints = false
               label.font = .italicSystemFont(ofSize: 16)
               return label
       }()
    
    var productDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productPriceLabel:UILabel = {
      let label = UILabel()
      label.font = UIFont.boldSystemFont(ofSize: 14)
      label.textColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 1)
      label.backgroundColor =  UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
      label.layer.cornerRadius = 5
      label.clipsToBounds = true
      label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    
    var prodcutVM: ProductVM? {
        didSet {
            Helper.imageLoad(imageView: productImageView, url: prodcutVM!.imageURL!)
            productPriceLabel.text = prodcutVM?.productPrice
            productDescriptionLabel.text = prodcutVM?.productDescription
            nameLabel.text = prodcutVM?.productName
        }
    } 
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpLayoutAndConstraints()
        setViewProperties()
        
    }
    
    func checkInternetAccess() {
        if !NetworkController.isConnectedToNetwork() {
            Helper.dialogMessage(message: "Please check your internet connection", vc: self)
        }
    }
    
    //set static properties
    func setViewProperties() {
        self.view.backgroundColor = .white
        self.title = "Product Detail"
    }
    
    //add views to super view and then set up their constraints
    func setUpLayoutAndConstraints() {
        
        self.view.addSubview(scrollView)
        
        self.scrollView.addSubview(productImageView)
        self.scrollView.addSubview(nameLabel)
        self.scrollView.addSubview(productPriceLabel)
        self.scrollView.addSubview(productDescriptionLabel)
        self.scrollView.addSubview(productPriceLabel)
        
        let constraints = [
            
            scrollView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            
        productImageView.centerXAnchor.constraint(equalTo:self.scrollView.centerXAnchor),
        productImageView.topAnchor.constraint(equalTo:self.scrollView.topAnchor, constant: 16),
        productImageView.widthAnchor.constraint(equalToConstant: 140),
        productImageView.heightAnchor.constraint(equalToConstant: 140),
        
        productPriceLabel.bottomAnchor.constraint(equalTo: productImageView.bottomAnchor),
        productPriceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
        
        
        nameLabel.topAnchor.constraint(equalTo: self.productImageView.bottomAnchor, constant: 16),
        nameLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
        nameLabel.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
        
        productDescriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 16),
        productDescriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
        productDescriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: productDescriptionLabel.bottomAnchor)
        //productDescriptionLabel.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

