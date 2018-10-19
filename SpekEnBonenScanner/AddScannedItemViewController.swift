//
//  ScannedItemViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 21/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class AddScannedItemViewController: UIViewController {
    
    @IBOutlet weak var productNameView: UIView!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var addProductView: UIView!
    @IBOutlet weak var productBarcodeTextField: UITextField!
    var newProduct = Product()
    
    let database = CKContainer.default().publicCloudDatabase // TODO: Use shared to fetch changes only
    
    var barcode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productBarcodeTextField.text = barcode
        productNameTextField.delegate = self
        productBarcodeTextField.delegate = self
        
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    @IBAction func addProductButton(_ sender: Any) {
        
        guard let productName = productNameTextField.text else { return }
        guard let productBarcode = productBarcodeTextField.text else { return }
        newProduct.barcode = productBarcode
        newProduct.levelOneName = productName
        newProduct.save(from: newProduct)
    }
    
    func saveToCloud(name: String, barcode: String){
        
        let newProduct = CKRecord(recordType: "Products")
        
        newProduct.setValue(name, forKey: "levelOneProductName")
        newProduct.setValue(name, forKey: "levelTwoProductName")
        newProduct.setValue(name, forKey: "levelThreeProductName")
        newProduct.setValue(barcode, forKey: "productBarcode")
        
        database.save(newProduct, completionHandler: { ( record, error) in
            guard record != nil else { return }
        })
        
    }
}
extension AddScannedItemViewController: UITextFieldDelegate{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(AddScannedItemViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
