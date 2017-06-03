//
//  LoginViewController.swift
//  HamSearch
//
//  Created by Jake Estepp on 4/10/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import UIKit

var user = String()
var password = String()

class LoginViewController: UIViewController, XMLParserDelegate {
   
    var key = NSMutableString()
    var parser = XMLParser()
    var element = String()
    static let sharedInstance = LoginViewController()

    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var loginMessage: UILabel!
    
    @IBAction func SaveButtonTapped(_ sender: UIButton) {
        user = userNameTextField.text!
        password = passwordTextField.text!
        
        UserDefaults.standard.set(user, forKey: user)
        UserDefaults.standard.set(password, forKey: password)
        userNameTextField.text = ""
        passwordTextField.text = ""
    
        if(user == "" || password == ""){
            warningLabel.text = "Enter Callsign and Password" // if user or password are blank, error message is posted
        }else{
            self.beginParsing()  //if the user, and password text boxes are not blank, the parser is called
            userNameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
        }
    }
//XML parsing methods beginParsing, parser()
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:"http://xmldata.qrz.com/xml/current/?username=\(user);password=\(password)"))!)!
        parser.delegate = self
        parser.parse()
    }
    
    //XMLParser Methods
   
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
       element = elementName
        if (elementName as NSString).isEqual(to: "Session")
        {
            elements = NSMutableDictionary()
            elements = [:]
            key = NSMutableString()
            key = ""
        }
    }
 
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "Session") {
            if !key.isEqual(nil) {
                elements.setObject(key, forKey: "Key" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual("Key") {
        warningLabel.text = "Credentials Authenticated"
        } else if element.isEqual("Error"){
            warningLabel.text = "User name or Password incorrect"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }


/*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if warningLabel.text == "Credentials Authenticated"{
        let DestViewController : SearchTableViewController = segue.destination as! SearchTableViewController
        
        DestViewController.user = userNameTextField.text!
        DestViewController.password = passwordTextField.text!
        }
    }
 */

}
