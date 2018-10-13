//
//  GroceryListTableViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 24/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class GroceryListTableViewController: UITableViewController {
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var product: CKRecord!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(product)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.productNameLabel.text = self.product?.value(forKey: "levelOneProductName") as? String
            self.productNameLabel.alpha = 1
        })
    }
}
