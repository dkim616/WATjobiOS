//
//  Constants.swift
//  WATjob
//
//  Created by Jae Hee Cho on 2015-06-13.
//  Copyright (c) 2015 Strawberry. All rights reserved.
//

import Foundation
import UIKit

let selectedBlue:UIColor = UIColor(red: CGFloat(31/255.0), green: CGFloat(119/255.0), blue: CGFloat(219/255.0), alpha: CGFloat(1.0))
let selectedRed:UIColor = UIColor(red: CGFloat(198/255.0), green: CGFloat(51/255.0), blue: CGFloat(42/255.0), alpha: CGFloat(1.0))
let textBlue:UIColor = UIColor(red: CGFloat(14/255.0), green: CGFloat(69/255.0), blue: CGFloat(221/255.0), alpha: CGFloat(1.0))

let animationDuration = 0.15

enum colouringObject {
    case Background
    case Title
    case Subtitle
}

struct BackgroundColours {
    static let WJCalendarCellStateNormal:UIColor = UIColor.clearColor()
    static let WJCalendarCellStateSelected:UIColor = selectedBlue
    static let WJCalendarCellStateDisabled:UIColor = UIColor.clearColor()
    static let WJCalendarCellStatePlaceholder:UIColor = UIColor.clearColor()
    static let WJCalendarCellStateToday:UIColor = selectedRed
}

struct TitleColours {
    static let WJCalendarCellStateNormal:UIColor = UIColor.darkTextColor()
    static let WJCalendarCellStateSelected:UIColor = UIColor.whiteColor()
    static let WJCalendarCellStateDisabled:UIColor = UIColor.grayColor()
    static let WJCalendarCellStatePlaceholder:UIColor = UIColor.lightGrayColor()
    static let WJCalendarCellStateToday:UIColor = UIColor.whiteColor()
}

struct SubtitleColours {
    static let WJCalendarCellStateNormal:UIColor = UIColor.darkGrayColor()
    static let WJCalendarCellStateSelected:UIColor = UIColor.whiteColor()
    static let WJCalendarCellStateDisabled:UIColor = UIColor.lightGrayColor()
    static let WJCalendarCellStatePlaceholder:UIColor = UIColor.lightGrayColor()
    static let WJCalendarCellStateToday:UIColor = UIColor.whiteColor()
}
