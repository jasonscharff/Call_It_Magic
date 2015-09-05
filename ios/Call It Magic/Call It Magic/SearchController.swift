//
//  ViewController.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/4/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import UIKit
import PureLayout
import SnapKit

class SearchController: UIViewController, UITextFieldDelegate {
  // MARK: View state functions and Navigation
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    configureNavbar()
    addSearchBar()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //MARK: UI Creation
  
  func configureNavbar() {
    self.title = "Search"
  }
  
  func addSearchBar() {
    var searchbar = SearchBar()
    self.view.addSubview(searchbar);
    
   // self.view.addConstraints(constraintH);
    searchbar.autoCenterInSuperview()
    
    searchbar.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(self.view.frame.width - 12);
      make.centerX.equalTo(self.view.center.x)
      make.centerY.equalTo(self.view.center.y)
      make.height.equalTo(50);
    }

    searchbar.delegate = self;
  }
  
  //MARK: Delegation Methods
  
  func textFieldDidBeginEditing(textField: UITextField) {
    
  }
  
  
  
 
  
  
  
  

}

