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
  
  var textView : DetailedTextualInformationView = DetailedTextualInformationView();
  
  
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
    var imageView = UIImageView();
    imageView.contentMode = UIViewContentMode.ScaleAspectFit;
    self.view.addSubview(imageView);
   
    imageView.snp_makeConstraints { (make) -> Void in
      make.width.greaterThanOrEqualTo(150);
      make.height.greaterThanOrEqualTo(60);
      make.centerX.equalTo(self.view);
      make.topMargin.equalTo(self.textView).offset(80)
    }
    
    
    imageView.sizeToFit()
    imageView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: locationObject.ratingsURL)!)!);
    imageView.userInteractionEnabled = true;
    var gestureRecognizer = UITapGestureRecognizer();
    gestureRecognizer.addTarget(self, action: "goToYelp:");
    imageView.addGestureRecognizer(gestureRecognizer);
  }
  
  func goToYelp (sender: UITapGestureRecognizer) {
    let vc = WebView()
    vc.titleOfNav = "Yelp"
    vc.url = locationObject.yelpURL;
    self.navigationController?.pushViewController(vc, animated: true);
  }
  
  private func addActions() {
    
  }
  
  
  
}
