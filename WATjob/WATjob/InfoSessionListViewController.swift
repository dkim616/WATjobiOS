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
    var infoSessionListIndexToPass: Int
    
    required init(coder aDecoder: NSCoder) {
        self.infoSessionListIndexToPass = -1
        self.infoSessionList = [];
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
                self.tableView.reloadData()
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
            detailVC.toPass = self.tableView.indexPathForSelectedRow()!.row //self.infoSessionListIndexToPass
        }
    }
    
    // MARK: TableView Stuff
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoSessionList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("InfoSessionListCell", forIndexPath: indexPath) as! InfoSessionListCell;
        
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
        self.infoSessionListIndexToPass = indexPath.row
//        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("InfoSessionDetailView") as! InfoSessionDetailViewController
//        detailVC.toPass = indexPath.row
//        self.presentViewController(detailVC, animated: true, completion: nil)
//        performSegueWithIdentifier("sessionToSessionDetail", sender: self)
    }
}

