//
//  ScannedItemViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 21/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class ScannedItemViewController: UIViewController {
    
    @IBOutlet weak var productNameView: UIView!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var addProductView: UIView!
    @IBOutlet weak var productBarcodeTextField: UITextField!
    
    var products: [Product] = []
    var barcode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProducts()
        
        productNameTextField.delegate = self
        productBarcodeTextField.delegate = self
        
        let product = products.first(where: {$0.barcode == barcode})
        
        if product == nil{
            newProduct(with: barcode)
        }else{
            showProductInformation(with: product!)
        }
    }
    func newProduct(with barcode: String){
        UIView.animate(withDuration: 0.5, animations: {
            self.addProductView.alpha = 1
            self.productNameView.alpha = 1
            
        })
        productNameTextField.isUserInteractionEnabled = true
        productBarcodeTextField.text = barcode
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    func showProductInformation(with product: Product){
        UIView.animate(withDuration: 0.5, animations: {
            self.productNameView.alpha = 1
            self.productNameTextField.text = product.name
        }, completion: nil)
    }
    @IBAction func addProductButton(_ sender: Any) {
        let product = Product(context: CoreDataStack.context)
        product.name = productNameTextField.text
        product.barcode = productBarcodeTextField.text
        CoreDataStack.saveContext()
        fetchProducts()
    }
    func fetchProducts(){
        let context = CoreDataStack.context
        do {
            products = try context.fetch(Product.fetchRequest())
        }
        catch{
            print("Cant find any products")
        }
    }
}
extension ScannedItemViewController: UITextFieldDelegate{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(ScannedItemViewController.dismissKeyboard))
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
