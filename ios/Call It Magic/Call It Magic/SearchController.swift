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
import CoreLocation

class SearchController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
  //MARK: Class scopes
  var searchbar : SearchBar;
  var tableView : UITableView;
  
  var location : CLLocation = CLLocation();
  
  var dataset = Array<LocationObject>();
  
 private let locationManager = CLLocationManager();
  
  init() {
    searchbar = SearchBar();
    tableView = UITableView();
    super.init(nibName: nil, bundle: nil);
  }

  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: View state functions and Navigation
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.whiteColor()
    self.tableView.registerClass(LocationTableViewCell.classForCoder(), forCellReuseIdentifier: "LocationCell")
    configureNavbar()
    requestPermission()
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
  
  //MARK: Location
  func requestPermission() {
    if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedAlways) {
      locationManager.requestAlwaysAuthorization()
    }
    if(CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways) {
      setupLocation()
      locationManager.startUpdatingLocation()
    }
  }
  
  func setupLocation () {
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.delegate = self;
  }
  
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    location = locations[locations.count - 1] as! CLLocation;
    tableView.reloadData()
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
  
  func addTableView() {
    self.view.addSubview(tableView);
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 120;
    tableView.backgroundColor = UIColor.clearColor();
    tableView.separatorStyle = .None;
    
    tableView.snp_makeConstraints { (make) -> Void in
      make.top.equalTo(searchbar.snp_bottom).offset(20);
      make.centerX.equalTo(self.view);
      make.width.equalTo(self.view.frame.size.width - 16);
      make.bottom.equalTo(self.view.frame.size.height);
    }
  }
  
  
  //MARK: Table View Data Source
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell : LocationTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocationCell") as! LocationTableViewCell;
    cell.setFromData(dataset[indexPath.row], location:location);
    return cell;
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataset.count;
  }
  
  //MARK: Scroll View Stuff
  
  func scrollViewDidScroll(scrollView: UIScrollView) {
    searchbar.textField.resignFirstResponder();
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
  //WARNING: Actually make API Call
  func textFieldDidChange(notifcation: NSNotification) {
    //Make an api call and fetch the results...
    
    dataset = DataHandler.getBatch();
    addTableView();
    
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder();
    return true;
  }
  
  
  
 
  
  
  
  

}

