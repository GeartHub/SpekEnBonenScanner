//
//  CodeViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 20/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import UIKit
import AVFoundation

class CodeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
            } else {
                
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewProductButton(_ sender: Any) {
        let alert = UIAlertController(title: "Voeg product toe", message: "Wij kennen dit product nog niet", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Naam"
        })
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Barcode"
        })
        let action = UIAlertAction(title: "Opslaan", style: .default , handler: { (_) in
            let name = alert.textFields!.first!.text!
            let barcode = alert.textFields!.last!.text!
            print("barcode: " + barcode, "naam: " + name)
            
            let product = Product(context: CoreDataStack.context)
            product.name = name
            product.barcode = barcode
            CoreDataStack.saveContext()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    @IBAction func unwindToHomeScreen(segue: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
}
