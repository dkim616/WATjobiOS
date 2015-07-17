//
//  EmployerInfoListViewController.swift
//  WATjob
//
//  Created by Fu Gordon on 15年7月15日.
//  Copyright (c) 2015年 Strawberry. All rights reserved.
//

import UIKit
import RealmSwift

class EmployerInfoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var gitEmployerInfoList: Array<GitEmployerInfo>;

    required init(coder aDecoder: NSCoder) {
        self.gitEmployerInfoList = [];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoList { (result) -> () in
            if let gitEmployerInfoList = result {
                self.gitEmployerInfoList = gitEmployerInfoList;
            }

            self.tableView.reloadData();
            
        }*/
        
        DataCenter.getGitEmployerInfoList { (results) -> () in
            if let results = results {
                self.gitEmployerInfoList = results
                //self.processSections()
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView Stuff
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitEmployerInfoList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EmployerInfoListCell", forIndexPath: indexPath) as! EmployerInfoListCell;
        
        var gitEmployerInfo = gitEmployerInfoList[indexPath.row];
        cell.companyNameLabel.text = gitEmployerInfo.company;
        cell.titleLabel.text = gitEmployerInfo.title;
        cell.locationLabel.text = gitEmployerInfo.location;
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // when selected do something
    }
}
