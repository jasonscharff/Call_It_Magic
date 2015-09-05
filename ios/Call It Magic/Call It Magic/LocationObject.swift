//
//  LocationObject.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
class LocationObject: AnyObject {
  
  var latitude : Double;
  var longitude : Double;
  var uuid : String;
  var storeName : String;
  var productName : String;
  
  init(json : Dictionary<String, AnyObject>) {
    latitude = json["lat"] as! Double;
    longitude = json["lng"] as! Double;
    uuid = json["uuid"] as! String;
    storeName = json["store_name"] as! String;
    productName = json["product_name"] as! String;
    
  }
  
}