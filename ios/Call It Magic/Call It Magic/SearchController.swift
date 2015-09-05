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
  //MARK: Class scopes
  var searchbar : SearchBar;
  
  init() {
    searchbar = SearchBar();
    super.init(nibName: nil, bundle: nil);
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View state functions and Navigation
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    configureNavbar()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated);
    addSearchBar()
    NSNotificationCenter.defaultCenter().addObserver(
      self,
      selector: "textFieldDidChange:",
      name: UITextFieldTextDidChangeNotification,
      object: searchbar.textField)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewWillDisappear(animated: Bool) {
    NSNotificationCenter.defaultCenter().removeObserver(self);
  }
  
  //MARK: UI Creation
  
  func configureNavbar() {
    self.title = "Search"
  }
  
  func addSearchBar() {
    self.view.addSubview(searchbar);
    searchbar.autoCenterInSuperview()
    searchbar.snp_makeConstraints { (make) -> Void in
      make.width.equalTo(self.view.frame.width - 12);
      make.centerX.equalTo(self.view.center.x)
      make.centerY.equalTo(self.view.center.y)
      make.height.equalTo(50);
    }
    searchbar.delegate = self;
    
  }
  
  //MARK: Delegation and Notification Methods
  func textFieldDidBeginEditing(textField: UITextField) {
    //Move search bar up and disable in table view.
    self.searchbar.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(20 + Constants.navbarHeight);
    }
    self.view.setNeedsLayout()
    UIView.animateWithDuration(0.45, animations: { () -> Void in
      self.view.layoutIfNeeded();
    })
    
  }
  
  func textFieldDidChange(notifcation: NSNotification) {

  }
  
  
  
 
  
  
  
  

}

