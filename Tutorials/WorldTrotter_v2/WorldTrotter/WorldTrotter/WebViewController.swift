//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Julien Esposito on 4/15/18.
//  Copyright © 2018 Julien Esposito. All rights reserved.
//

import UIKit
import WebKit

// lesson learned:
// per "https://stackoverflow.com/questions/29605496/cannot-assign-a-value-of-type-viewcontroller-to-a-value-of-type-uitextfielddeleg", the class WebViewController needs to "adopt" a "WKUIDelegate" protocol
class WebViewController : UIViewController, WKUIDelegate
{
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: "https://www.bignerdranch.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
