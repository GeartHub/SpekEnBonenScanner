//
//  GroceryListTableViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 24/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class GroceryListTableViewController: UITableViewController {
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var productName: String = ""
    
    var product: Product?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.productNameLabel.text = self.productName
            self.productNameLabel.alpha = 1
        })
    }
}
