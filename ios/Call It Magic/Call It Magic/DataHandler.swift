//
//  DataHandler.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
import Alamofire;

class DataHandler: AnyObject {
  

  static func parseJSON(content : Dictionary<String, AnyObject>) -> Array<LocationObject> {
    let realContent : Array<AnyObject> = content["hits"] as! Array<AnyObject>;
    
    var locations = Array<LocationObject>();
    
    for dictionary in realContent {
      var object = LocationObject(json: dictionary as! Dictionary<String, AnyObject>)
      locations.append(object);
    }
    return locations;
  }
  
  
}

