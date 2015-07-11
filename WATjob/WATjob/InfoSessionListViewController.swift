//
//  InfoSessionListViewController.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-06.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit
import RealmSwift

class InfoSessionListViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var infoSessionList: Array<InfoSession>;
    var sections: Array<Array<InfoSession>>;
    var employerInfoList: Array<EmployerInfo>;
    
    var searchActive: Bool = false
    var filtered: [InfoSession] = []
    var employerNameList: Array<String>;
    
    required init(coder aDecoder: NSCoder) {
        self.infoSessionList = [];
        self.employerInfoList = [];
        self.sections = [];
        self.employerNameList = [];
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
        
        searchBar.delegate = self
        
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
            let list = tableView.indexPathForSelectedRow()
            var infoSession = self.infoSessionList[(list?.row)!]
            detailVC.infoSessionId = infoSession.id
            detailVC.employerInfoId = 673773
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

        var infoSession = self.sections[indexPath.section][indexPath.row]
        cell.employerLabel.text = infoSession.employer;
        cell.startTimeLabel.text = infoSession.startTime;
        cell.endTimeLabel.text = infoSession.endTime;
        cell.locationLabel.text = infoSession.location;
//        cell.favouriteButton.rowNumber = indexPath.row
//        cell.favouriteButton.sectionNumber = indexPath.section
//        cell.favouriteButton.addTarget(self, action: "favouriteClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // MARK: Cell Options
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        var favAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Add to\nFavourite" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            var fav: FavouriteButton = FavouriteButton()
            fav.rowNumber = indexPath.row
            fav.sectionNumber = indexPath.section
            self.favouriteClicked(fav)
        })
        favAction.backgroundColor = UIColor(red: 63.0/255.0, green: 146.0/255.0, blue: 198.0/255.0, alpha: 1.0)
        return [favAction]
    }
    
    // MARK: Sections
    
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
    
    func processSections() {
        var currentDate = NSDate()
        var final = Array<Array<InfoSession>>()
        var currentIndex = 0
        if searchActive {
            for infoSession in self.filtered {
                employerNameList.append(infoSession.employer)
                if let date = infoSession.date {
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
        } else {
            for infoSession in self.infoSessionList {
                employerNameList.append(infoSession.employer)
                if let date = infoSession.date {
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
        }
        self.sections = final;
    }
    
    // MARK: Favourite
    
    func favouriteClicked(sender: FavouriteButton) -> Void {
        let infoSession = self.sections[sender.sectionNumber][sender.rowNumber]
        DataCenter.markFavouriteWithInfoSessionId(infoSession.id)
    }
    
    // MARK: Search Bar
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = self.infoSessionList.filter({ (text) -> Bool in
            let tmp: NSString = text.employer
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if filtered.count == 0 {
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.processSections()
        self.tableView.reloadData()
    }
}

