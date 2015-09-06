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
  
  
  init() {
    super.init(frame:CGRectZero);
  }
  
  var addressLabel = UILabel();
  
  init(object : AnalyzedLocationObject) {
    
    var productLabel = UILabel();
    var etaLabel = UILabel();
    
    super.init(frame: CGRectZero)
    
    var font = UIFont(name: "HelveticaNeue", size: 18);
    
    addressLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20);
    addressLabel.textAlignment = .Center;
    productLabel.font = font;
    etaLabel.font = font;
    var formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    let priceString = formatter.stringFromNumber(object.price)
    productLabel.text = object.productName + ", " + priceString!;
    
    var geocoder = CLGeocoder()
    geocoder.reverseGeocodeLocation(CLLocation(latitude: object.latitude, longitude: object.longitude), completionHandler: { (placemarks, error) -> Void in
        let pm = placemarks[0] as! CLPlacemark
        let dictionary = pm.addressDictionary;
      var addressString = "";
      if((dictionary["Street"]) != nil) {
         addressString  = (dictionary["Street"] as! String) + ", " + (dictionary["SubLocality"] as! String) + ", " + (dictionary["State"] as! String);
      }
      else {
        let lineOne = (dictionary["FormattedAddressLines"] as! Array<String>)[0];
        let lineTwo = (dictionary["FormattedAddressLines"] as! Array<String>)[1];
        addressString = lineOne + lineTwo;
      }
      self.addressLabel.text = addressString;
      self.addressLabel.textAlignment = NSTextAlignment.Center;
      productLabel.textAlignment = NSTextAlignment.Center;
      self.addressLabel.preferredMaxLayoutWidth = 200;
      self.addressLabel.numberOfLines = 0;
    })
    
    self.addSubview(addressLabel);
    self.addSubview(productLabel);
    self.addSubview(etaLabel);
    
    addressLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(self);
      make.leftMargin.equalTo(self);
      make.rightMargin.equalTo(self);
    }
    
    productLabel.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(addressLabel.snp_bottom).offset(2);
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
