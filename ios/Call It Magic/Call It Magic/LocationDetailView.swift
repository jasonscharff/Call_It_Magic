//
//  LocationDetailView.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

var locationObject = AnalyzedLocationObject(); //Set before transition to the new VC

private var map : MKMapView = MKMapView()
private var annotation : MKPointAnnotation = MKPointAnnotation()

class LocationDetaiLView : UIViewController {
  
  //MARK: View States
  override func viewDidLoad() {
    super.viewDidLoad();
    setLocation(locationObject.latitude, longitude: locationObject.longitude);
  }
  
  //MARK: Set up UI
  private func setLocation(latitude : Double, longitude : Double) {
    //Set map
    map.removeAnnotation(annotation);
    var coord : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
    var span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025);
    var region : MKCoordinateRegion = MKCoordinateRegion(center: coord, span: span)
    map.setRegion(region, animated: false);
    //Set pin
    annotation.coordinate = coord;
    map.addAnnotation(annotation);
  }
  
  private func addTextualInformation() {
    
  }
  
  private func addActions() {
    
  }
  
  
  
}
