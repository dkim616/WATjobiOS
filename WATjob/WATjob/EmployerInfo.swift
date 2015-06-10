//
//  EmployerInfo.swift
//  WATjob
//
//  Created by Daniel Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation

class EmployerInfo {
    var id: Int
    var name: String
    var website: String
    var isEEP: Bool
    var exactMatch: Bool
    var industry: String
    var numberOfRatings: Int
    var squareLogo: String
    var overallRating: Double
    var ratingDescription: String
    var cultureAndValuesRating: String
    var seniorLeadershipRating: String
    var compensationAndBenefitsRating: String
    var careerOpportunitiesRating: String
    var workLifeBalanceRating: String
    var recommendToFriendRating: String
    var featuredReview: EmployerInfoFeaturedReview
    var ceo: EmployerInfoCEO
    
    init(
        id: Int,
        name: String,
        website: String,
        isEEP: Bool,
        exactMatch: Bool,
        industry: String,
        numberOfRatings: Int,
        squareLogo: String,
        overallRating: Double,
        ratingDescription: String,
        cultureAndValuesRating: String,
        seniorLeadershipRating: String,
        compensationAndBenefitsRating: String,
        careerOpportunitiesRating: String,
        workLifeBalanceRating: String,
        recommendToFriendRating: String,
        featuredReview: EmployerInfoFeaturedReview,
        ceo: EmployerInfoCEO
        ) {
            self.id = id
            self.name = name
            self.website = website
            self.isEEP = isEEP
            self.exactMatch = exactMatch
            self.industry = industry
            self.numberOfRatings = numberOfRatings
            self.squareLogo = squareLogo
            self.overallRating = overallRating
            self.ratingDescription = ratingDescription
            self.cultureAndValuesRating = cultureAndValuesRating
            self.seniorLeadershipRating = seniorLeadershipRating
            self.compensationAndBenefitsRating = compensationAndBenefitsRating
            self.careerOpportunitiesRating = careerOpportunitiesRating
            self.workLifeBalanceRating = workLifeBalanceRating
            self.recommendToFriendRating = recommendToFriendRating
            self.featuredReview = featuredReview
            self.ceo = ceo
    }
}
