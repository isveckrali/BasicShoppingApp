//
//  ShoppingBasketVC.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-22.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit

class ShoppingBasketVC: UIViewController {

    // Define Variables
    let shoppingBasketTV: UITableView = UITableView()
    var productList: [Product] = []
    
    let productDBHelper: ProductDBHelper = ProductDBHelper()
    var badgeDelegate: BadgeDelegate?
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Call all first step functions
        addSpinner(activityIndicator: activityIndicator)
        setViewProperties()
        createViews()
        tableViewSettings()
        getData()
        
        // Do any additional setup after loading the view.
    }
    
    //Set static properties
    func setViewProperties() {
        self.title = "Shopping Basket"
    }
    
    //set table view contraints
    func createViews() {
        view.addSubview(shoppingBasketTV)
        shoppingBasketTV.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [ shoppingBasketTV.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor), shoppingBasketTV.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor), shoppingBasketTV.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor), shoppingBasketTV.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor) ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    //get data from core data via Database Helper class
    func getData() {
        let products = productDBHelper.fetchProduct()
        if let products = products {
            self.productList = products
        } else {
            self.productList = []
            Helper.dialogMessage(message: "Yoru shopping basket is empty", vc: self)
        }
        self.shoppingBasketTV.reloadData()
        activityIndicator.stopAnimating()
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

//Extension provide us to implement Delegates for tableview
extension ShoppingBasketVC:  UITableViewDataSource, UITableViewDelegate {
    
    
    //Set teble view settings
    func tableViewSettings() {
        
        shoppingBasketTV.estimatedRowHeight = 100
        shoppingBasketTV.rowHeight = UITableView.automaticDimension
        
        shoppingBasketTV.register(ProductListingVCell.self, forCellReuseIdentifier: "productListingVCell")
        shoppingBasketTV.dataSource = self
        shoppingBasketTV.delegate = self
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListingVCell", for: indexPath) as! ProductListingVCell
        cell.productVM = ProductVM(productList: productList[indexPath.row])
        removeBtnInCell(cell: cell, indexPath: indexPath)

      return cell
    }
    
    //When product removing button clicked, remove product from shopping list
    func removeBtnInCell(cell: ProductListingVCell, indexPath: IndexPath) {
        cell.productAddRemoveBtn.tag = indexPath.row
        cell.productAddRemoveBtn.setTitle("-", for: .normal)
        cell.productAddRemoveBtn.addTarget(self, action: #selector(deleteButtonClicked(sender:)), for: .touchUpInside)
       
    }
    
    //Remove removed product from Core data and update previous screen badge
    @objc func deleteButtonClicked(sender: UIButton) {
        productDBHelper.decreaseProductSize(productId: productList[sender.tag].id!)
        getData()
        badgeDelegate!.reloadBadge()
          // cellDelegeta?.cellOnClick(index: btnIndexPath!.row)
       }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

