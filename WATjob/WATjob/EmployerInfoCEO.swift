//
//  EmployerInfoCEO.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation

class EmployerInfoCEO {
    var name: String
    var title: String
    var numberOfRatings: Int
    var pctApprove: Int
    var pctDisapprove: Int
    
    init(name: String, title: String, numberOfRatings: Int, pctApprove: Int, pctDisapprove: Int) {
        self.name = name
        self.title = title
        self.numberOfRatings = numberOfRatings
        self.pctApprove = pctApprove
        self.pctDisapprove = pctDisapprove
    }
}
