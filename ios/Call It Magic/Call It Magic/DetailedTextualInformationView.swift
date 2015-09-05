//
//  DetailedTextualInformationView.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import SnapKit


class DetailedTextualInformationView : UIView {
  init(object : AnalyzedLocationObject) {
    var addressLabel = UILabel();
    var productLabel = UILabel();
    var priceLabel = UILabel();
    var etaLabel = UILabel();
    
    super.init(frame: CGRectZero)
    
    var font = UIFont(name: "HelveticaNeue", size: 18);
    
    addressLabel.font = UIFont(name: "HelveticaNeue", size: 18);
    addressLabel.textAlignment = .Center;
    productLabel.font = font;
    priceLabel.font = font;
    etaLabel.font = font;
    
    productLabel.text = object.productName;
    priceLabel.text = "$" + String(stringInterpolationSegment: object.price);
    var geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(CLLocation(latitude: object.latitude, longitude: object.longitude), completionHandler: { (placemarks, error) -> Void in
        let pm = placemarks[0] as! CLPlacemark
        let dictionary = pm.addressDictionary;
      let addressString : String = (dictionary["Street"] as! String) + ", " + (dictionary["SubLocality"] as! String) + ", " + (dictionary["State"] as! String);
      addressLabel.text = addressString;
      addressLabel.textAlignment = NSTextAlignment.Center;
      addressLabel.preferredMaxLayoutWidth = 50;
    })
    
    self.addSubview(addressLabel);
    self.addSubview(productLabel);
    self.addSubview(priceLabel);
    self.addSubview(etaLabel);
    
    addressLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self);
      make.leftMargin.equalTo(self);
      make.rightMargin.equalTo(self);
    }
    
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func getETA(object : AnalyzedLocationObject) {
    
  }
}
