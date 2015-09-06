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
import AlgoliaSearch

class SearchController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
  //MARK: Class scopes
  var searchbar : SearchBar;
  var tableView : UITableView;
  var hasAddedTableView = false;
  
  var location : CLLocation = CLLocation();
  
  var dataset = Array<LocationObject>();
  
  let client = AlgoliaSearch.Client(appID: "AL4HRJ6LIF", apiKey: "05488451891f97d60d3dd4e89c3e31a3")
  
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
    hasAddedTableView = true;
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
      make.bottom.equalTo(self.view)
    }
  }
  
  
  //MARK: Table View Data Source and Delegate
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell : LocationTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocationCell") as! LocationTableViewCell;
    cell.setFromData(dataset[indexPath.row], location:location);
    return cell;
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataset.count;
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    println("hola");
    let vc = LocationDetailView();
    let cell : LocationTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! LocationTableViewCell;
    cell.setSelected(false, animated: true);
    vc.locationObject = cell.analyzedLocObject;
    self.navigationController?.pushViewController(vc, animated: true);
    
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
  func textFieldDidChange(notifcation: NSNotification) {
    if(searchbar.textField.text.isEmpty) {
      self.dataset = [];
    }
    else {
      let index = client.getIndex("prod_magic2")
      let attributesToIndex = ["item_name"]
      let settings = [
        "attributesToIndex": attributesToIndex
      ]
      index.setSettings(settings, block: { (content, error) -> Void in
        if let error = error {
          println("Error when applying settings: \(error)")
        }
      })
      index.search(Query(query: searchbar.textField.text), block: { (content, error) -> Void in
        if (error != nil) {
          print(error);
        }
        else {
          self.dataset = DataHandler.parseJSON(content!)
          if(!self.hasAddedTableView) {
            self.addTableView();
          }
          self.tableView.reloadData();
        }
      })
    }
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder();
    return true;
  }
  
  
  
 
  
  
  
  

}


