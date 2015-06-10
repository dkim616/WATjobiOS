//
//  WJDataCenter.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation
import RealmSwift

class DataCenter {
    class func getInfoSessionList(completionHandler:(Array<InfoSession>?) -> ()) -> Void {
        let lastUpdated = NSUserDefaults.standardUserDefaults().valueForKey("lastUpdated") as? NSDate
        
        if (lastUpdated == nil || (lastUpdated?.dateByAddingTimeInterval(60*60*24).timeIntervalSinceReferenceDate < NSDate().timeIntervalSinceReferenceDate)) {
            WJHTTPClient.sharedHTTPClient.getLatestInfoSessionList({ (result) -> () in
                completionHandler(result);
                let realm = Realm()
                realm.beginWrite()
                if let result = result {
                    for infoSession in result {
                        realm.add(infoSession, update: true)
                    }
                }
                realm.commitWrite()
            })
            NSUserDefaults.standardUserDefaults().setValue(NSDate(), forKey: "lastUpdated")
        } else {
            let realm = Realm()
            var results = realm.objects(InfoSession)
            completionHandler(arrayFromResults(results))
        }
    }
    
    class func getFavouritedInfoSessionList(completionHandler:(Results<InfoSession>?) -> ()) -> Void {
        let realm = Realm()
        let result = realm.objects(InfoSession).filter("isFavourited = true").sorted("date");
        completionHandler(result);
    }

    class func arrayFromResults(results: Results<InfoSession>) -> Array<InfoSession> {
        var infoSessionList = Array<InfoSession>()
        for infoS in results {
            infoSessionList.append(infoS)
        }
        
        return infoSessionList
    }
}
