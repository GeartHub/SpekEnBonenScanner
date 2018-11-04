//
//  GroceryListForParentTableViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 02/11/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import Foundation
import UIKit

class GroceryListForParentTableViewController: UIViewController {
    
    @IBOutlet weak var groceryListTableView: UITableView!
    
    
    var test = "test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addItem(){
        print(UserDefaults.standard.array(forKey: "groceryListArray"))
        var myarray = UserDefaults.standard.stringArray(forKey: "groceryListArray") ?? [String]()

        myarray.append(test)
        
        UserDefaults.standard.set(myarray, forKey: "groceryListArray")
        print(UserDefaults.standard.array(forKey: "groceryListArray"))
        print(myarray)
        
    }
}

extension GroceryListForParentTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GroceryListCell
        
        cell.groceryListItem.text = "hoi"
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
