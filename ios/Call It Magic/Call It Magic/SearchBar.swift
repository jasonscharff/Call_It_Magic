//
//  SearchBar.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import SnapKit

class SearchBar : UIView {
  
  var textField : UITextField;
  
  var delegate: UITextFieldDelegate! = nil {
    didSet {
      textField.delegate = delegate;
    }
  }
  
  override init(frame: CGRect) {
    textField = UITextField()
    textField.backgroundColor = UIColor.clearColor()
    textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Bottom
    textField.placeholder = "start typing";
    textField.font = UIFont(name: "HelveticaNeue", size: 40);
    textField.returnKeyType = UIReturnKeyType.Done;
    super.init(frame: frame)
    var searchImage = UIImageView(image: UIImage(named: "MagnifyingGlass"))
    var line = UIView();
    line.backgroundColor = UIColor.blackColor()
    self.addSubview(searchImage);
    self.addSubview(textField);
    self.addSubview(line);
    var constraintH = NSLayoutConstraint.constraintsWithVisualFormat( "H:|[searchImage]-[textField]|", options: [], metrics:nil, views: ["searchImage":searchImage, "textField":textField]);
    
    self.addConstraints(constraintH);
    
    textField.autoPinEdgeToSuperviewEdge(.Top)
    textField.autoPinEdgeToSuperviewEdge(.Bottom)
    searchImage.snp_makeConstraints { (make) -> Void in
      make.centerY.equalTo(self);
      make.width.equalTo(50);
      make.height.equalTo(50);
    }
    line.snp_makeConstraints { (make) -> Void in
      make.height.equalTo(2)
      make.width.equalTo(textField)
      make.bottom.equalTo(textField);
      make.left.equalTo(textField)
    }
  }
  
  convenience init () {
    self.init(frame:CGRectZero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  

}


