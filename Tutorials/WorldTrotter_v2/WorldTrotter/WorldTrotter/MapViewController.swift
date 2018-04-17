//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Julien Esposito on 4/15/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate
{
    var mapView: MKMapView!
    
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        let segmentedControl = UISegmentedControl( items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent( 0.5 )
        segmentedControl.selectedSegmentIndex = 0

        // You will need to add @objc to the function declaration. Until swift 4 this was implicitly inferred.
        segmentedControl.addTarget(self, action: #selector( MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        

        
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint( equalTo: topLayoutGuide.bottomAnchor, constant: 8 )
        let leadingConstraint = segmentedControl.leadingAnchor.constraint( equalTo: margins.leadingAnchor )
        let trailingConstraint = segmentedControl.trailingAnchor.constraint( equalTo: margins.trailingAnchor )
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
        let zoomLocationControl = UIButton(  )
        zoomLocationControl.setTitleColor(UIColor.blue, for: .normal)
        zoomLocationControl.frame = CGRect(x:15, y:+50, width:100, height:100)
        zoomLocationControl.setTitle("zoom", for: .normal)
        var color = UIColor.darkGray
        color = color.withAlphaComponent(0.5)
        zoomLocationControl.backgroundColor = color
        view.addSubview(zoomLocationControl)
    }
    
    @objc func mapTypeChanged( _ segControl: UISegmentedControl ) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print( "MapViewController loaded its view.")
    }
}
