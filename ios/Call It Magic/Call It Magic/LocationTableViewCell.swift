//
//  LocationTableViewCell.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class LocationTableViewCell: UITableViewCell {
  
  private var map : MKMapView;
  private var annotation : MKPointAnnotation;
  private var storeLabel : UILabel;
  private var productLabel : UILabel;
  private var distanceLabel : UILabel;
  
  
  var storeLabelText : String {
    didSet {
      storeLabel.text = storeLabelText;
    }
  }
  var distanceLabelText : String {
    didSet {
      distanceLabel.text = distanceLabelText;
    }
  }
  
  var productLabelText : String {
    didSet {
      productLabel.text = productLabelText;
    }
  }
  
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    map = MKMapView()
    annotation = MKPointAnnotation()
    storeLabel = UILabel();
    distanceLabel = UILabel();
    productLabel = UILabel();
    storeLabelText = "";
    distanceLabelText = "";
    productLabelText = "";
    super.init(style: style, reuseIdentifier: reuseIdentifier);
    setProperties()
    setupLayout()
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  func setFromData(object : LocationObject, location: CLLocation) {
    setLocation(object.latitude, longitude: object.longitude);
    self.storeLabel.text = object.storeName;
    self.productLabel.text = object.productName
    var placeLoc : CLLocation = CLLocation(latitude: object.latitude, longitude: object.longitude);
    var distance = location.distanceFromLocation(placeLoc);
    distance *= 3.28;
    if(distance >= 5280) {
      distance /= 5280;
      self.distanceLabel.text = String(stringInterpolationSegment: (Double(round(10*distance)/10))) + " miles";
    }
    else {
      self.distanceLabel.text =  String(100 * Int(round(distance / 100.0))) + " feet";
    }
    
  }
  
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
  
  
  private func setProperties() {
    map.scrollEnabled = false;
    map.zoomEnabled = false;
    storeLabel.font = UIFont(name: "HelveticaNeue", size: 20);
    productLabel.font = UIFont(name: "HelveticaNeue", size:16);
    distanceLabel.font = UIFont(name:"HelveticaNeue", size:12);
  }
  
  private func setupLayout() {
    var padding : UIEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.addSubview(map);
    self.addSubview(storeLabel);
    self.addSubview(productLabel);
    self.addSubview(distanceLabel);
    map.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self).offset(padding.left);
      make.top.equalTo(self).offset(padding.top);
      make.bottom.equalTo(self).offset(padding.bottom);
      make.centerY.equalTo(self);
      make.width.equalTo(100);
      make.height.equalTo(100);
    }
    
    storeLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.map.snp_right).offset(7);
      make.top.equalTo(self.map.snp_top);
    }
    
    productLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.storeLabel.snp_left);
      make.top.equalTo(self.storeLabel.snp_bottom).offset(2);
    }
    
    distanceLabel.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(self.productLabel.snp_left);
      make.top.equalTo(self.productLabel.snp_bottom).offset(2);
    }
  }
}
