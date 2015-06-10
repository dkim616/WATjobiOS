//
//  InfoSession2.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import RealmSwift

class InfoSession: Object {
    dynamic var id = ""
    dynamic var employer = ""
    dynamic var date: NSDate?
    dynamic var day = ""
    dynamic var startTime = ""
    dynamic var endTime = ""
    dynamic var location = ""
    dynamic var website = ""
    dynamic var audience = ""
    dynamic var programs = ""
    dynamic var infoSessionDescription = ""
    dynamic var link = ""
    dynamic var isFavourited = false;
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
