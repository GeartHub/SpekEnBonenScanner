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
typealias ProductID = String


final class Product {
    
    let database = CKContainer.default().publicCloudDatabase
    
    var CKProductsArray = [CKRecord]()
    var products: [Product] = []
   
    //TODO: Name array for lvls
    public var levelOneName: String?
    public var levelTwoName: String?
    public var levelThreeName: String?
    public var barcode: String?
    public var productID: String?
    public var scanStatus: Bool?
    
    init() {
    }
    
    init(from: CKRecord) {
        levelOneName = from.value(forKey: "levelOneProductName") as? String
        levelTwoName = from.value(forKey: "levelTwoProductName") as? String
        levelThreeName = from.value(forKey: "levelThreeProductName") as? String
        barcode = from.value(forKey: "productBarcode") as? String
        productID = from.recordID.recordName
        scanStatus = false
    }
    
    func save(from newProduct: Product){
        let newCKRecord = CKRecord(recordType: "Products")
        
        newCKRecord.setValue(newProduct.levelOneName, forKey: "levelOneProductName")
        newCKRecord.setValue(newProduct.levelTwoName, forKey: "levelTwoProductName")
        newCKRecord.setValue(newProduct.levelThreeName, forKey: "levelThreeProductName")
        newCKRecord.setValue(newProduct.barcode, forKey: "productBarcode")
        
        database.save(newCKRecord, completionHandler: { ( record, error) in
            guard record != nil else { return }
        })
    }

}