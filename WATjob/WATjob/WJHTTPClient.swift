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

let WaterlooAPIKey = "8b0caec7cca16061c9f43046ff68ef93";

class WJHTTPClient {
    static let sharedHTTPClient = WJHTTPClient()
    
    init() {
        //inital network setup
    }
    
    func getLatestInfoSessionList(completionHandler:(Array<InfoSession>?) -> ()) -> Void {
        Alamofire.request(.GET, waterlooOpenDataBaseUrl+"infosessions.json", parameters: ["key": WaterlooAPIKey], encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, resonse, JSON, error) -> Void in
            completionHandler(ObjectUnpacker.unpackInfoSessionListDictionary(JSON));
        }
    }
    
}
