//
//  ChooseBuddyViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 31/10/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class ChooseBuddyViewController: UIViewController{
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = "Hallo, \(UserDefaults.standard.string(forKey: "Name")!)"
        nameLabel.adjustsFontSizeToFitWidth = true
        
    }
}
