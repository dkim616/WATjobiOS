//
//  InfoSessionDetailViewController.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit

class InfoSessionDetailViewController: UIViewController {
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    var employerInfoList: Array<EmployerInfo>;
    var toPass:Int!
    
    required init(coder aDecoder: NSCoder) {
        self.employerInfoList = [];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(toPass)
        
        self.title = "Info Session Details"
        
        self.companyNameLabel.text = "\(toPass)"
        
//        WJHTTPClient.sharedHTTPClient.getLatestEmployerInfoListByCompanyName("Coursera") { (result) -> () in
//            if let result = result {
//                self.employerInfoList = result;
//                println(self.employerInfoList[0].name)
//            }
//        }
        
        DataCenter.getEmployerInfoList() { (results) -> () in
            if let results = results {
                self.employerInfoList = results
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
