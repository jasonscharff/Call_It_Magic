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
  var storeName : String;
  var productName : String;
  var price : Double;
  
  init(json : Dictionary<String, AnyObject>) {
    var subDictionary: Dictionary<String, AnyObject> = json["_geoloc"] as! Dictionary<String, AnyObject>;
    latitude = (subDictionary["lat"] as! NSNumber).doubleValue
    longitude = (subDictionary["lng"] as! NSNumber).doubleValue;
    storeName = json["place_name"] as! String;
    productName = json["item_name"] as! String;
    price = json["item_price"] as! Double;
  }
  
}