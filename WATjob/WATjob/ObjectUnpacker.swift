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
    
}


