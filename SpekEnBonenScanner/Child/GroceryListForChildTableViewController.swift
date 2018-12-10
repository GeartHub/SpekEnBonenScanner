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

class GroceryListForChildTableViewController: UIViewController {
    
    @IBOutlet weak var groceryListTableView: UITableView!
    
    var product: Product!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var productInformationLabel: UILabel!
    @IBOutlet weak var nextItemLabel: UILabel!
    
    var groceryList: GroceryList = GroceryList.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groceryList.loadUserDefaults()
        print(groceryList.count)
        checkGroceryList()
    }
    func checkGroceryList(){
        //TODO: andere text "yayyy" met emoticon.
        feedbackLabel.text = "Goed gescant!"
        productInformationLabel.text = "Je hebt \(product.levelOneName!) gevonden!"
    }
}
extension GroceryListForChildTableViewController: UITableViewDataSource{
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GroceryListCell
        
        cell.groceryListItem.text = groceryList[indexPath.row].levelOneName
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
}
