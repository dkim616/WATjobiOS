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
    
    var employerInfo: EmployerInfo!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //println(toPass)
        
        self.title = "Info Session Details"
        
        self.companyNameLabel.text = employerInfo.name
        
//        WJHTTPClient.sharedHTTPClient.getLatestEmployerInfoListByCompanyName("Coursera") { (result) -> () in
//            if let result = result {
//                self.employerInfoList = result;
//                println(self.employerInfoList[0].name)
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detailToReview") {
            var detailVC = segue.destinationViewController as! ReviewListViewController
            detailVC.reviewInfo = employerInfo.featuredReview
        }
    }
    
}
