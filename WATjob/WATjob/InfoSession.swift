//
//  InfoSession.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation

class InfoSession {
    var id: String
    var employer: String
    var date: NSDate
    var day: String
    var startTime: String
    var endTime: String
    var location: String
    var website: String
    var audience: String?
    var programs: String?
    var description: String?
    var link: String?
    
    init(id: String, employer: String, date: NSDate, day: String, startTime: String, endTime:String, location: String, website: String) {
        self.id = id;
        self.employer = employer;
        self.date = date;
        self.day = day;
        self.startTime = startTime;
        self.endTime = endTime;
        self.location = location;
        self.website = website;
    }
}
