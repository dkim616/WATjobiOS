//
//  InfoSessionDetailViewController.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit

class InfoSessionDetailViewController: UIViewController {
    
    var infoSessionList: Array<InfoSession>;
    
    required init(coder aDecoder: NSCoder) {
        self.infoSessionList = [];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Info Session Details"
        
        WJHTTPClient.sharedHTTPClient.getLatestInfoSessionList { (result) -> () in
            if let infoSessionList = result {
                self.infoSessionList = infoSessionList;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
