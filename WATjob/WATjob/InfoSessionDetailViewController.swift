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
    var infoSessionId: String
    var infoSession: InfoSession?
    
    required init(coder aDecoder: NSCoder) {
        infoSessionId = ""
        super.init(coder: aDecoder);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoSession = DataCenter.getInfoSessionForId(infoSessionId)

        if let infoSession = self.infoSession {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMM, dd yyy"
            self.companyNameLabel.text = ""
            self.title = infoSession.employer
            self.locationLabel.text = infoSession.location
            self.dateLabel.text = formatter.stringFromDate(infoSession.date!)
            self.startTimeLabel.text = infoSession.startTime
            self.endTimeLabel.text = infoSession.endTime
        }
        
        WJHTTPClient.sharedHTTPClient.getLatestEmployerInfoByCompanyName("") { (result) -> () in
            if let result = result {
                self.employerInfo = result;
            }
        }
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
