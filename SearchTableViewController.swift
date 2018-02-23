//
//  SearchTableViewController.swift
//  HamSearch
//
//  Created by Jake Estepp on 4/16/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import UIKit
import MapKit

var loc = CLLocationCoordinate2DMake((lat as NSString).doubleValue, (lon as NSString).doubleValue )
var span = MKCoordinateSpanMake( 0.2, 0.2)
var region = MKCoordinateRegionMake(loc, span)
var annotation = MKPointAnnotation()
var key = String()
var parser = XMLParser()
var posts = NSMutableArray()
var elements = NSMutableDictionary()
var element = String()
var returnedCall = String()
var call = String()
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

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, XMLParserDelegate {
   
    @IBOutlet var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let callSign = searchBar.text!
        self.view.endEditing(true)
        
        searchBar.text = ""
        call = ""
        licenseClass = ""
        dxcc = ""
        fname = ""
        name = ""
        addr1 = ""
        city = ""
        state = ""
        zip = ""
        county = ""
        country = ""
        lat = ""
        lon = ""
        grid = ""
       
        beginParsing(callSign: callSign)
        }
    

    
    //XML parsing methods beginParsing, parser()
    func beginParsing(callSign : String)
    {
        if let globalUser = UserDefaults.standard.object(forKey: "user") as? String{
            user = globalUser
        }
        if let globalPassword = UserDefaults.standard.object(forKey: "password") as? String{
            password = globalPassword
        }

        posts = []
        
        let url: URL = URL(string: "http://xmldata.qrz.com/xml/current/?username=\(user);password=\(password);callsign=\(callSign)")!
        
        let parser = XMLParser(contentsOf:url)!
        
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
            call = currentElement
        } else if element.isEqual("class") {
            currentElement += string
            lClass = currentElement
            // set license class from abbreviation
            if  (lClass) == "E"{
                licenseClass = "EXTRA"
            }else if lClass == "A"{
                licenseClass = "ADVANCED"
            }else if lClass == "G"{
                licenseClass = "GENERAL"
            }else if lClass == "T"{
                licenseClass = "TECHNICIAN"
            }else if lClass == "C"{
                licenseClass = "CLUB"
            }
        
        } else if element.isEqual("dxcc"){
            currentElement += string
            dxcc = currentElement
        } else if element.isEqual("fname") {
            currentElement += string
            fname = currentElement
        } else if element.isEqual("name") {
            currentElement += string
            name = currentElement
        } else if element.isEqual("addr1") {
           currentElement += string
            addr1 = currentElement
        } else if element.isEqual("addr2") {
            currentElement += string
            city = currentElement
        } else if element.isEqual("state") {
            currentElement += string
            state = currentElement
        } else if element.isEqual("zip") {
            currentElement += string
            zip = currentElement as String
        } else if element.isEqual("county") {
            currentElement += string
            county = currentElement
        } else if element.isEqual("country") {
            currentElement += string
            country = currentElement
        } else if element.isEqual("lat") {
            currentElement += string
            lat = currentElement
        } else if element.isEqual("lon") {
            currentElement += string
            lon = currentElement
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
                Cell.detailTextLabel?.text = ("\(call)")
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
