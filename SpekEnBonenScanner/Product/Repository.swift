//
//  Repository.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 19/10/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation

protocol ProductRepository {
    func find (by barcode: Barcode)->Product?
    func find (with productID: String)->Product?
}


