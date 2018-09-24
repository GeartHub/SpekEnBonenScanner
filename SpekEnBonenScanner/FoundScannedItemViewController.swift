//
//  FoundScannedItemViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 24/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class FoundScannedItemViewController: UIViewController {
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    var productName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        UIView.animate(withDuration: 3, animations: {
            self.productNameLabel.text = self.productName
            self.productNameLabel.alpha = 1
        })
    }
}
