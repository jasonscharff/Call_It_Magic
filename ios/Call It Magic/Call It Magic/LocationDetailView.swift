//
//  LocationDetailView.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import Haneke


class LocationDetailView : UIViewController {
  
  var locationObject : AnalyzedLocationObject = AnalyzedLocationObject(); //Set before transition to the new VC
  
  private var map : MKMapView = MKMapView()
  private var annotation : MKPointAnnotation = MKPointAnnotation()
  private var ratingsView : UIImageView = UIImageView();
  
  private var textView : DetailedTextualInformationView = DetailedTextualInformationView();
  
  private var uberButton : UIButton = UIButton();
  
  private var postmatesButton : UIButton = UIButton();
  
  
  //MARK: View States
  override func viewDidLoad() {
    super.viewDidLoad();
    self.view.backgroundColor = UIColor.whiteColor();
    self.title = locationObject.storeName;
    setLocation(locationObject.latitude, longitude: locationObject.longitude);
    addTextualInformation()
    addRatings()
    addActions()
  }
  
  //MARK: Set up UI
  private func setLocation(latitude : Double, longitude : Double) {
    self.view.addSubview(map);
    //Set map
    var coord : CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude);
    var span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025);
    var region : MKCoordinateRegion = MKCoordinateRegion(center: coord, span: span)
    map.setRegion(region, animated: false);
    //Set pin
    annotation.coordinate = coord;
    map.addAnnotation(annotation);
    
    map.snp_makeConstraints { (make) -> Void in
      make.topMargin.equalTo(Constants.navbarHeight + 10)
      make.left.equalTo(10);
      make.right.equalTo(-10);
      make.height.equalTo((self.view.frame.size.height - CGFloat(Constants.navbarHeight - 10))/3)
    }
  }
  
  private func addTextualInformation() {
    textView = DetailedTextualInformationView(object: locationObject);
    self.view.addSubview(textView);
    textView.snp_makeConstraints { (make) -> Void in
      make.left.equalTo(10);
      make.right.equalTo(-10);
      make.top.equalTo(self.map.snp_bottom).offset(5);
    }
    
  }
  
  private func addRatings() {
    ratingsView.contentMode = UIViewContentMode.ScaleAspectFit;
    self.view.addSubview(ratingsView);
   
    ratingsView.snp_makeConstraints { (make) -> Void in
      make.width.greaterThanOrEqualTo(150);
      make.height.greaterThanOrEqualTo(60);
      make.centerX.equalTo(self.view);
      make.topMargin.equalTo(self.textView).offset(80)
    }
    
    
    ratingsView.sizeToFit()
    ratingsView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: locationObject.ratingsURL)!)!);
    ratingsView.userInteractionEnabled = true;
    var gestureRecognizer = UITapGestureRecognizer();
    gestureRecognizer.addTarget(self, action: "goToYelp:");
    ratingsView.addGestureRecognizer(gestureRecognizer);
  }
  
  func goToYelp (sender: UITapGestureRecognizer) {
    let vc = WebView()
    vc.titleOfNav = "Yelp"
    vc.url = locationObject.yelpURL;
    self.navigationController?.pushViewController(vc, animated: true);
  }
  
  private func addActions() {
    uberButton.setBackgroundImage(UIImage(named: "GetUber"), forState: UIControlState.Normal)
    uberButton.addTarget(self, action: "getUber:", forControlEvents: UIControlEvents.TouchDown);
    
    postmatesButton.setBackgroundImage(UIImage(named: "GetPostmates"), forState: UIControlState.Normal);
    postmatesButton.addTarget(self, action: "getPostmates:", forControlEvents: UIControlEvents.TouchDown);
    
    self.view.addSubview(uberButton);
    self.view.addSubview(postmatesButton);
    
    uberButton.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.view);
      make.top.equalTo(ratingsView.snp_bottom).offset(7);
      make.width.greaterThanOrEqualTo(200);
      make.height.greaterThanOrEqualTo(75);
    }

    
    postmatesButton.snp_makeConstraints { (make) -> Void in
      make.centerX.equalTo(self.view);
      make.top.equalTo(uberButton.snp_bottom).offset(10);
      make.width.greaterThanOrEqualTo(200);
      make.height.greaterThanOrEqualTo(75);
    }
    
  }
  
  func getPostmates(sender: UIButton) {
    
  }
  
  func getUber (sender: UIButton) {
    
    
    if UIApplication.sharedApplication().canOpenURL(NSURL(string: "uber://")!) {
      var geocoder = CLGeocoder()
      geocoder.reverseGeocodeLocation(CLLocation(latitude: Constants.userLatitude, longitude: Constants.userLongitude), completionHandler: { (placemarks, error) -> Void in
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
        var clientID = "z_ug_mPSxC1YnELqifnwZqy5ioC-AxYn"
        
        var urlOne = "uber://?client_id=" + clientID + "&action=setPickup&pickup=my_location"
        var urlTwo = addressString + "&dropoff[latitude]=" + String(stringInterpolationSegment: self.locationObject.latitude) + "&dropoff[longitude]=";
        var urlThree = String(stringInterpolationSegment: self.locationObject.longitude) + "&dropoff[nickname]=" + self.title! + "&dropoff[formatted_address]=" + self.textView.addressLabel.text!;
        
        var totalURL = urlOne + urlTwo + urlThree;
        
        let newURL = totalURL.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        UIApplication.sharedApplication().openURL(NSURL(string: newURL)!);
        
        
      });

    }
    
    
    
    
     }
  
  
  
}
