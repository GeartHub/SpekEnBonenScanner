//
//  ProductClass.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 12/10/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import CloudKit

typealias Barcode = String

class Product {
    
    static let database = CKContainer.default().publicCloudDatabase // TODO: Use shared to fetch changes only
    
    static var products = [CKRecord]()
    
    static var lastFoundProduct: CKRecord!
    
    static func findBarcode (barcode: Barcode){
        lastFoundProduct = nil
        let product = products.first(where: {$0.value(forKey: "productBarcode")as? String  == barcode})
        if product != nil{
            lastFoundProduct = product
        }
    }
    
    static func queryDatabase(){
        let query  = CKQuery(recordType: "Products" , predicate: NSPredicate(value: true))

        database.perform(query, inZoneWith: nil) { (records, _ ) in
            guard let records = records else { return }
            products = records
            print(products)
        }
    }
    static func checkChanges(){
        
    }

}
