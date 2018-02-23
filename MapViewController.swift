//
//  MapViewController.swift
//  HamSearch
//
//  Created by Jake Estepp on 6/6/17.
//  Copyright © 2017 Jake Estepp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        setmap()
    }
    
    func setmap(){
    loc = CLLocationCoordinate2DMake((lat as NSString).doubleValue, (lon as NSString).doubleValue )
        
  //  var span = MKCoordinateSpanMake( 0.2, 0.2)
  //  let region = MKCoordinateRegionMake(loc, span)
    map.setRegion(region, animated: true)
        
    //annotation = MKPointAnnotation()
    annotation.coordinate = CLLocationCoordinate2DMake((lat as NSString).doubleValue, (lon as NSString).doubleValue)
    annotation.title = call as String
    annotation.subtitle = grid as String
    map.addAnnotation(annotation)
    }

    func clearData(){
        print("clearData running")
    loc = CLLocationCoordinate2DMake(0.0, 0.0)
    annotation.title = ""
    annotation.subtitle = ""
    
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
