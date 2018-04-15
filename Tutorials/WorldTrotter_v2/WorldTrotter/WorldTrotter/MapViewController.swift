//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Julien Esposito on 4/15/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController
{
    var mapView: MKMapView!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "MapViewController loaded its view.")
    }
}
