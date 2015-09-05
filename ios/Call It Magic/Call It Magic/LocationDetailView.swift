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
    self.title = locationObject.storeName;
    setLocation(locationObject.latitude, longitude: locationObject.longitude);
    addTextualInformation()
    addActions()
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
    
    map.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(Constants.navbarHeight + 10)
      make.left.equalTo(10);
      make.right.equalTo(10);
      make.height.equalTo((self.view.frame.size.height - CGFloat(Constants.navbarHeight - 10))/3)
    }
  }
  
  private func addTextualInformation() {
    var topLabel = UILabel();
    topLabel.text = locationObject.storeName;
    topLabel.font = UIFont(name: "HelveticaNeue", size: 20);
//    topLabel.snp_makeConstraints { (make) -> Void in
//      make.top.equalTo(<#other: CGFloat#>)
//    }
  }
  
  private func addActions() {
    
  }
  
  
  
}
