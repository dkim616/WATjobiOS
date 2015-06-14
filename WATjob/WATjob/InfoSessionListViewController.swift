//
//  InfoSessionListViewController.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-06.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit
import RealmSwift

class InfoSessionListViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var infoSessionList: Array<InfoSession>;
    
    var sections: Array<Array<InfoSession>>;
    
    var employerInfoList: Array<EmployerInfo>;
    
    required init(coder aDecoder: NSCoder) {
        self.infoSessionList = [];
        self.employerInfoList = [];
        self.sections = [];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        WJHTTPClient.sharedHTTPClient.getLatestInfoSessionList { (result) -> () in
//            if let infoSessionList = result {
//                self.infoSessionList = infoSessionList;
//                self.tableView.reloadData();
//            }
//        }
        
        DataCenter.getInfoSessionList { (results) -> () in
            if let results = results {
                self.infoSessionList = results
                self.processSections()
                self.tableView.reloadData()
                
            }
        }
        
        DataCenter.getEmployerInfoList() { (results) -> () in
            if let results = results {
                self.employerInfoList = results
            }
        }
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sessionToSessionDetail") {
            var detailVC = segue.destinationViewController as! InfoSessionDetailViewController
            detailVC.employerInfo = employerInfoList[self.tableView.indexPathForSelectedRow()!.row]
        }
    }
    
    // MARK: TableView Stuff
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoSessionListCell", forIndexPath: indexPath) as! InfoSessionListCell;
        
//        var infoSession = infoSessionList[indexPath.section];
        var infoSession = self.sections[indexPath.section][indexPath.row]
        cell.employerLabel.text = infoSession.employer;
        cell.startTimeLabel.text = infoSession.startTime;
        cell.endTimeLabel.text = infoSession.endTime;
        cell.locationLabel.text = infoSession.location;
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteButton.addTarget(self, action: "favouriteClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let infoSession = self.sections[section].first
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd, yyyy";
        if let date = infoSession?.date {
            return formatter.stringFromDate(date)
        } else {
            //Error here
            return ""
        }
    }
    
    func favouriteClicked(sender: UIButton) -> Void {
        let infoSession = self.infoSessionList[sender.tag]
        DataCenter.markFavouriteWithInfoSessionId(infoSession.id)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("InfoSessionDetailView") as! InfoSessionDetailViewController
//        detailVC.toPass = indexPath.row
//        self.presentViewController(detailVC, animated: true, completion: nil)
//        performSegueWithIdentifier("sessionToSessionDetail", sender: self)
    }
    
    func processSections() {
//        var map = NSMutableDictionary()
//        var map2 = Dictionary<NSDate, Array<InfoSession>>()
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "MMM dd, yyyy";
        
//        for infoSession in self.infoSessionList {
//            if let date = infoSession.date {
//                let dateString = formatter.stringFromDate(date)
//                if (map.valueForKey(dateString) != nil) {
//                    var array = map[dateString] as? Array<InfoSession>
//                    array?.append(infoSession)
//                    map.setValue(array, forKey: dateString)
//                } else {
//                    var array = Array<InfoSession>()
//                    array.append(infoSession)
//                    map.setValue(array, forKey: dateString)
//                }
//            }
//        }
//        let final = map.allValues as? Array<Array<InfoSession>>
//        final?.sort{ $0[0].date  < $1[0].date }
//        println(final)
//        for infoSession in self.infoSessionList {
//            if let date = infoSession.date {
//                println(date)
//                if (map2[date] != nil) {
//                    var array = map[date] as? Array<InfoSession>
//                    array?.append(infoSession)
//                } else {
//                    var array = Array<InfoSession>()
//                    array.append(infoSession)
//                    map2[date] = array
//                }
//            }
//        }
//        var answer = Array<Array<InfoSession>>()
//        for (key, value) in map2 {
//            answer.append(value)
//        }
//        println(answer)
        
//        println(final)
        var currentDate = NSDate()
        var final = Array<Array<InfoSession>>()
        var currentIndex = 0
        for infoSession in self.infoSessionList {
            if let date = infoSession.date {
                println(date)
                if currentDate != date {
                    currentIndex++
                    var newArray = Array<InfoSession>()
                    newArray.append(infoSession)
                    final.append(newArray)
                    currentDate = date
                } else {
                    var currentArray = final.last
                    currentArray?.append(infoSession)
                    final.removeLast()
                    final.append(currentArray!)
                }
            }
        }
        self.sections = final;
    }
}

