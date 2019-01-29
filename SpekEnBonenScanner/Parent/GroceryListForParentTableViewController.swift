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
    
    let productCache: ProductRepository = ProductCache.instance
    let defaults  = UserDefaults.standard
    
    let groceryList = GroceryList.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groceryListTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        groceryList.loadUserDefaults()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func resetGroceryList(_ sender: Any){
        
        groceryList.empty()
        let alert = UIAlertController(title: "Boodschappenlijst geleegd", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        loadList()

    }
    @objc func loadList(){
        groceryListTableView.reloadData()
    }
}

extension GroceryListForParentTableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! GroceryListCell
        
        cell.groceryListItem.text = groceryList[indexPath.row].levelOneName

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
}
