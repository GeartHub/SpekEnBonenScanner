//
//  Repository.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 19/10/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation

protocol productRepository {
    func find (by barcode: Barcode?, by productID: ProductID?)->Product
}


