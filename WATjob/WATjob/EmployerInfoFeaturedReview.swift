//
//  EmployerInfoFeaturedReview.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation

class EmployerInfoFeaturedReview {
    var id: Int
    var currentJob: Bool
    var reviewDateTime: NSDate
    var jobTitle: String
    var location: String
    var headline: String
    var pros: String
    var cons: String
    var overall: Int
    var overallNumeric: Int
    
    init(
        id:Int,
        currentJob: Bool,
        reviewDateTime: NSDate,
        jobTitle: String,
        location: String,
        headline: String,
        pros: String,
        cons: String,
        overall: Int,
        overallNumeric: Int
        ) {
            self.id = id
            self.currentJob = currentJob
            self.reviewDateTime = reviewDateTime
            self.jobTitle = jobTitle
            self.location = location
            self.headline = headline
            self.pros = pros
            self.cons = cons
            self.overall = overall
            self.overallNumeric = overallNumeric
    }
    
}
