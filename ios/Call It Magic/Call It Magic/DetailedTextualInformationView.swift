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
    
    var font = UIFont(name: "HelveticaNeue", size: 16);
    
    addressLabel.font = font;
    productLabel.font = font;
    priceLabel.font = font;
    etaLabel.font = font;
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  func getETA(object : AnalyzedLocationObject) {
    
  }
}
