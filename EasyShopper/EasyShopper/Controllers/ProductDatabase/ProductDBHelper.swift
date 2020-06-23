//
//  ProductDatabaseHelper.swift
//  EasyShopper
//
//  Created by Mehmet Can Seyhan on 2020-06-20.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class ProductDBHelper {
    
    
    //Define variables
    var products: [NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext: NSManagedObjectContext!
    
    init() {
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Save product to Core Data
    func saveProduct(productId: String, products: Product) {
        if checkIfProductExist(productId: productId) {
            increaseProductSize(productId: productId)
            return
        }
      let entity =
        NSEntityDescription.entity(forEntityName: "ProductDB",
                                   in: managedContext)!
      
      let product = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      product.setValue(productId, forKeyPath: "productId")
      product.setValue(products.name, forKeyPath: "productName")
        product.setValue(products.retailPrice?.description, forKeyPath: "productPrice")
      product.setValue(products.imageUrl, forKeyPath: "productImageUrl")
        
      do {
        try managedContext.save()
        //products.append(product)
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    // Fetch product as type how we need
    func fetchProduct() -> [Product]? {

        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "ProductDB")
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                let products = try managedContext.fetch(fetchRequest)
                
                var productData: [Product] = []
                for data in products {
                                        
                    productData.append(Product(name: data.value(forKey: "productName") as? String, barcode: nil, description: nil, id: data.value(forKey: "productId") as? String, imageUrl: data.value(forKey: "productImageUrl") as? String, retailPrice: Int((data.value(forKey: "productPrice") as? String)!), size: data.value(forKey: "productSize") as? Int))
                }
                return productData
            } else {
                return nil
            }
        } catch let error as NSError {
            return nil
          //print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    //If product is added, increase product counter
    func increaseProductSize(productId: String) {
        
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ProductDB")
        fetchRequest.predicate = NSPredicate(format: "productId = %@", productId)
        do {
            let product = try managedContext.fetch(fetchRequest)
            let objectUpdate = product[0] as! NSManagedObject
            
            let productSize:Int = objectUpdate.value(forKey: "productSize")! as! Int
            
            objectUpdate.setValue(productSize + 1,forKey: "productSize")
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
            
        }catch {
            print(error)
        }
    }
    
    //If product is added, decrease product counter
    func decreaseProductSize(productId: String) {
        
        if !checkIfProductExist(productId: productId) {
            return
        }
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ProductDB")
        fetchRequest.predicate = NSPredicate(format: "productId = %@", productId)
        do {
            let product = try managedContext.fetch(fetchRequest)
            let objectUpdate = product[0] as! NSManagedObject
            
            let productSize:Int = objectUpdate.value(forKey: "productSize")! as! Int
            
            if productSize == 1 {
                deleteProduct(productId: productId)
                return
            }
            
            objectUpdate.setValue(productSize - 1,forKey: "productSize")
            
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
            
        }catch {
            print(error)
        }
        
    }
    
    //Delete product from core data
    func deleteProduct(productId: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductDB")
        fetchRequest.predicate = NSPredicate(format: "productId = %@", productId)
        
        do {
            let product = try managedContext.fetch(fetchRequest)
            let objectToDelete = product[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
            } catch {
                
                print(error)
            }
            
        } catch {
            print(error)
        }
        
    }
    
    
    //This return us, if product exist or no
    func checkIfProductExist(productId: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ProductDB")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "productId == %@" ,productId)
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    //Delete all product, so clean local database
    func deleteAllData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductDB")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try managedContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                managedContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data error :", error)
        }
    }
}
