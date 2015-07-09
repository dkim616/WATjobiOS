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

//            detailVC.infoSession = infoSessionList[self.tableView.indexPathForSelectedRow()!.row]
            detailVC.employerInfoId = 673773
            
            // Syntax error if I move detailVC outside of if-else statement
            if searchActive {
                var infoSession = self.filtered[(self.tableView.indexPathForSelectedRow()?.row)!]
                detailVC.infoSessionId = infoSession.id
            } else {
                var infoSession = self.sections[(self.tableView.indexPathForSelectedRow()?.section)!][(self.tableView.indexPathForSelectedRow()?.row)!]
                detailVC.infoSessionId = infoSession.id
            }
        }
    }
    
    // Jimmy - Search Bar 
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
        self.tableView.reloadData()
    }
    
    // MARK: TableView Stuff
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        return self.sections[section].count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if searchActive {
            return 1
        }
        return self.sections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoSessionListCell", forIndexPath: indexPath) as! InfoSessionListCell;

        // Syntax error for infoSession if I move the cell elements outside of if-else statement
        if searchActive {
            var infoSession = self.filtered[indexPath.row]
            cell.employerLabel.text = infoSession.employer;
            cell.startTimeLabel.text = infoSession.startTime;
            cell.endTimeLabel.text = infoSession.endTime;
            cell.locationLabel.text = infoSession.location;
            cell.favouriteButton.rowNumber = indexPath.row
            cell.favouriteButton.sectionNumber = indexPath.section
            cell.favouriteButton.addTarget(self, action: "favouriteClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        } else {
            var infoSession = self.sections[indexPath.section][indexPath.row]
            cell.employerLabel.text = infoSession.employer;
            cell.startTimeLabel.text = infoSession.startTime;
            cell.endTimeLabel.text = infoSession.endTime;
            cell.locationLabel.text = infoSession.location;
            cell.favouriteButton.rowNumber = indexPath.row
            cell.favouriteButton.sectionNumber = indexPath.section
            cell.favouriteButton.addTarget(self, action: "favouriteClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        }
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
    
    func favouriteClicked(sender: FavouriteButton) -> Void {
        let infoSession = self.sections[sender.sectionNumber][sender.rowNumber]
        DataCenter.markFavouriteWithInfoSessionId(infoSession.id)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func processSections() {
        var currentDate = NSDate()
        var final = Array<Array<InfoSession>>()
        var currentIndex = 0
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
        self.sections = final;
    }
}

