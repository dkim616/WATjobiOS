//
//  WJHTTPClient.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation
import Alamofire

var waterlooOpenDataBaseUrl = "https://api.uwaterloo.ca/v2/resources/"
let waterlooAPIKey = "8b0caec7cca16061c9f43046ff68ef93"

var glassdoorAPIBaseUrl = "http://api.glassdoor.com/api/"
let glassdoorAPIID = "36943"
let glassdoorAPIKey = "dnJJ5zpvHW7"
let userIP = "0.0.0.0"

var githubAPIBaseUrl = "https://jobs.github.com/"

class WJHTTPClient {
    static let sharedHTTPClient = WJHTTPClient()
    
    init() {
        //inital network setup
    }
    
    func getLatestInfoSessionList(completionHandler:(Array<InfoSession>?) -> ()) -> Void {
        Alamofire.request(.GET, waterlooOpenDataBaseUrl + "infosessions.json", parameters: ["key": waterlooAPIKey], encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, resonse, JSON, error) -> Void in
            completionHandler(ObjectUnpacker.unpackInfoSessionListDictionary(JSON));
        }
    }
    
    func getLatestEmployerInfoList(completetionHandler:(Array<EmployerInfo>?) -> ()) -> Void {
        Alamofire.request(.GET, glassdoorAPIBaseUrl + "api.htm", parameters: [
            "t.p": glassdoorAPIID,
            "t.k": glassdoorAPIKey,
            "userip": userIP,
            "useragent": "",
            "format": "json",
            "v": "1",
            "action": "employers",
            "e": "Kik Interactive"
        ], encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, resonse, JSON, error) -> Void in
            completetionHandler(ObjectUnpacker.unpackEmployerInfoListDictionary(JSON));
        }
    }
    
    func getLatestEmployerInfoListByCompanyName(companyName: String, completionHandler:(Array<EmployerInfo>?) -> ()) -> Void {
        Alamofire.request(.GET, glassdoorAPIBaseUrl + "api.htm", parameters: [
            "t.p": glassdoorAPIID,
            "t.k": glassdoorAPIKey,
            "userip": userIP,
            "useragent": "",
            "format": "json",
            "v": "1",
            "action": "employers",
            "e": companyName
            ], encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, resonse, JSON, error) -> Void in
                completionHandler(ObjectUnpacker.unpackEmployerInfoListDictionary(JSON));
        }
    }
    
    func getLatestEmployerInfoByCompanyName(companyName: String, completionHandler:(EmployerInfo?) -> ()) -> Void {
            Alamofire.request(.GET, glassdoorAPIBaseUrl + "api.htm", parameters: [
                "t.p": glassdoorAPIID,
                "t.k": glassdoorAPIKey,
                "userip": userIP,
                "useragent": "",
                "format": "json",
                "v": "1",
                "action": "employers",
                "e": companyName
                ], encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, resonse, JSON, error) -> Void in
                    completionHandler(ObjectUnpacker.unpackEmployerInfoListDictionary(JSON).last);
        }
    }

    //Github jobs
    func getLatestGitEmployerInfoList(completionHandler:(Array<GitEmployerInfo>?) -> ()) -> Void {
        Alamofire.request(.GET, githubAPIBaseUrl + "positions.json", parameters: nil, encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, response, JSON, error) -> Void in
            completionHandler(ObjectUnpacker.unpackGitEmployerInfoListDictionary(JSON));
        }
    }
    
    func getLatestGitEmployerInfoById(gitEmployerInfoId: String, completionHandler:(GitEmployerInfo?) -> ()) -> Void {
        Alamofire.request(.GET, githubAPIBaseUrl + "positions/" + gitEmployerInfoId + ".json", parameters: nil, encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, response, JSON, error) -> Void in
            completionHandler(ObjectUnpacker.unpackGitEmployerInfoArray(JSON));
        }
    }
}
