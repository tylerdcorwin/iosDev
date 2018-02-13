//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by Corwin, Tyler D on 2/6/18.
//  Copyright © 2018 Corwin, Tyler D. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController{
    var mapView: MKMapView!
    
    override func loadView() {
        //create a mapview
        mapView = MKMapView()
        
        //set it as *the* view of this view controller
        view = mapView
        
        //let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])3
        let standardString = NSLocalizedString("Standard", comment: "Standard map View")
        let satelliteString = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Standard map View")
        let segmentedControl = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
//        changed from topLayoutGuide.bottomAnchor
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
//        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
//        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
    }
    
    //@objc is an interface for the mapTypeChanged as the selector
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex{
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
        
        print("MapViewController loaded its view")
    }
    
    
}
