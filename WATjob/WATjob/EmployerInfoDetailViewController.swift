//
//  EmployerInfoDetailViewController.swift
//  WATjob
//
//  Created by Fu Gordon on 15年7月17日.
//  Copyright (c) 2015年 Strawberry. All rights reserved.
//

import UIKit

class EmployerInfoDetailViewController: UIViewController {
    
    
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var applyLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    var gitEmployerInfoId: String
    var gitEmployerInfo: GitEmployerInfo!
    
    let dateFormatter: NSDateFormatter
    
    required init(coder aDecoder: NSCoder) {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM dd H:mm:ss z yyyy"
        
        self.gitEmployerInfoId = ""
        
        super.init(coder: aDecoder);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Temporary fix - DataCenter gives description with <p>, etc.. - Looks ugly
        /*
        self.gitEmployerInfo = DataCenter.getGitEmployerInfoById(gitEmployerInfoId)
        
        self.companyNameLabel.text = self.gitEmployerInfo.company
        self.titleLabel.text = self.gitEmployerInfo.title
        self.typeLabel.text = self.gitEmployerInfo.type
        //load_image(employerInfo!.squareLogo)
        
        self.locationLabel.text = self.gitEmployerInfo.location
        if (self.gitEmployerInfo.createdAt != nil) {
        self.dateLabel.text = self.dateFormatter.stringFromDate(self.gitEmployerInfo.createdAt!)
        } else {
        self.dateLabel.text = "Date Not Available"
        }
        
        self.applyLabel.text = self.gitEmployerInfo.companyUrl
        self.descriptionLabel.text = self.gitEmployerInfo.jobDescription
        */
        
        WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoById(gitEmployerInfoId) { (result) -> () in
            if let result = result {
                self.gitEmployerInfo = result;
                
                self.companyNameLabel.text = self.gitEmployerInfo.company
                self.titleLabel.text = self.gitEmployerInfo.title
                self.typeLabel.text = self.gitEmployerInfo.type
                //load_image(employerInfo!.squareLogo)
                
                self.locationLabel.text = self.gitEmployerInfo.location
                if (self.gitEmployerInfo.createdAt != nil) {
                    self.dateLabel.text = self.dateFormatter.stringFromDate(self.gitEmployerInfo.createdAt!)
                } else {
                    self.dateLabel.text = "Date Not Available"
                }
                
                self.applyLabel.text = self.gitEmployerInfo.howToApply
                self.descriptionLabel.text = self.gitEmployerInfo.jobDescription
            }
            
            
            // Calculate size needed for scrolling
            self.scrollView.contentSize = CGSizeMake(350, 10000)
        }
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
