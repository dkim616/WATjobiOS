//
//  InfoSessionWebViewController.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-07-19.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit

class InfoSessionWebViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var barTitle: UINavigationItem!
    
    var URLPath: String
    var webTitle: String
    
    required init(coder aDecoder: NSCoder) {
        URLPath = ""
        webTitle = ""
        
        super.init(coder: aDecoder);
    }
    
    func loadAddressURL() {
        let requestURL = NSURL(string: URLPath)
        let request = NSURLRequest(URL: requestURL!)
        self.webView.loadRequest(request)
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barTitle.title = webTitle
        loadAddressURL()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

