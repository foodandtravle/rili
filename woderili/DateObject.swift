//
//  DateObject.swift
//  woderili
//
//  Created by 恒江 on 2016/8/26.
//  Copyright © 2016年 恒江. All rights reserved.
//

import UIKit

class DateObject: NSObject {
    
    func dateForComponent(date : NSDate) -> NSDateComponents {
        
        let calender = NSCalendar.currentCalendar()
        calender.firstWeekday = 1
        let dateComponent = calender.components([.Year,.Month,.Day,.Hour,.Minute,.Second,.WeekdayOrdinal,.WeekOfMonth,.WeekOfYear,.Weekday], fromDate: date)
        dateComponent.timeZone = NSTimeZone.init(abbreviation: "GST")
        
        return dateComponent
    }
}
