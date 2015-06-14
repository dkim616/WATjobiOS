//
//  EmployerInfoCEO.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import RealmSwift

class EmployerInfoCEO: Object {
    dynamic var name = ""
    dynamic var title = ""
    dynamic var numberOfRatings = 0
    dynamic var pctApprove = 0
    dynamic var pctDisapprove = 0
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
