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
                        var infoSession = InfoSession(
                            id: infoSessionDictionary["id"].stringValue,
                            employer: infoSessionDictionary["employer"].stringValue,
                            date: NSDate(),
                            day: infoSessionDictionary["day"].stringValue,
                            startTime: infoSessionDictionary["start_time"].stringValue,
                            endTime: infoSessionDictionary["end_time"].stringValue,
                            location: infoSessionDictionary["location"].stringValue,
                            website: infoSessionDictionary["website"].stringValue);
                        infoSessionList.append(infoSession);
                    }
                }
            }
            
            return infoSessionList;
        }
        
        return [];
    }
    
}


