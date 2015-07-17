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
    
    var gitEmployerInfoId: String
    var gitEmployerInfo: GitEmployerInfo!
    
    let dateFormatter: NSDateFormatter
    
    required init(coder aDecoder: NSCoder) {
        dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "E MMM dd H:mm:ss z yyyy"
        
        gitEmployerInfoId = ""
        
        super.init(coder: aDecoder);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoById(gitEmployerInfoId) { (result) -> () in
                    if let result = result {
                        self.gitEmployerInfo = result;
                   }
                }
        //self.gitEmployerInfo = DataCenter.getGitEmployerInfoList();
        
        self.companyNameLabel.text = gitEmployerInfo.company
                self.titleLabel.text = gitEmployerInfo.title
                self.typeLabel.text = gitEmployerInfo.type
        //load_image(employerInfo!.squareLogo)
        
        self.locationLabel.text = gitEmployerInfo.location
        if (gitEmployerInfo.createdAt != nil) {
            self.dateLabel.text = dateFormatter.stringFromDate(gitEmployerInfo.createdAt!)
        } else {
            self.dateLabel.text = "Date Not Available"
        }

        self.applyLabel.text = gitEmployerInfo.howToApply
        self.descriptionLabel.text = gitEmployerInfo.description

        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
