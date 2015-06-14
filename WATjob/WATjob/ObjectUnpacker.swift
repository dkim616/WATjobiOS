//
//  ObjectUnpacker.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation
import SwiftyJSON

class ObjectUnpacker {
    init() {
        
    }
    
    class func unpackInfoSessionListDictionary(data: AnyObject?) -> Array<InfoSession> {
        var infoSessionList = Array<InfoSession>();
        if let data = data {
            let json = JSON(data);
            
            if let infoSessonDictionaryList = json["data"].array {

                for infoSessionDictionary in infoSessonDictionaryList {
                    if (infoSessionDictionary["id"] != "2918") {
                        var infoSession = InfoSession();
                        infoSession.id = infoSessionDictionary["id"].stringValue
                        infoSession.employer = infoSessionDictionary["employer"].stringValue
                        infoSession.date = NSDate()
                        infoSession.day = infoSessionDictionary["day"].stringValue
                        infoSession.startTime = infoSessionDictionary["start_time"].stringValue
                        infoSession.endTime = infoSessionDictionary["end_time"].stringValue
                        infoSession.location = infoSessionDictionary["location"].stringValue
                        infoSession.website = infoSessionDictionary["website"].stringValue
                        infoSession.infoSessionDescription = infoSessionDictionary["description"].stringValue;
                        infoSessionList.append(infoSession);
                    }
                }
            }
            
            return infoSessionList;
        }
        
        return [];
    }
    
    class func unpackEmployerInfoListDictionary(data: AnyObject?) -> Array<EmployerInfo> {
        var employerInfoList = Array<EmployerInfo>()
        if let data = data {
            let json = JSON(data)
            
            if let employerInfoResponse = json["response"].dictionary {
                if let employerInfoDictionaryList = employerInfoResponse["employers"]?.arrayValue {
                    for employerInfoDictionary in employerInfoDictionaryList {
                        var review = EmployerInfoFeaturedReview()
                        var ceo = EmployerInfoCEO()
                        
                        if let employerInfoDictionaryReview = employerInfoDictionary["featuredReview"].dictionary {
                            review = EmployerInfoFeaturedReview()
                            review.id = employerInfoDictionaryReview["id"]!.intValue
                            review.currentJob = employerInfoDictionaryReview["currentJob"]!.boolValue
                            review.reviewDateTime = NSDate()
                            review.jobTitle = employerInfoDictionaryReview["jobTitle"]!.stringValue
                            review.location = employerInfoDictionaryReview["location"]!.stringValue
                            review.headline = employerInfoDictionaryReview["headline"]!.stringValue
                            review.pros = employerInfoDictionaryReview["pros"]!.stringValue
                            review.cons = employerInfoDictionaryReview["cons"]!.stringValue
                            review.overall = employerInfoDictionaryReview["overall"]!.intValue
                            review.overallNumeric = employerInfoDictionaryReview["overallNumeric"]!.intValue
                        }
                        if let employerInfoDictionaryCEO = employerInfoDictionary["ceo"].dictionary {
                            ceo = EmployerInfoCEO()
                            ceo.name = employerInfoDictionaryCEO["name"]!.stringValue
                            ceo.title = employerInfoDictionaryCEO["title"]!.stringValue
                            ceo.numberOfRatings = employerInfoDictionaryCEO["numberOfRatings"]!.intValue
                            ceo.pctApprove = employerInfoDictionaryCEO["pctApprove"]!.intValue
                            ceo.pctDisapprove = employerInfoDictionaryCEO["pctDisapprove"]!.intValue
                        }
                        
                        var employerInfo = EmployerInfo()
                        employerInfo.id = employerInfoDictionary["id"].intValue
                        employerInfo.name = employerInfoDictionary["name"].stringValue
                        employerInfo.website = employerInfoDictionary["website"].stringValue
                        employerInfo.isEEP = employerInfoDictionary["isEEP"].boolValue
                        employerInfo.exactMatch = employerInfoDictionary["exactMatch"].boolValue
                        employerInfo.industry = employerInfoDictionary["industry"].stringValue
                        employerInfo.numberOfRatings = employerInfoDictionary["numberOfRatings"].intValue
                        employerInfo.squareLogo = employerInfoDictionary["squareLogo"].stringValue
                        employerInfo.overallRating = employerInfoDictionary["overallRating"].doubleValue
                        employerInfo.ratingDescription = employerInfoDictionary["ratingDescription"].stringValue
                        employerInfo.cultureAndValuesRating = employerInfoDictionary["cultureAndValueRating"].stringValue
                        employerInfo.seniorLeadershipRating = employerInfoDictionary["seniorLeadershipRating"].stringValue
                        employerInfo.compensationAndBenefitsRating = employerInfoDictionary["compensationAndBenefitsRating"].stringValue
                        employerInfo.careerOpportunitiesRating = employerInfoDictionary["careerOpportunitiesRating"].stringValue
                        employerInfo.workLifeBalanceRating = employerInfoDictionary["workLifeBalanceRating"].stringValue
                        employerInfo.recommendToFriendRating = employerInfoDictionary["recommendToFriendRating"].stringValue
                        employerInfo.featuredReview = review
                        employerInfo.ceo = ceo
                        
                        employerInfoList.append(employerInfo)
                    }
                }
            }
        }
        
        return employerInfoList
    }
    
}


