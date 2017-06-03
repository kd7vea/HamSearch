//
//  SearchTableViewController.swift
//  HamSearch
//
//  Created by Jake Estepp on 4/16/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, XMLParserDelegate {
   
    @IBOutlet var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    

    var key = String()
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = String()
    var returnedCall = String()
    var dxcc = String()
    var fname = String()
    var name = String()
    var firstName = String()
    var lastName = String()
    var lClass = String()
    var addr1 = String()
    var addr2 = String()
    var city = String()
    var state = String()
    var zip = String()
    var country = String()
    var lat = String()
    var lon = String()
    var grid = String()
    var county = String()
    var u_views = String()
    var moddate = String()
    var licenseClass = String()
    var codes = String()
    var image = String()
    var expdate = String()
    var timeZone = String()
    var gmtOffset = String()
    var login = String()
    var callSign = String()
    var GMtime = String()
    var errorMsg = String()
    var currentElement = String()
    var searchResults = [[String : AnyObject]]()
    var info = ["Call","Class","DXCC","First Name","Last Name","Address","City","State","Zip","County","Country","Lat.","Lon.","Grid"]
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      //  self.user = LoginViewController.sharedInstance.user
      //  self.password = LoginViewController.sharedInstance.password
        print (user)
        print (password)
        let callSign = searchBar.text!
        self.view.endEditing(true)
        beginParsing(callSign: callSign)
        }
    

    
    //XML parsing methods beginParsing, parser()
    func beginParsing(callSign : String)
    {
        posts = []
        
        let url: URL = URL(string: "http://xmldata.qrz.com/xml/current/?username=\(user);password=\(password);callsign=\(callSign)")!
        
        let parser = XMLParser(contentsOf:url)!
        
        
        print (url.absoluteString)
        print ("user")
        print (user)
        print("password")
        print (password)
        parser.delegate = self
        parser.parse()
        
    }
    
    //XMLParser Methods

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName
        currentElement = ""
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
        if element.isEqual("call") {
            currentElement += string
            callSign = currentElement
            licenseClass = ""
        } else if element.isEqual("class") {
            currentElement += string
            lClass = currentElement
            dxcc = ""
            // set license class from abbreviation
            if  (lClass) == "E"{
                licenseClass = "EXTRA"
                print("passed extra")
            }else if lClass == "A"{
                licenseClass = "ADVANCED"
            }else if lClass == "G"{
                licenseClass = "GENERAL"
            }else if lClass == "C"{
                licenseClass = "CLUB"
            }
            
        } else if element.isEqual("dxcc"){
            currentElement += string
            dxcc = currentElement
            fname = ""
        } else if element.isEqual("fname") {
            currentElement += string
            fname = currentElement
            name = ""
        } else if element.isEqual("name") {
            currentElement += string
            name = currentElement
            addr1 = ""
        } else if element.isEqual("addr1") {
           currentElement += string
            addr1 = currentElement
            city = ""
        } else if element.isEqual("addr2") {
            currentElement += string
            city = currentElement
            state = ""
        } else if element.isEqual("state") {
            currentElement += string
            state = currentElement
            zip = ""
        } else if element.isEqual("zip") {
            currentElement += string
            zip = currentElement as String
            county = ""
        } else if element.isEqual("county") {
            currentElement += string
            county = currentElement
            country = ""
        } else if element.isEqual("country") {
            currentElement += string
            country = currentElement
            lat = ""
        } else if element.isEqual("lat") {
            currentElement += string
            lat = currentElement
            lon = ""
        } else if element.isEqual("lon") {
            currentElement += string
            lon = currentElement
            grid = ""
        } else if element.isEqual("grid") {
            currentElement += string
            grid = currentElement
        }else if element.isEqual(""){
            key = currentElement
        }
        self.tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dataSource = self
        let row = indexPath.row
        let title = info[row]
        let Cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        Cell.detailTextLabel?.text = ""

        Cell.textLabel?.text = title
            switch title {
            case "Call":
                print (call)
                Cell.detailTextLabel?.text = ("\(callSign)")
            case "Class":
                Cell.detailTextLabel?.text = ("\(licenseClass)")
            case "DXCC":
                Cell.detailTextLabel?.text = ("\(dxcc)")
            case "First Name":
                Cell.detailTextLabel?.text = ("\(fname)")
            case "Last Name":
                Cell.detailTextLabel?.text = ("\(name)")
            case "Address":
                Cell.detailTextLabel?.text = ("\(addr1)")
            case "City":
                Cell.detailTextLabel?.text = ("\(city)")
            case "State":
                Cell.detailTextLabel?.text = ("\(state)")
            case "Zip":
                Cell.detailTextLabel?.text = ("\(zip)")
            case "County":
                Cell.detailTextLabel?.text = ("\(county)")
            case "Country":
                Cell.detailTextLabel?.text = ("\(country)")
            case "Lat.":
                Cell.detailTextLabel?.text = ("\(lat)")
            case "Lon.":
                Cell.detailTextLabel?.text = ("\(lon)")
            case "Grid":
                Cell.detailTextLabel?.text = ("\(grid)")
            default :
                Cell.detailTextLabel?.text = "error"
            }
        return Cell
    }
}
