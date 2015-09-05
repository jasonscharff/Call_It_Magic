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
  
  static func getBatch() -> Array<LocationObject> {
    var json = getJSON();
    var locations = Array<LocationObject>();
    var actualJSON = json["places"] as! Array<Dictionary<String, AnyObject>>;
    for dictionary in actualJSON {
      var location = LocationObject(json: dictionary);
      locations.append(location);
    }
    
    return locations;
  }
  
  static private func getJSON() -> Dictionary<String, AnyObject> {
    if let path = NSBundle.mainBundle().pathForResource("test", ofType: "json")
    {
      if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)
      {
        if let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary
        {
          print(jsonResult)
          return jsonResult as! Dictionary<String, AnyObject>;
        }
      }
    }
    return Dictionary()
  }
  
//  //WARNING: NEED TO WRITE THIS
//  private func getJSON() -> Dictionary<String, AnyObject> {
//    return ["hey" : "person"];
//  }
  
  
}

