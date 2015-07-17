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
            if let data: AnyObject = data {
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
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd hh:mm:ss.S"
            
            if let data: AnyObject = data {
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
                                review.reviewDateTime = NSDate() //formatter.dateFromString(employerInfoDictionaryReview["reviewDateTime"]!.stringValue)
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
                            employerInfo.cultureAndValuesRating = employerInfoDictionary["cultureAndValuesRating"].stringValue
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
        
        // Github jobs
        class func unpackGitEmployerInfoListDictionary(data: AnyObject?) -> Array<GitEmployerInfo> {
            var gitEmployerInfoList = Array<GitEmployerInfo>();
            let formatter = NSDateFormatter()
            //created_at": "Thu Jul 16 19:57:36 UTC 2015"
            formatter.dateFormat = "E MMM dd H:mm:ss z yyyy"
            
            if let data: AnyObject = data {
                let json = JSON(data);
                for index in 1...json.count {
                    var gitEmployerInfo = GitEmployerInfo();
                    gitEmployerInfo.id = json[index - 1]["id"].stringValue
                    gitEmployerInfo.createdAt = formatter.dateFromString(json[index - 1]["created_at"].stringValue)
                    gitEmployerInfo.title = json[index - 1]["title"].stringValue
                    gitEmployerInfo.location = json[index - 1]["location"].stringValue
                    gitEmployerInfo.type = json[index - 1]["type"].stringValue
                    gitEmployerInfo.jobDescription = json[index - 1]["description"].stringValue
                    gitEmployerInfo.howToApply = json[index - 1]["how_to_apply"].stringValue
                    gitEmployerInfo.company = json[index - 1]["company"].stringValue
                    gitEmployerInfo.companyUrl = json[index - 1]["company_url"].stringValue
                    gitEmployerInfo.companyLogo = json[index - 1]["company_logo"].stringValue
                    gitEmployerInfo.companyUrl = json[index - 1]["url"].stringValue
                    gitEmployerInfoList.append(gitEmployerInfo);
                }
                return gitEmployerInfoList;
            }
            
            return [];
        }
        
        class func unpackGitEmployerInfoArray(data: AnyObject?) -> GitEmployerInfo {
            var gitEmployerInfo = GitEmployerInfo();
            let formatter = NSDateFormatter()
            //created_at": "Thu Jul 16 19:57:36 UTC 2015"
            formatter.dateFormat = "E MMM dd H:mm:ss z yyyy"
            
            if let data: AnyObject = data {
                let json = JSON(data);
                gitEmployerInfo.id = json["id"].stringValue
                gitEmployerInfo.createdAt = formatter.dateFromString(json["created_at"].stringValue)
                gitEmployerInfo.title = json["title"].stringValue
                gitEmployerInfo.location = json["location"].stringValue
                gitEmployerInfo.type = json["type"].stringValue
                gitEmployerInfo.jobDescription = json["description"].stringValue
                gitEmployerInfo.howToApply = json["how_to_apply"].stringValue
                gitEmployerInfo.company = json["company"].stringValue
                gitEmployerInfo.companyUrl = json["company_url"].stringValue
                gitEmployerInfo.companyLogo = json["company_logo"].stringValue
                gitEmployerInfo.companyUrl = json["url"].stringValue
            }
            return gitEmployerInfo;
        }
        
    }
    
    
