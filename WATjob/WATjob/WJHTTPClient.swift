//
//  WJHTTPClient.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-07.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation
import Alamofire

var sampleUrl: String = "https://api.uwaterloo.ca/v2/resources/infosessions.json?key=8b0caec7cca16061c9f43046ff68ef93";
var waterlooOpenData = "https://api.uwaterloo.ca/v2/resources/infosessions.json";

class WJHTTPClient {
    static let sharedHTTPClient = WJHTTPClient()
    
    init() {
        //inital network setup
    }
    
    func getLatestInfoSessionList(completionHandler:(Array<InfoSession>?) -> ()) -> Void {
        Alamofire.request(.GET, waterlooOpenData, parameters: ["key": "8b0caec7cca16061c9f43046ff68ef93"], encoding: .URL).responseJSON(options: NSJSONReadingOptions.MutableContainers) { (request, resonse, JSON, error) -> Void in
            completionHandler(ObjectUnpacker.unpackInfoSessionListDictionary(JSON));
        }
    }
    
}
