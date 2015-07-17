//
//  GitEmployerInfo.swift
//  WATjob
//
//  Created by Fu Gordon on 15年7月15日.
//  Copyright (c) 2015年 Strawberry. All rights reserved.
//

import RealmSwift

class GitEmployerInfo: Object {
    dynamic var id = ""
    dynamic var createdAt: NSDate?
    dynamic var title = ""
    dynamic var location = ""
    dynamic var type = ""
    dynamic var jobDescription = ""
    dynamic var howToApply = ""
    dynamic var company = ""
    dynamic var companyUrl = ""
    dynamic var companyLogo = ""
    dynamic var Url = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}