//
//  EmployerInfoFeaturedReview.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import RealmSwift

class EmployerInfoFeaturedReview: Object {
    dynamic var id = 0
    dynamic var currentJob = false
    dynamic var reviewDateTime: NSDate?
    dynamic var jobTitle = ""
    dynamic var location = ""
    dynamic var headline = ""
    dynamic var pros = ""
    dynamic var cons = ""
    dynamic var overall = 0
    dynamic var overallNumeric = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
