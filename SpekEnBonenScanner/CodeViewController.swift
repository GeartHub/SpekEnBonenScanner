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
    
    @IBOutlet weak var parentsLoginView: UIView!
    @IBOutlet weak var parentsLoginQuestionLabel: UILabel!
    @IBOutlet weak var parentsLoginAnswerTextField: UITextField!
    @IBOutlet weak var parentLoginCloseButton: UIButton!
    
    var number: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        number = Int.random(in: 1 ... 10)
        
        parentsLoginQuestionLabel.text = String(number) + " * " + "10"
        self.navigationItem.backBarButtonItem?.title = ""
        //Camera
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
            } else {
                
            }
        }
        setupView()
        
        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        parentsLoginView.isHidden = true
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard(){
        print("test")
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func parentsLoginButton(){
        UIView.animate(withDuration: 0.5, animations: {
            self.parentsLoginView.isHidden = false
            
        })
        parentsLoginAnswerTextField.keyboardType = .numberPad
    }
    
    @IBAction func closeParentsLoginButton(){
        UIView.animate(withDuration: 0.5, animations: {
            self.parentsLoginView.isHidden = true
        self.parentsLoginAnswerTextField.resignFirstResponder()
        })
    }
    
    @IBAction func checkAnswer(){
        if (Int(parentsLoginAnswerTextField.text!) == (number * 10)){
            performSegue(withIdentifier: "parentsLoggedInSegue", sender: self)
        }else{
            parentsLoginAnswerTextField.resignFirstResponder()
            parentsLoginView.isHidden = true
        }
    }
}
