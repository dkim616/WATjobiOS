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
                completionHandler(result)
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
    
    class func getEmployerInfoList(completionHandler:(Array<EmployerInfo>?) -> ()) -> Void {
        let lastUpdated = NSUserDefaults.standardUserDefaults().valueForKey("lastUpdatedEmployerInfo") as? NSDate
        
        if (lastUpdated == nil || (lastUpdated?.dateByAddingTimeInterval(60 * 60 * 24).timeIntervalSinceReferenceDate < NSDate().timeIntervalSinceReferenceDate)) {
            WJHTTPClient.sharedHTTPClient.getLatestEmployerInfoList({ (result) -> () in
                completionHandler(result)
                
                let realm = Realm()
                realm.beginWrite()
                
                if let result = result {
                    for employerInfo in result {
                        realm.add(employerInfo, update: true)
                    }
                }
                realm.commitWrite()
            })
            NSUserDefaults.standardUserDefaults().setValue(NSDate(), forKey: "lastUpdatedEmployerInfo")
        } else {
            let realm = Realm()
            var results = realm.objects(EmployerInfo)
            
            completionHandler(arrayFromResultsForEmployerInfo(results))
        }
    }
    
    class func getFavouritedInfoSessionList(completionHandler:(Array<InfoSession>?) -> ()) -> Void {
        let realm = Realm()
        let result = realm.objects(InfoSession).filter("isFavourited == true").sorted("date");
        completionHandler(DataCenter.arrayFromResults(result));
    }
    
    class func getInfoSessionForId(id: String) -> InfoSession? {
        let realm = Realm()
        let result = realm.objectForPrimaryKey(InfoSession.self, key: id);
        return result;
    }

    class func arrayFromResults(results: Results<InfoSession>) -> Array<InfoSession> {
        var infoSessionList = Array<InfoSession>()
        for infoS in results {
            infoSessionList.append(infoS)
        }
        
        return infoSessionList
    }
    
    class func arrayFromResultsForEmployerInfo(results: Results<EmployerInfo>) -> Array<EmployerInfo> {
        var employerInfoList = Array<EmployerInfo>()
        
        for employerInfo in results {
            employerInfoList.append(employerInfo)
        }
        
        return employerInfoList
    }
    
    class func markFavouriteWithInfoSessionId(id: String) -> Void {
        let realm = Realm()
        var infoSession = realm.objectForPrimaryKey(InfoSession.self, key: id)
        
        if let infoSession = infoSession {
            realm.write({ () -> Void in
                infoSession.isFavourited = true;
            })
        }
    }
}
