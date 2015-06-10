//
//  FavouriteInfoSessionListViewController.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-09.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation
import UIKit

class FavouriteInfoSessionListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var infoSessionList: Array<InfoSession>;
    
    required init(coder aDecoder: NSCoder) {
        self.infoSessionList = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataCenter.getFavouritedInfoSessionList { (results) -> () in
            if let results = results {
                self.infoSessionList = results
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoSessionList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavouriteInfoSessionListCell", forIndexPath: indexPath) as! InfoSessionListCell;
        
        var infoSession = infoSessionList[indexPath.row];
        cell.employerLabel.text = infoSession.employer;
        cell.startTimeLabel.text = infoSession.startTime;
        cell.endTimeLabel.text = infoSession.endTime;
        cell.locationLabel.text = infoSession.location;
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteButton.addTarget(self, action: "favouriteClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell;
    }
    
    func favouriteClicked(sender: UIButton) -> Void {
        // use the tag to mark the database.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
