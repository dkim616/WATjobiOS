//
//  EmployerInfoListViewController.swift
//  WATjob
//
//  Created by Fu Gordon on 15年7月15日.
//  Copyright (c) 2015年 Strawberry. All rights reserved.
//

import UIKit
import RealmSwift

class EmployerInfoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    
    @IBOutlet weak var previousButton: UIBarButtonItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var gitEmployerInfoList: Array<GitEmployerInfo>;
    
    var page: Int = 0
    var searchActive: Bool = false
    
    required init(coder aDecoder: NSCoder) {
        self.gitEmployerInfoList = [];
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        /*
        WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoList { (result) -> () in
        if let result = result {
        self.gitEmployerInfoList = result;
        self.tableView.reloadData();
        }
        }*/
        
        DataCenter.getGitEmployerInfoList(page) { (results) -> () in
            if let results = results {
                self.gitEmployerInfoList = results
                //self.processSections()
                self.tableView.reloadData()
            }
        }
        
        if self.page == 0 {
            self.previousButton.enabled = false;
        }
        
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
        
        if self.page != 0 {
            self.previousButton.enabled = true;
        } else {
            self.previousButton.enabled = false;
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("EmployerInfoListCell", forIndexPath: indexPath) as! EmployerInfoListCell
        
        var gitEmployerInfo = self.gitEmployerInfoList[indexPath.row];
        cell.companyNameLabel.text = gitEmployerInfo.company;
        cell.titleLabel.text = gitEmployerInfo.title;
        cell.locationLabel.text = gitEmployerInfo.location;
        
        return cell;
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // when selected do something
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
        searchActive = true;
        self.page = 0;
        WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoListByParameters(searchBar.text, page: self.page) { (result) -> () in
            if let result = result {
                self.gitEmployerInfoList = result;
                self.tableView.reloadData();
            }
        }
    }
    
    @IBAction func nextButton(sender: AnyObject) {
        self.page = self.page + 1;
        
        if searchActive {
            WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoListByParameters(searchBar.text, page: self.page) { (result) -> () in
                if let result = result {
                    self.gitEmployerInfoList = result;
                    self.tableView.reloadData();
                }
            }
        } else {
            DataCenter.getGitEmployerInfoList(self.page) { (results) -> () in
                if let results = results {
                    self.gitEmployerInfoList = results
                    //self.processSections()
                    self.tableView.reloadData()
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func previousButton(sender: AnyObject) {
        self.page = self.page - 1;
        
        if searchActive {
            WJHTTPClient.sharedHTTPClient.getLatestGitEmployerInfoListByParameters(searchBar.text, page: self.page) { (result) -> () in
                if let result = result {
                    self.gitEmployerInfoList = result;
                    self.tableView.reloadData();
                }
            }
        } else {
            DataCenter.getGitEmployerInfoList(self.page) { (results) -> () in
                if let results = results {
                    self.gitEmployerInfoList = results
                    //self.processSections()
                    self.tableView.reloadData()
                }
            }
        }
        
        self.tableView.reloadData()
    }
}
