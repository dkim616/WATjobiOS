//
//  ReviewListViewController.swift
//  WATjob
//
//  Created by Fu Gordon on 15年6月10日.
//  Copyright (c) 2015年 Strawberry. All rights reserved.
//

import UIKit

class ReviewListViewController: UIViewController {

    @IBOutlet weak var employerLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var employerInfoList: Array<EmployerInfo>;
    var toPass:Int!
    
    required init(coder aDecoder: NSCoder) {
        self.employerInfoList = [];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        WJHTTPClient.sharedHTTPClient.getLatestEmployerInfoListByCompanyName("Coursera") { (result) -> () in
            if let employerInfoList = result {
                self.employerInfoList = employerInfoList;
                self.employerLabel.text = self.employerInfoList[0].name
                var stringFromDouble:String = String(format:"%f", self.employerInfoList[0].overallRating);
                self.ratingLabel.text = stringFromDouble
            }
        }
        
        //companyLabel.text = employerInfoList[0].name;
        // Do any additional setup after loading the view.
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
