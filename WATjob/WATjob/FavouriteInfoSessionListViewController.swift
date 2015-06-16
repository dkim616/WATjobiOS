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
        self
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.registerClass(InfoSessionListCell.self, forCellReuseIdentifier: "FavouriteInfoSessionListCell");
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "favouriteToSessionDetail") {
            var detailVC = segue.destinationViewController as! InfoSessionDetailViewController
            let list = tableView.indexPathForSelectedRow()
            var infoSession = self.infoSessionList[(list?.row)!]
            detailVC.infoSessionId = infoSession.id
            detailVC.employerInfoId = 673773
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        updateFavouriteList()
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
        cell.favouriteButton.enabled = false;
        cell.favouriteButton.userInteractionEnabled = false;
        cell.favouriteButton.hidden = true;
        
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    // MARK: Helpers
    
    func updateFavouriteList() -> Void {
        DataCenter.getFavouritedInfoSessionList { (results) -> () in
            if let results = results {
                self.infoSessionList = results
                self.tableView.reloadData()
            }
        }
    }
}
