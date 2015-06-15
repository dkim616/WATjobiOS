//
//  WJCalendarCell.swift
//  WATjob
//
//  Created by Jae Hee Cho on 2015-06-13.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import UIKit
import Foundation

class WJCalendarCell: UICollectionViewCell {
    var titleLabel:UILabel
    var subtitleLabel:UILabel
//    var backgroundLayer:CAShapeLayer
//    var eventLayer:CAShapeLayer
    
    var subtitle:NSString!
    
    var date:NSDate!
    var currentDate:NSDate!
    var month:NSDate!
    var year:NSDate!
    
    var hasEvent:Bool!

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        titleLabel = UILabel(frame: CGRectZero)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.font = UIFont(name: "title", size: 15)
        titleLabel.textColor = UIColor.darkTextColor()
        
        subtitleLabel = UILabel(frame: CGRectZero)
        subtitleLabel.textAlignment = NSTextAlignment.Center
        subtitleLabel.font = UIFont(name: "subtitle", size: 10)
        subtitleLabel.textColor = UIColor.lightGrayColor()
        
//        backgroundLayer = CAShapeLayer()
//        backgroundLayer.backgroundColor = UIColor.clearColor().CGColor
//        backgroundLayer.hidden = true
//        
//        eventLayer = CAShapeLayer()
//        eventLayer.backgroundColor = UIColor.clearColor().CGColor
//        eventLayer.fillColor = UIColor.cyanColor().CGColor
//        eventLayer.path = UIBezierPath(ovalInRect: eventLayer.bounds).CGPath
//        eventLayer.hidden = true
        
        super.init(frame: frame)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(subtitleLabel)
//        self.contentView.layer.addSublayer(backgroundLayer)
//        self.contentView.layer.addSublayer(eventLayer)
        
//        var titleHight:CGFloat = self.bounds.size.height*5.0/6.0
//        var diameter:CGFloat = min(self.bounds.size.height*5.0/6.0, self.bounds.size.width)
//        backgroundLayer.frame = CGRectMake(self.bounds.size.width-diameter/2, (titleHight-diameter)/2, diameter, diameter)
//        
//        var eventSize:CGFloat = backgroundLayer.frame.size.height/6.0
//        eventLayer.frame = CGRectMake((backgroundLayer.frame.size.width-eventSize)/2+backgroundLayer.frame.origin.x, CGRectGetMaxY(backgroundLayer.frame)+eventSize*0.2, eventSize*0.8, eventSize*0.8)
//        eventLayer.path = UIBezierPath(ovalInRect: eventLayer.bounds).CGPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        CATransaction.setDisableActions(true)
    }
    
    func configureCell() {
        var dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        let dateString = dateFormatter.stringFromDate(date)
        titleLabel.text = dateString
        subtitleLabel.text = subtitle as String
        titleLabel.textColor = titleColourForCurrentState()
        subtitleLabel.textColor = subtitleColourForCurrentState()
//        backgroundLayer.fillColor = backgroundColourForCurrentState().CGColor
        
        var titleHeight:CGFloat = titleLabel.frame.height
        if ((subtitleLabel.text) != nil) {
            subtitleLabel.hidden = false;
            var subtitleHeight:CGFloat = subtitleLabel.frame.height
            var height:CGFloat = titleHeight + subtitleHeight;
            
            titleLabel.frame = CGRectMake(0,
            (CGRectGetHeight(self.contentView.frame)*5.0/6.0-height)*0.5,
            CGRectGetWidth(self.contentView.frame),
            titleHeight);
            
            subtitleLabel.frame = CGRectMake(0,
            CGRectGetMaxY(self.contentView.frame) - (CGRectGetHeight(self.contentView.frame)-titleLabel.font.pointSize),
            CGRectGetWidth(self.contentView.frame),
            subtitleHeight);
        } else {
            titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), floor(CGRectGetHeight(self.contentView.frame)*5.0/6.0));
            subtitleLabel.hidden = true;
        }
//        backgroundLayer.hidden = !self.selected
//        backgroundLayer.path = UIBezierPath(ovalInRect: backgroundLayer.bounds).CGPath
//        eventLayer.fillColor = selectedBlue.colorWithAlphaComponent(0.75).CGColor
//        eventLayer.hidden = !hasEvent
    }
    
    func showAnimation() {
//        backgroundLayer.hidden = false
//        backgroundLayer.path = UIBezierPath(ovalInRect: backgroundLayer.bounds).CGPath
//        backgroundLayer.fillColor = backgroundColourForCurrentState().CGColor
//        var group:CAAnimationGroup = CAAnimationGroup()
//        var zoomOut:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
//        zoomOut.fromValue = 0.3;
//        zoomOut.toValue = 1.2;
//        zoomOut.duration = animationDuration/4*3;
//        var zoomIn:CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")
//        zoomIn.fromValue = 1.2;
//        zoomIn.toValue = 1.0;
//        zoomIn.beginTime = animationDuration/4*3;
//        zoomIn.duration = animationDuration/4;
//        group.duration = animationDuration;
//        group.animations = [zoomOut, zoomIn]
//        backgroundLayer.addAnimation(group, forKey: "bounce")
        configureCell()
    }
    
    func hideAnimation() {
//        backgroundLayer.hidden = true
        configureCell()
    }
    
//    func isPlaceHolder() -> Bool {
//        
//        return false
//    }
//    
//    func isToday() -> Bool {
//        return false
//    }
//    
//    func isWeekend() -> Bool {
//        return false
//    }
    
//    func backgroundColourForCurrentState() -> UIColor {
//        if (self.selected) {
//            return BackgroundColours.WJCalendarCellStateSelected
//        }
//        
//        return BackgroundColours.WJCalendarCellStateNormal
//    }
    
    func titleColourForCurrentState() -> UIColor {
        if (self.selected) {
            return TitleColours.WJCalendarCellStateSelected
        }
        
        return TitleColours.WJCalendarCellStateNormal
    }
    
    func subtitleColourForCurrentState() -> UIColor {
        if (self.selected) {
            return SubtitleColours.WJCalendarCellStateSelected
        }
        
        return SubtitleColours.WJCalendarCellStateNormal
    }
}