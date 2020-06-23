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

class ProductVC: UIViewController {
    
    
    //Define variables
    let networkServiceMock:NetworkServiceMock = NetworkServiceMock()
    
    let productsTableView: UITableView = UITableView()
    var productList: [String: Product] = [:]
    
    let sSBadgeButton:SSBadgeButton = SSBadgeButton()
    let cartButton = SSBadgeButton()
    
    let productDBHelper: ProductDBHelper = ProductDBHelper()
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //productDBHelper.deleteAllData()
        
        //Call first step functions, when screen is loading
        setUpNavigation()
        createViews()
        tableViewSettings()
        addSpinner(activityIndicator: activityIndicator)
        addRightBadge()
        setBadgeCount()
        getData()
        
        
    }
    
    //Add right bar button with badge
    func addRightBadge() {
            cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
            cartButton.setImage(UIImage(named: "shoppingBasket")?.withRenderingMode(.alwaysTemplate), for: .normal)
            cartButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
            cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
            cartButton.badge = "0"
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: cartButton)]
    }
    
    //When badge ckick, open shopping list
    @objc func cartButtonTapped() {
        let shoppingBasket = ShoppingBasketVC()
        shoppingBasket.badgeDelegate = self
        self.navigationController?.pushViewController(shoppingBasket, animated: true)
    }
    
    //Set up navigation properties like color.
    func setUpNavigation() {
     navigationItem.title = "List of products"
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
     self.navigationController?.navigationBar.isTranslucent = false
     self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor:UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
    }
    
    //View add super view and set up it's contraints
    func createViews() {
        view.addSubview(productsTableView)
        productsTableView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            productsTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            productsTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            productsTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            productsTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    //Get data from server via func.
    func getData() {
        guard NetworkController.isConnectedToNetwork() else {
            Helper.dialogMessage(message: "please check you internet connection", vc: self)
            return
        }
        networkServiceMock.fetchProducts(url: Services.BASE_URL) { (result) in
            switch result {
            case .failure(let error):
                Helper.dialogMessage(message: "\(error)", vc: self)
                break
            case .success(let product):
                self.productList = product
                DispatchQueue.main.async {
                self.productsTableView.reloadData()
                }
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

//Extension provide us to do impementing, for here about Table view Delegates
extension ProductVC:  UITableViewDataSource, UITableViewDelegate {
    
    func tableViewSettings() {
        
        productsTableView.estimatedRowHeight = 100
        productsTableView.rowHeight = UITableView.automaticDimension
        
        productsTableView.register(ProductListingVCell.self, forCellReuseIdentifier: "productListingVCell")
        productsTableView.dataSource = self
        productsTableView.delegate = self
        
       // productsTableView.tableFooterView = UIView()
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productListingVCell", for: indexPath) as! ProductListingVCell
        cell.productVM = ProductVM(productList: productList[Array(productList.keys)[indexPath.row]]!)
        addBtnInCell(cell: cell, indexPath: indexPath)

      return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailVC()
        detailVC.prodcutVM = ProductVM(productList: productList[Array(productList.keys)[indexPath.row]]!)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Adjust product add button tag by cell number
    func addBtnInCell(cell: ProductListingVCell, indexPath: IndexPath) {
        cell.productAddRemoveBtn.tag = indexPath.row
        
        cell.productAddRemoveBtn.setTitle("+", for: .normal)
        cell.productAddRemoveBtn.addTarget(self, action: #selector(addButtonClicked(sender:)), for: .touchUpInside)
       
    }
    
    //When product add button clicked, Add product to database for shopping list
    @objc func addButtonClicked(sender: UIButton) {
        productDBHelper.saveProduct(productId: Array(productList.keys)[sender.tag], products: productList[Array(productList.keys)[sender.tag]]!)
        
        setBadgeCount()
        
        // cellDelegeta?.cellOnClick(index: btnIndexPath!.row)
    }
    
    //Observe shopping list badge and then set up
    func setBadgeCount() {
        let products = productDBHelper.fetchProduct()
        var badgeCounter:Int = 0
        if let products = products {
            for product in products {
                badgeCounter += product.size!
            }
        }
        self.cartButton.badge = badgeCounter.description

    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
    }
    
}

extension ProductVC: BadgeDelegate {
    func reloadBadge() {
           setBadgeCount()
    }
}


