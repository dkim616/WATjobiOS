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
    
    @IBOutlet weak var companyImage: UIImageView!
    
    var infoSession: InfoSession!
    var employerInfo: EmployerInfo?
    
    var dateFormatter: NSDateFormatter
    
    required init(coder aDecoder: NSCoder) {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.companyNameLabel.text = infoSession.employer
        
//        if (infoSession.
//        self.companyImage.image = (
        
        self.locationLabel.text = infoSession.location
        if (infoSession.date != nil) {
            self.dateLabel.text = dateFormatter.stringFromDate(infoSession.date!)
        } else {
            self.dateLabel.text = "Location Not Available"
        }
        self.startTimeLabel.text = infoSession.startTime
        self.endTimeLabel.text = infoSession.endTime
        
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
            detailVC.reviewInfo = employerInfo!.featuredReview
        }
    }
    
}
