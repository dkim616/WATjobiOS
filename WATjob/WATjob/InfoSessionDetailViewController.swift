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
    
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var cultureAndValuesLabel: UILabel!
    @IBOutlet weak var seniorLeadershipLabel: UILabel!
    @IBOutlet weak var compensationAndBenefitsLabel: UILabel!
    @IBOutlet weak var careerOpportunitiesLabel: UILabel!
    @IBOutlet weak var workLifeBalanceLabel: UILabel!
    @IBOutlet weak var recommendToFriendLabel: UILabel!
    
    @IBOutlet weak var companyImage: UIImageView!
    
    var infoSessionId: String
    var infoSession: InfoSession!
    var employerInfoId: Int
    var employerInfo: EmployerInfo?
    
    let dateFormatter: NSDateFormatter
    
    required init(coder aDecoder: NSCoder) {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        infoSessionId = ""
        employerInfoId = 0

        super.init(coder: aDecoder);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.infoSession = DataCenter.getInfoSessionForId(infoSessionId)
        self.employerInfo = DataCenter.getEmployerInfoById(employerInfoId)
        
        self.companyNameLabel.text = infoSession.employer
        
        load_image(employerInfo!.squareLogo)
        
        self.locationLabel.text = infoSession.location
        if (infoSession.date != nil) {
            self.dateLabel.text = dateFormatter.stringFromDate(infoSession.date!)
        } else {
            self.dateLabel.text = "Location Not Available"
        }
        self.startTimeLabel.text = infoSession.startTime
        self.endTimeLabel.text = infoSession.endTime
        
        self.overallRatingLabel.text = "\(employerInfo!.overallRating)"
        self.cultureAndValuesLabel.text = employerInfo?.cultureAndValuesRating
        self.seniorLeadershipLabel.text = employerInfo?.seniorLeadershipRating
        self.compensationAndBenefitsLabel.text = employerInfo?.compensationAndBenefitsRating
        self.careerOpportunitiesLabel.text = employerInfo?.careerOpportunitiesRating
        self.workLifeBalanceLabel.text = employerInfo?.workLifeBalanceRating
        self.recommendToFriendLabel.text = employerInfo?.recommendToFriendRating
        
//        WJHTTPClient.sharedHTTPClient.getLatestEmployerInfoByCompanyName("") { (result) -> () in
//            if let result = result {
//                self.employerInfo = result;
//            }
//        }
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    func load_image(urlString:String)
    {
        
        var imgURL: NSURL = NSURL(string: urlString)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    self.companyImage.image = UIImage(data: data)
                }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detailToReview") {
            var detailVC = segue.destinationViewController as! ReviewViewController
            
//            DataCenter.getEmployerInfoByCompanyName(infoSession.employer)
            
            detailVC.reviewInfo = employerInfo!.featuredReview
        }
    }
    
}
