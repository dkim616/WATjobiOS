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
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        if let data = data {
            let json = JSON(data);
            
            if let infoSessonDictionaryList = json["data"].array {

                for infoSessionDictionary in infoSessonDictionaryList {
                    if (infoSessionDictionary["id"] != "2918") {
                        var infoSession = InfoSession();
                        infoSession.id = infoSessionDictionary["id"].stringValue
                        infoSession.employer = infoSessionDictionary["employer"].stringValue
                        infoSession.date = formatter.dateFromString(infoSessionDictionary["date"].stringValue)
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
                        var review: EmployerInfoFeaturedReview!
                        var ceo: EmployerInfoCEO!
                        
                        if let employerInfoDictionaryReview = employerInfoDictionary["featuredReview"].dictionary {
                            review = EmployerInfoFeaturedReview(
                                id: employerInfoDictionaryReview["id"]!.intValue,
                                currentJob: employerInfoDictionaryReview["currentJob"]!.boolValue,
                                reviewDateTime: NSDate(),
                                jobTitle: employerInfoDictionaryReview["jobTitle"]!.stringValue,
                                location: employerInfoDictionaryReview["location"]!.stringValue,
                                headline: employerInfoDictionaryReview["headline"]!.stringValue,
                                pros: employerInfoDictionaryReview["pros"]!.stringValue,
                                cons: employerInfoDictionaryReview["cons"]!.stringValue,
                                overall: employerInfoDictionaryReview["overall"]!.intValue,
                                overallNumeric: employerInfoDictionaryReview["overallNumeric"]!.intValue
                            );
                        }
                        if let employerInfoDictionaryCEO = employerInfoDictionary["ceo"].dictionary {
                            ceo = EmployerInfoCEO(
                                name: employerInfoDictionaryCEO["name"]!.stringValue,
                                title: employerInfoDictionaryCEO["title"]!.stringValue,
                                numberOfRatings: employerInfoDictionaryCEO["numberOfRatings"]!.intValue,
                                pctApprove: employerInfoDictionaryCEO["pctApprove"]!.intValue,
                                pctDisapprove: employerInfoDictionaryCEO["pctDisapprove"]!.intValue
                            );
                        }
                        
                        var employerInfo = EmployerInfo(
                            id: employerInfoDictionary["id"].intValue,
                            name: employerInfoDictionary["name"].stringValue,
                            website: employerInfoDictionary["website"].stringValue,
                            isEEP: employerInfoDictionary["isEEP"].boolValue,
                            exactMatch: employerInfoDictionary["exactMatch"].boolValue,
                            industry: employerInfoDictionary["industry"].stringValue,
                            numberOfRatings: employerInfoDictionary["numberOfRatings"].intValue,
                            squareLogo: employerInfoDictionary["squareLogo"].stringValue,
                            overallRating: employerInfoDictionary["overallRating"].doubleValue,
                            ratingDescription: employerInfoDictionary["ratingDescription"].stringValue,
                            cultureAndValuesRating: employerInfoDictionary["cultureAndValueRating"].stringValue,
                            seniorLeadershipRating: employerInfoDictionary["seniorLeadershipRating"].stringValue,
                            compensationAndBenefitsRating: employerInfoDictionary["compensationAndBenefitsRating"].stringValue,
                            careerOpportunitiesRating: employerInfoDictionary["careerOpportunitiesRating"].stringValue,
                            workLifeBalanceRating: employerInfoDictionary["workLifeBalanceRating"].stringValue,
                            recommendToFriendRating: employerInfoDictionary["recommendToFriendRating"].stringValue,
                            featuredReview: review,
                            ceo: ceo
                        );
                        employerInfoList.append(employerInfo)
                    }
                }
            }
        }
        
        return employerInfoList
    }
    
}


