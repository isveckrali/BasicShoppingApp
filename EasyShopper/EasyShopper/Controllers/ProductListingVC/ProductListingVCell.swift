//
//  ProductListingVCell.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-13.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit




class ProductListingVCell: UITableViewCell {
    
    //Define variables
    var productVM:ProductVM? {
        didSet {
            nameLabel.text = productVM?.productName
            productPriceLabel.text = productVM?.productPrice
            Helper.imageLoad(imageView: productImageView, url: (productVM?.imageURL)!)
        }
    }
    
    
    let productImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
       return img
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
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
    
    let productAddRemoveBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 13
        btn.clipsToBounds = true
        btn.backgroundColor = UIColor.red
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayoutAndConstraints()

     }

     required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)

        
    }

    //Add views to super view and then set up their constraints
    func setUpLayoutAndConstraints() {
        self.contentView.addSubview(productImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(productPriceLabel)
        self.contentView.addSubview(productAddRemoveBtn)
        
        let constraints = [
        
        productImageView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:8),
        productImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:16),
        productImageView.widthAnchor.constraint(equalToConstant:70),
        productImageView.heightAnchor.constraint(equalToConstant:70),
        
        productPriceLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:16),
        productPriceLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-16),
        
        nameLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:16),
        nameLabel.leadingAnchor.constraint(equalTo:self.productImageView.trailingAnchor, constant:16),
        nameLabel.trailingAnchor.constraint(equalTo:self.productAddRemoveBtn.leadingAnchor, constant: -32),
        
        productAddRemoveBtn.widthAnchor.constraint(equalToConstant:26),
        productAddRemoveBtn.heightAnchor.constraint(equalToConstant:26),
        productAddRemoveBtn.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -16),
        productAddRemoveBtn.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}
