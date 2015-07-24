 //
//  InfoSessionDetailViewController.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit

class InfoSessionDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Variables
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var floatingView: UINavigationBar!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    
    @IBOutlet weak var companyImage: UIImageView!
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var websiteLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionHeight: NSLayoutConstraint!
    
    @IBOutlet weak var employerLabel: UILabel!
    @IBOutlet weak var industryLabel: UILabel!
    @IBOutlet weak var numberOfRatingsLabel: UILabel!
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var ratingDescription: UILabel!
    @IBOutlet weak var cultureAndValuesLabel: UILabel!
    @IBOutlet weak var seniorLeadershipLabel: UILabel!
    @IBOutlet weak var compensationAndBenefitsLabel: UILabel!
    @IBOutlet weak var careerOpportunitiesLabel: UILabel!
    @IBOutlet weak var workLifeBalanceLabel: UILabel!
    @IBOutlet weak var recommendToFriendLabel: UILabel!
    
    @IBOutlet weak var reviewDateLabel: UILabel!
    @IBOutlet weak var currentJobLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var reviewlocationLabel: UILabel!
    @IBOutlet weak var reviewRatingLabel:UILabel!
    @IBOutlet weak var headlineLabel:UILabel!
    @IBOutlet weak var prosLabel:UILabel!
    @IBOutlet weak var consLabel:UILabel!
    
    @IBOutlet var prosView: UIView!
    @IBOutlet var consView: UIView!
    
    @IBOutlet weak var prosViewHeight: NSLayoutConstraint!
    @IBOutlet weak var consViewHeight: NSLayoutConstraint!
    
    var originalFloatingY: CGFloat
    
    var infoSessionId: String
    var infoSession: InfoSession!
    var employerInfoId: Int
    var employerInfo: EmployerInfo!
    
    let dateFormatter: NSDateFormatter
    
    // MARK: - Functions
    
    required init(coder aDecoder: NSCoder) {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        infoSessionId = ""
        employerInfoId = 0
        
        self.originalFloatingY = CGFloat.min

        super.init(coder: aDecoder);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Back button label
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
        
        // Segmented Control
        self.originalFloatingY = self.floatingView.frame.origin.y
        
        // Initially hide some views
        self.view1.hidden = false
        self.view2.hidden = true
        self.view3.hidden = true
        
        // Getting data from DataCenter
        self.infoSession = DataCenter.getInfoSessionForId(infoSessionId)
        DataCenter.getEmployerInfoByCompanyName(self.infoSession.employer, completionHandler: { (employerInfo) -> () in
            if let employerInfo = employerInfo {
                self.employerInfo = employerInfo
                // Company Name and Image
                self.title = self.infoSession.employer
                self.load_image(self.employerInfo.squareLogo)
                
                // Programmatically setup views
                self.setSessionInfo()
                self.setEmployerInfo()
                self.setReviewInfo()
            } else {
                // Remove if we don't want it
                self.navigationController?.popViewControllerAnimated(true);
                let stuff = UIAlertView(title: "Ooops...", message: "Unable to fetch company detail", delegate: nil, cancelButtonTitle: "Confirm");
                stuff.show()
            }
        })
    }
    
    // MARK: - Segmented Controls
    
    @IBAction func segmentedControlTapped(sender: UISegmentedControl) {
        let index = self.segmentedControl.selectedSegmentIndex
        if index == 0 {
            view1.hidden = false
            view2.hidden = true
            view3.hidden = true
        }
        else if index == 1 {
            view1.hidden = true
            view2.hidden = false
            view3.hidden = true
        }
        else if index == 2 {
            view1.hidden = true
            view2.hidden = true
            view3.hidden = false
        }
    }
    
    // MARK: - Load Content
    
    func setSessionInfo() {
        self.companyLabel.text = infoSession.employer
        self.locationLabel.text = infoSession.location
        if let date = infoSession.date {
            self.dateLabel.text = self.dateFormatter.stringFromDate(date)
        }
        else {
            self.dateLabel.text = " "
        }
        self.startTimeLabel.text = infoSession.startTime
        self.endTimeLabel.text = infoSession.endTime
        if let website = infoSession?.website {
            if count(website) > 0 {
                self.websiteLabel.setTitle(
                    website,
//                    website.substringWithRange(
//                        Range<String.Index>(
//                            start: advance(website.startIndex, 7),
//                            end: website.endIndex)
//                    ),
                    forState: UIControlState.Normal
                )
            } else {
                self.websiteLabel.hidden = true
            }
        }
        
        println(infoSession.website)
        println(infoSession.infoSessionDescription)
        println("Done")
        var descLabelLen = Double(count(infoSession.infoSessionDescription))
        var descLineCount = Int(ceil(descLabelLen / 55.0))
        self.descriptionLabel.text = infoSession.infoSessionDescription
        self.descriptionLabel.numberOfLines = descLineCount
        self.descriptionHeight.constant = CGFloat(20 * descLineCount)
        
//        var informationLabel = UILabel(frame: CGRectMake(19, 20, 200, 20))
//        informationLabel.text = "Information"
//        self.view1.addSubview(informationLabel)
//        
//        var employerLabel = UILabel(frame: CGRectMake(15, 50, 90, 20))
//        employerLabel.text = "Employer"
//        employerLabel.textAlignment = NSTextAlignment.Right
//        employerLabel.textColor = UIColor.grayColor()
//        employerLabel.font = employerLabel.font.fontWithSize(15)
//        self.view1.addSubview(employerLabel)
//        
//        var dateLabel = UILabel(frame: CGRectMake(15, 75, 90, 20))
//        dateLabel.text = "Date"
//        dateLabel.textAlignment = NSTextAlignment.Right
//        dateLabel.textColor = UIColor.grayColor()
//        dateLabel.font = dateLabel.font.fontWithSize(15)
//        self.view1.addSubview(dateLabel)
//        
//        var locationLabel = UILabel(frame: CGRectMake(15, 100, 90, 20))
//        locationLabel.text = "Location"
//        locationLabel.textAlignment = NSTextAlignment.Right
//        locationLabel.textColor = UIColor.grayColor()
//        locationLabel.font = locationLabel.font.fontWithSize(15)
//        self.view1.addSubview(locationLabel)
//        
//        var startLabel = UILabel(frame: CGRectMake(15, 125, 90, 20))
//        startLabel.text = "Start Time"
//        startLabel.textAlignment = NSTextAlignment.Right
//        startLabel.textColor = UIColor.grayColor()
//        startLabel.font = startLabel.font.fontWithSize(15)
//        self.view1.addSubview(startLabel)
//        
//        var endLabel = UILabel(frame: CGRectMake(15, 150, 90, 20))
//        endLabel.text = "End Time"
//        endLabel.textAlignment = NSTextAlignment.Right
//        endLabel.textColor = UIColor.grayColor()
//        endLabel.font = endLabel.font.fontWithSize(15)
//        self.view1.addSubview(endLabel)
//        
//        var webLabel = UILabel(frame: CGRectMake(15, 175, 90, 20))
//        webLabel.text = "Website"
//        webLabel.textAlignment = NSTextAlignment.Right
//        webLabel.textColor = UIColor.grayColor()
//        webLabel.font = webLabel.font.fontWithSize(15)
//        self.view1.addSubview(webLabel)
    }
    
    func setEmployerInfo() {
        self.employerLabel.text = infoSession.employer
        self.industryLabel.text = employerInfo?.industry
        if let numberOfRatings = employerInfo?.numberOfRatings {
            self.numberOfRatingsLabel.text = String(numberOfRatings)
        }
        else {
            self.numberOfRatingsLabel.text = " "
        }
        if let overallRating = employerInfo?.overallRating {
            self.overallRatingLabel.text = String(format: "%.1f", overallRating)
        }
        else {
            self.overallRatingLabel.text = " "
        }
        self.ratingDescription.text = employerInfo?.ratingDescription
        self.cultureAndValuesLabel.text = employerInfo?.cultureAndValuesRating
        self.seniorLeadershipLabel.text = employerInfo?.seniorLeadershipRating
        self.compensationAndBenefitsLabel.text = employerInfo?.compensationAndBenefitsRating
        self.careerOpportunitiesLabel.text = employerInfo?.careerOpportunitiesRating
        self.workLifeBalanceLabel.text = employerInfo?.workLifeBalanceRating
        self.recommendToFriendLabel.text = employerInfo?.recommendToFriendRating
    }
    
    func setReviewInfo() {
        if let review = employerInfo.featuredReview {
            if let date = review.reviewDateTime {
                self.reviewDateLabel.text = self.dateFormatter.stringFromDate(date)
            } else {
                self.reviewDateLabel.text = " "
            }
            if review.currentJob {
                self.currentJobLabel.text = "Yes"
            }
            else {
                self.currentJobLabel.text = "No"
            }
            self.jobTitleLabel.text = review.jobTitle
            if review.location == "" {
                self.reviewlocationLabel.text = " "
            }
            else {
                self.reviewlocationLabel.text = review.location
            }
            self.headlineLabel.text = review.headline
            self.reviewRatingLabel.text = String(review.overall)
            
            var prosLabelLen = Double(count(review.pros))
            var prosLineCount = Int(ceil(prosLabelLen / 55.0))
            self.prosLabel.text = review.pros
            self.prosLabel.numberOfLines = prosLineCount
            self.prosViewHeight.constant = CGFloat(20 * prosLineCount)
            
            var consLabelLen = Double(count(review.cons))
            var consLineCount = Int(ceil(consLabelLen / 55.0))
            self.consLabel.text = review.cons
            self.consLabel.numberOfLines = consLineCount
            self.consViewHeight.constant = CGFloat(20 * consLineCount)
            
            
        }
    }
    
    // MARK: - Image
    
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
    
    // MARK: - Floating Element
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.updateFloatingViewFrame()
    }
    
    // Offset starts from -64 for some reason
    func updateFloatingViewFrame() {
        var contentOffset = self.scrollView.contentOffset
        var y = max(contentOffset.y + 64, self.originalFloatingY)
        var frame = self.floatingView.frame
        if (y != frame.origin.y) {
            frame.origin.y = y
            self.floatingView.frame = frame
        }
    }
    
    // MARK: - Memory
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "detailToWebView") {
            var webVC = segue.destinationViewController as! InfoSessionWebViewController
            webVC.URLPath = infoSession.website
            
            if let website = infoSession?.website {
                webVC.webTitle = website//.substringWithRange(
//                        Range<String.Index>(
//                            start: advance(website.startIndex, 7),
//                            end: website.endIndex
//                    )
//                )
            }
        }
        
    }
    
}
