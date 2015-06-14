//
//  EmployerInfo.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import RealmSwift

class EmployerInfo: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var website = ""
    dynamic var isEEP = false
    dynamic var exactMatch = false
    dynamic var industry = ""
    dynamic var numberOfRatings = 0
    dynamic var squareLogo = ""
    dynamic var overallRating = 0.0
    dynamic var ratingDescription = ""
    dynamic var cultureAndValuesRating = ""
    dynamic var seniorLeadershipRating = ""
    dynamic var compensationAndBenefitsRating = ""
    dynamic var careerOpportunitiesRating = ""
    dynamic var workLifeBalanceRating = ""
    dynamic var recommendToFriendRating = ""
    dynamic var featuredReview: EmployerInfoFeaturedReview?
    dynamic var ceo: EmployerInfoCEO?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
