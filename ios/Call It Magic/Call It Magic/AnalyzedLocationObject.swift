//
//  AnalyzedLocationObject.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
class AnalyzedLocationObject : AnyObject {
  
  var distance : Double; //Distance in feet.
  var productName : String;
  var storeName : String;
  var longitude : Double;
  var latitude : Double;
  var price : Double;
  var eta : Int;
  
  init(distance: Double, productName : String, storeName : String, latitude : Double, longitude : Double, price : Double, eta: Int) {
    self.distance = distance;
    self.productName = productName;
    self.storeName = storeName;
    self.latitude = latitude;
    self.longitude = longitude;
    self.price = price;
    self.eta = eta;
  }
  
  init() {
    distance = 0;
    productName = ""
    storeName = ""
    latitude = 0
    longitude = 0
    price = 0
    eta = 0;
  }

}