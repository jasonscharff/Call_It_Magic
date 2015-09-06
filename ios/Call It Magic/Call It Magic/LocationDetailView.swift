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



class LocationDetailView : UIViewController {
  
  var locationObject : AnalyzedLocationObject = AnalyzedLocationObject(); //Set before transition to the new VC
  
  private var map : MKMapView = MKMapView()
  private var annotation : MKPointAnnotation = MKPointAnnotation()
  
  //MARK: View States
  override func viewDidLoad() {
    super.viewDidLoad();
    self.view.backgroundColor = UIColor.whiteColor();
    self.title = locationObject.storeName;
    setLocation(locationObject.latitude, longitude: locationObject.longitude);
    addTextualInformation()
    addActions()
  }
  
  //MARK: Set up UI
  private func setLocation(latitude : Double, longitude : Double) {
    self.view.addSubview(map);
    //Set map
    var coord : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
    var span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025);
    var region : MKCoordinateRegion = MKCoordinateRegion(center: coord, span: span)
    map.setRegion(region, animated: false);
    //Set pin
    annotation.coordinate = coord;
    map.addAnnotation(annotation);
    
    map.snp_makeConstraints { (make) -> Void in
      make.topMargin.equalTo(Constants.navbarHeight + 10)
      make.left.equalTo(10);
      make.right.equalTo(-10);
      make.height.equalTo((self.view.frame.size.height - CGFloat(Constants.navbarHeight - 10))/3)
    }
  }
  
  private func addTextualInformation() {
    var textView : DetailedTextualInformationView = DetailedTextualInformationView(object: locationObject);
    self.view.addSubview(textView);
    textView.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10);
      make.right.equalTo(-10);
      make.top.equalTo(self.map.snp_bottom).offset(5);
    }
    
  }
  
  private func addActions() {
    
  }
  
  
  
}
