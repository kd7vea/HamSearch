//
//  SearchTableViewController.swift
//  HamSearch
//
//  Created by Jake Estepp on 4/16/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import UIKit

class SearchTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tableView: UITableView!

    var user = String()
    var password = String()
    var key = NSMutableString()
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = String()
    var call = NSMutableString()
    var dxcc = NSMutableString()
    var fname = NSMutableString()
    var name = NSMutableString()
    var addr1 = NSMutableString()
    var addr2 = NSMutableString()
    var state = NSMutableString()
    var zip = NSMutableString()
    var country = NSMutableString()
    var lat = NSMutableString()
    var lon = NSMutableString()
    var grid = NSMutableString()
    var county = NSMutableString()
    var u_views = NSMutableString()
    var moddate = NSMutableString()
    var LicenseClass = NSMutableString()
    var codes = NSMutableString()
    var image = NSMutableString()
    var expdate = NSMutableString()
    var timeZone = NSMutableString()
    var gmtOffset = NSMutableString()
    var login = NSMutableString()

    var info = ["Call","Class","DXCC","Name","Address","City","State","Zip","county","Country","Lat.","Lon.","Grid"]
    
    
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
        let Cell = UITableViewCell()
        Cell.textLabel?.text = info[indexPath.row]
        return Cell
    }

}
