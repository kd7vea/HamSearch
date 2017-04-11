//
//  LoginViewController.swift
//  HamSearch
//
//  Created by Jake Estepp on 4/10/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var user = String()
    var password = String()
    var key = NSMutableString()

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var loginMessage: UILabel!
    
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        user = userNameTextField.text!
        password = passwordTextField.text!
        if(user == "" || password == ""){
            warningLabel.text = "Enter Callsign and Password"
        }else{
            warningLabel.text = ""
            checkCredentials(didStartElement: <#String#>)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
