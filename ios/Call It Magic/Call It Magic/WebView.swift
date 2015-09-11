//
//  WebView.swift
//  Call It Magic
//
//  Created by Jason Scharff on 9/5/15.
//  Copyright (c) 2015 Jason Scharff and Valentin Perez. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
class WebView : UIViewController {
  
  //Set these before hand
  var titleOfNav : String = ""
  var url  : String = ""
  
  override func viewDidLoad() {
    self.view.backgroundColor = UIColor.whiteColor();
    self.title = titleOfNav;
    let webView = UIWebView();
    webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!));
    self.view.addSubview(webView);
    webView.autoPinEdgesToSuperviewEdges()
  }
}
