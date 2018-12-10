//
//  UserNameViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 31/10/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class ChildNameViewController: UIViewController{
    
    @IBOutlet weak var textFieldName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldName.setBottomBorder()
        print(UserDefaults.standard.string(forKey: "Name"))
    }
    
    @IBAction func saveName(_ sender: Any) {
        UserDefaults.standard.set(textFieldName.text, forKey: "Name")
    }
}
