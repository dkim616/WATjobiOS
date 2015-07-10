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
    @IBOutlet weak var calendarButton: UIBarButtonItem!
    
    @IBOutlet weak var calendarContainerView: UIView!
    
    
    @IBOutlet weak var calendarMenuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    
    var shouldShowDaysOut = true
    var animationFinished = true
    
    let infoSessionListTitle = "Info Session List"
    let calendarViewCentreHeight:CGFloat = 64 + 200
    let tableViewInsetHeight:CGFloat = 400
    let screenWidth = UIScreen.mainScreen().bounds.width
    
    var isCalendarOnScreen:Bool
    
    var infoSessionList: Array<InfoSession>;
    
    var sections: Array<Array<InfoSession>>;
    
    var employerInfoList: Array<EmployerInfo>;
    
    required init(coder aDecoder: NSCoder) {
        self.infoSessionList = [];
        self.employerInfoList = [];
        self.sections = [];
        self.isCalendarOnScreen = false
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
        self.navigationItem.title = infoSessionListTitle
        
        self.calendarContainerView.center = CGPointMake(self.screenWidth/2, -self.calendarViewCentreHeight)
        
        let backItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        calendarMenuView.commitMenuViewUpdate()
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
        cell.favouriteButton.rowNumber = indexPath.row
        cell.favouriteButton.sectionNumber = indexPath.section
        cell.favouriteButton.addTarget(self, action: "favouriteClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
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
                self.navigationItem.title = self.infoSessionListTitle
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
}

extension InfoSessionListViewController:CVCalendarViewDelegate {
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView
    {
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
        if (Int(arc4random_uniform(3)) == 1)
        {
            return true
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
        return true
    }
    
    func dotMarker(shouldShowOnDayView dayView: CVCalendarDayView) -> Bool {
        let day = dayView.date.day
        let randomDay = Int(arc4random_uniform(31))
        if day == randomDay {
            return true
        }
        
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
        return true
    }
}

extension InfoSessionListViewController:CVCalendarViewAppearanceDelegate {
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 2
    }
}
