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
    
    @IBOutlet weak var calendarButton: UIBarButtonItem!
    
    @IBOutlet weak var calendarContainerView: UIView!
    
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    var shouldShowDaysOut = true
    var animationFinished = true
    
    let calendarViewCentreHeight:CGFloat = 64 + 200
    let tableViewInsetHeight:CGFloat = 400
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    var isCalendarOnScreen:Bool
    
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
        self.isCalendarOnScreen = false
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
        
        self.calendarButton.title = "Calendar"
        self.navigationItem.title = "Info Sessions"
        
        let backItem = UIBarButtonItem(title: "Back", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var width = self.view.bounds.width
        
        calendarView.commitCalendarViewUpdate()
        calendarMenuView.commitMenuViewUpdate()
        
        if !isCalendarOnScreen && self.calendarContainerView.center.y > 0 {
            self.calendarContainerView.center = CGPointMake(self.screenWidth/2, -self.calendarViewCentreHeight)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "sessionToSessionDetail") {
            var detailVC = segue.destinationViewController as! InfoSessionDetailViewController
            let list = tableView.indexPathForSelectedRow()
            var infoSession = self.sections[(self.tableView.indexPathForSelectedRow()?.section)!][(self.tableView.indexPathForSelectedRow()?.row)!]
            detailVC.infoSessionId = infoSession.id
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
        view.endEditing(true)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
            tableView.setEditing(false, animated: true)
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
    
    @IBAction func CalendarButtonPressed(sender: UIBarButtonItem) {
        if isCalendarOnScreen {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.calendarContainerView.center = CGPointMake(self.screenWidth/2, -self.calendarViewCentreHeight)
                
                self.tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
                
                var offsetPoint = self.tableView.contentOffset
                if offsetPoint.y <= -self.tableViewInsetHeight {
                    offsetPoint.y += self.tableViewInsetHeight
                }
                
                self.tableView.contentOffset = offsetPoint
                self.navigationItem.title = "Info Sessions"
            }, completion: { (Bool) -> Void in
                self.calendarContainerView.hidden = true
                self.calendarMenuView.hidden = true
                self.calendarView.hidden = true
                self.isCalendarOnScreen = false
            })
            
        } else {
            self.calendarContainerView.hidden = false
            self.calendarMenuView.hidden = false
            self.calendarView.hidden = false
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.calendarContainerView.center = CGPointMake(self.screenWidth/2, self.calendarViewCentreHeight)
                
                self.tableView.contentInset = UIEdgeInsets(top: self.tableViewInsetHeight+64, left: 0, bottom: 0, right: 0)
                
                var offsetPoint = self.tableView.contentOffset
                offsetPoint.y -= self.tableViewInsetHeight
                self.tableView.contentOffset = offsetPoint
                
                self.navigationItem.title = CVDate(date: NSDate()).globalDescription
            }, completion: { (Bool) -> Void in
                self.isCalendarOnScreen = true
            })
        }
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

//MARK: calendarView stuff

extension InfoSessionListViewController:CVCalendarViewDelegate {
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView
    {
        for subview in dayView.subviews {
            if let view = subview as? CVAuxiliaryView {
                if view.fillColor == UIColor.colorFromCode(0xCCCCCC) {
                    view.removeFromSuperview()
                }
            }
        }
        
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.bounds, shape: CVShape.Circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView
    {
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = .blueColor()
        
        var newView = UIView(frame: dayView.bounds)
        
        let diameter: CGFloat = (newView.bounds.width) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRectMake(newView.frame.midX-radius, newView.frame.midY-radius-ringVerticalOffset, diameter, diameter)
        
        ringLayer = CAShapeLayer()
        
        for subview in dayView.subviews {
            if var layers = subview.layer.sublayers {
                subview.removeFromSuperview()
            }
        }
        
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.CGColor
        
        var ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = CGRectInset(rect, ringLineWidthInset, ringLineWidthInset)
        let centrePoint: CGPoint = CGPointMake(ringRect.midX, ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.CGPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool
    {
        for infoSession in infoSessionList {
            if var date1 = infoSession.date, date2 = dayView.date {
                if date1 == date2.convertedDate() {
                    return true
                }
            }
        }

        return false
    }
    
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    func didSelectDayView(dayView: CVCalendarDayView) {
        var section = 0
        
        for sessionList in sections {
            if var infoSession = sessionList.first, date = dayView.date {
                if infoSession.date == date.convertedDate() {
                    var indexPath:NSIndexPath = NSIndexPath(forRow: 0, inSection: section)
                    tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
                }
            }
            
            section++
        }
        
        let date = dayView.date
        println("\(calendarView.presentedDate.commonDescription) is selected!")
    }
    
    func presentedDateUpdated(date: CVDate) {
        if self.navigationItem.title != date.globalDescription && self.animationFinished {
            
            UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.navigationItem.title = date.globalDescription
                
                }) { _ in
                    self.animationFinished = true
            }
            
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
//        let day = dayView.date.day
//        let randomDay = Int(arc4random_uniform(31))
//        if day == randomDay {
//            return true
//        }
        
        return false
    }
    
    func dotMarker(colorOnDayView dayView: CVCalendarDayView) -> [UIColor] {
        let day = dayView.date.day
        
        let red = CGFloat(arc4random_uniform(600) / 255)
        let green = CGFloat(arc4random_uniform(600) / 255)
        let blue = CGFloat(arc4random_uniform(600) / 255)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        let numberOfDots = Int(arc4random_uniform(3) + 1)
        switch(numberOfDots) {
        case 2:
            return [color, color]
        case 3:
            return [color, color, color]
        default:
            return [color] // return 1 dot
        }
    }
    
    func dotMarker(shouldMoveOnHighlightingOnDayView dayView: CVCalendarDayView) -> Bool {
        return false
    }
}

extension InfoSessionListViewController:CVCalendarMenuViewDelegate {
    
}

extension InfoSessionListViewController:CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}
