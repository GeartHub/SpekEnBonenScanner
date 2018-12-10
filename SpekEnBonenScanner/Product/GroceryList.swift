//
//  GroceryList.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 26/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation

final class GroceryList{
    
    static var instance: GroceryList = GroceryList()
    
    private var localStorage: [Product] = []
    
    var groceryListUserDefaultsArray: [String] = []
    var defaults = UserDefaults.standard
    
    var productCache: ProductRepository = ProductCache.instance
    
    var count : Int {
        return localStorage.count
    }
    
    func find(by productID: ProductID) -> Product?{
        if let product = localStorage.first(where: {$0.productID  == productID}){
            product.scanStatus = true
            return product
        }
        return nil
    }
    
    subscript (index: Int) -> Product {
        return localStorage[index]
    }
    func saveToUserDefaults(from array: [Product]){
        groceryListUserDefaultsArray = array.map{$0.productID!}
        
        defaults.set(groceryListUserDefaultsArray, forKey: "groceryList")
        
    }
    func loadUserDefaults(){
        groceryListUserDefaultsArray = defaults.stringArray(forKey: "groceryList")!
        localStorage = [Product]()
        for item in groceryListUserDefaultsArray{
            buildLocalGroceryCache(productID: item)
        }
    }
    func empty(){
        localStorage = [Product]()
        
        defaults.set(localStorage, forKey: "groceryList")
    }
    
    func buildLocalGroceryCache(productID: String){
        localStorage.append(productCache.find(with: productID)!)
    }
}
