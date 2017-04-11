//
//  Parser.swift
//  HamSearch
//
//  Created by Jake Estepp on 4/10/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import Foundation
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

func beginParsing(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]){
    posts = []
    let parser = XMLParser(contentsOf:(URL(string:"http://xmldata.qrz.com/xml/current/?username=kd7vea;password=kilodelta7"))!)!
    parser.parse()

}

func checkCredentials(didStartElement elementName: String){
    element = elementName
    if (elementName as NSString).isEqual(to: "Session")
    {
        if (elementName as NSString).isEqual(to: "Key"){
            login = "success"
        }else if (elementName as NSString).isEqual(to: "Error"){
            login = "failed"
        }
        
    }
    
}
