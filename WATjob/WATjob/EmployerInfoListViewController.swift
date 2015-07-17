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
        
        
        WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoList { (result) -> () in
            if let result = result {
                self.gitEmployerInfoList = result;
                self.tableView.reloadData();
            }
        }
        /*
        DataCenter.getGitEmployerInfoList { (results) -> () in
            if let results = results {
                self.gitEmployerInfoList = results
                //self.processSections()
                self.tableView.reloadData()
            }
        }*/

        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: TableView Stuff

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "employerToEmployerDetail") {
            var detailVC = segue.destinationViewController as! EmployerInfoDetailViewController
            let list = tableView.indexPathForSelectedRow()
            var gitEmployerInfo = self.gitEmployerInfoList[(list?.row)!]
            detailVC.gitEmployerInfoId = gitEmployerInfo.id
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gitEmployerInfoList.count;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EmployerInfoListCell", forIndexPath: indexPath) as! EmployerInfoListCell
 
        var gitEmployerInfo = self.gitEmployerInfoList[indexPath.row];
        cell.companyNameLabel.text = gitEmployerInfo.company;
        cell.titleLabel.text = gitEmployerInfo.title;
        cell.locationLabel.text = gitEmployerInfo.location;
        
        var imgURL: NSURL = NSURL(string: gitEmployerInfo.companyUrl)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                if error == nil {
                    cell.companyImage.image = UIImage(data: data);
                }
        })
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // when selected do something
    }
}
