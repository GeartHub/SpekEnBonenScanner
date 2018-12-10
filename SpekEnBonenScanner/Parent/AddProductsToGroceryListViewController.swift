//
//  AddProductsToGroceryListViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 23/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class AddProductsToGroceryListViewController: UIViewController{
    @IBOutlet weak var ProductTableView: UITableView!
    @IBOutlet weak var popOverView: UIView!
    
    let defaults  = UserDefaults.standard
    var groceryList = GroceryList.instance
    var groceryListForParentsVC = GroceryListForParentTableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popOverView.layer.cornerRadius = 40
        ProductTableView.delegate = self
        ProductTableView.dataSource = self
    }
    @IBAction func dismissVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func AddProductsToGroceryList(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: self)
    }
}
extension AddProductsToGroceryListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = ProductCache.instance.productsArray[indexPath.row]
        groceryList.localStorage.append(product)
        
        let cell = ProductTableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        cell?.selectionStyle = .none
    }
}

extension AddProductsToGroceryListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductCache.instance.productsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bell") as! AddToGroceryListCell
        
        cell.itemToAddLabel.text = ProductCache.instance.productsArray[indexPath.row].levelOneName
        
        return cell
    }
    
    
}
