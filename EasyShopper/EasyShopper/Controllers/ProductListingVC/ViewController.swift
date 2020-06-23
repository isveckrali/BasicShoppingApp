//
//  ViewController.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import UIKit


#warning("""
The initial viewcontroller should show the shopping basket.
It should contain a 'Plus' button for adding new items to the basket.
It should contain a 'Clear' button for removing all items in the basket.
""")

class ProductVC: UIViewController{
    
    let networkServiceMock:NetworkServiceMock = NetworkServiceMock()
    
    let productsTableView: UITableView = UITableView()
    var productList: [String: Product]?
    
    let sSBadgeButton:SSBadgeButton = SSBadgeButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpMainView()
        setUpNavigation()
        createViews()
        tableViewSettings()
        getData()
        addRightBadge()
    }
    
    func addRightBadge() {
        let cartButton = SSBadgeButton()

            cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            cartButton.setImage(UIImage(named: "menu")?.withRenderingMode(.alwaysTemplate), for: .normal)
            cartButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
            cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
            cartButton.badge = "4"

            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: cartButton)]
    }
    
    @objc func cartButtonTapped() {
        
        
    }
    func setUpMainView() {
        view.backgroundColor = .red
    }
    
    func setUpNavigation() {
     navigationItem.title = "List of products"
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
     self.navigationController?.navigationBar.isTranslucent = false
     self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    func createViews() {
        view.addSubview(productsTableView)
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [ productsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor), productsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor), productsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor), productsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor) ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    func getData() {
        networkServiceMock.fetchProducts { (result) in
            switch result {
            case .failure(let error):
                print("error \(error)")
            case .success(let product):
                self.productList = product
                self.productsTableView.reloadData()
            }
        }
    }
    
    
    
    
}

extension ProductVC:  UITableViewDataSource, UITableViewDelegate {
    
    func tableViewSettings() {
        productsTableView.register(ProductListingVCell.self, forCellReuseIdentifier: "productListingVCell")
        productsTableView.dataSource = self
        productsTableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListingVCell", for: indexPath) as! ProductListingVCell
        
        cell.productVM = ProductVM(productList: productList![Array(productList!.keys)[indexPath.row]]!)
        addBtnInCellConfiguration(cell: cell, indexPath: indexPath)

      return cell
    }
    
    func addBtnInCellConfiguration(cell: ProductListingVCell, indexPath: IndexPath) {
        cell.productAddBtn.tag = indexPath.row
        cell.productAddBtn.addTarget(self, action: #selector(addButtonClicked(sender:)), for: .touchUpInside)
    }
    
    @objc func addButtonClicked(sender: UIButton) {
        print("click 1 \(sender.tag)")
          // cellDelegeta?.cellOnClick(index: btnIndexPath!.row)
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
}



