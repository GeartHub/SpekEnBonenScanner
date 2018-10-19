//
//  ProductCache.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 18/10/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import CloudKit

final class ProductCache: productRepository {
    static var instance: ProductCache = ProductCache()
    
    let database = CKContainer.default().publicCloudDatabase
    
    var productsArray: [Product] = []
    
    private init(){
    }
    
    func find (by barcode: Barcode) -> Product{
        if let product = productsArray.first(where: {$0.barcode  == barcode}){
            return product
        }else{
            return Product()
        }
    }
    
    func buildCache(){
        
        let query  = CKQuery(recordType: "Products" , predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { (records, _ ) in
            guard let records = records else { return }
            for record in records{
                self.productsArray.append(Product.init(from: record))
            }
        }
    }
    
}
