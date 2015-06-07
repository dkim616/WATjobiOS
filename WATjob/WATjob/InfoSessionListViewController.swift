//
//  InfoSessionListViewController.swift
//  WATjob
//
//  Created by Hyun Bin Kim on 2015-06-06.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit

class InfoSessionListViewController:  UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var infoSessionList: Array<InfoSession>;
    
    required init(coder aDecoder: NSCoder) {
        self.infoSessionList = [];
        super.init(coder: aDecoder);
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WJHTTPClient.sharedHTTPClient.getLatestInfoSessionList { (result) -> () in
            if let infoSessionList = result {
                self.infoSessionList = infoSessionList;
            }
        
            self.tableView.reloadData();
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            
        return cell;

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // when selected do something
    }


}

