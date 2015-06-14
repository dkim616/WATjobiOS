//
//  ReviewViewController.swift
//  WATjob
//
//  Created by Fu Gordon on 15年6月14日.
//  Copyright (c) 2015年 Strawberry. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {


    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var consLabel: UILabel!
    
    var reviewInfo: EmployerInfoFeaturedReview!
    var toPass:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.companyLabel.text = "Test"
        self.headlineLabel.text = reviewInfo.headline
        var stringFromInt:String = String(format:"%d", self.reviewInfo.overall);
        self.ratingLabel.text = stringFromInt
        self.prosLabel.text = reviewInfo.pros
        self.consLabel.text = reviewInfo.cons
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