//
//  Date.swift
//  woderili
//
//  Created by 恒江 on 2016/8/24.
//  Copyright © 2016年 恒江. All rights reserved.
//

import Foundation


extension NSDate{
    
    /**
     *  Description :
     *  中国时区与系统时区相差八小时
     *  默认时区为 shanghai , 需要转化为格林尼治时间进行统一
     *  格林尼治时间要比本地时间晚上八个小时。。。
     */
    func dateForCHina() -> NSDate {
        let tempDate = self
        let zone = NSTimeZone.systemTimeZone()
        let interval = zone.secondsFromGMTForDate(tempDate)
        return tempDate.dateByAddingTimeInterval(Double(interval))
    }

    
    /**
     *  Description:
     *  获取当前月数的天数
     */
    func numberOfDaysInCurrentMonth() -> NSInteger {
        
        return NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length
    }
    
    /**
     *  Description:
     *  判断这个日期  是否可以计算出开始日期 返回第一天
     */
    func firstDayOfCurrentMonth() -> NSDate {
        
        var startDate : NSDate?
        startDate = nil
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone.init(abbreviation: "GMT")!
        
        let isOk = calendar.rangeOfUnit(NSCalendarUnit.Month, startDate: &startDate, interval: nil, forDate: self)
        assert(isOk, "Failed to calculate the first day of the month based on \(self)")
        
        return startDate!
    }
    
    /**
     *  Description:
     *  判断这个日期  是否可以计算出开始日期 返回最后一天
     */
    func lastDayOfCurrentMonth() -> NSDate {
        
        var startDate : NSDate?
        startDate = nil
        
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone.init(abbreviation: "GMT")!
        let isOk = calendar.rangeOfUnit(NSCalendarUnit.Month, startDate: &startDate, interval: nil, forDate: self)
        assert(isOk, "Failed to calculate the first day of the month based on \(self)")
        
        startDate = calendar.dateByAddingUnit(.Month, value: 1, toDate: startDate!, options: NSCalendarOptions.MatchFirst)
        startDate = calendar.dateByAddingUnit(.Day, value: -1, toDate: startDate!, options: NSCalendarOptions.MatchFirst)
        
        return startDate!
    }
    
    /**
     *  Description :
     *  计算 特定时间(date)其对应的小的时间单元(smaller)在大的时间单元(larger)中的顺序
     *  @param  注意 : 格林尼治时间从下午16:00开始算作  次日   所以需要修改其时区,CST即为中国时区
     */
    func weeklyOrdinality() -> NSInteger {
        let calendar = NSCalendar.currentCalendar()
        calendar.firstWeekday = 2//每周从周一开始
        calendar.timeZone = NSTimeZone.init(abbreviation: "GMT")!//中国时区
        let num = calendar.ordinalityOfUnit(.Day, inUnit: .WeekOfMonth, forDate: self)
        
        return num
    }
    
    /**
     *  Description:
     *  获取当前月总共有多少个周
     */
    func numberOfWeeksInCurrentMonth() -> NSInteger {
       
        let weekDay = firstDayOfCurrentMonth().weeklyOrdinality()
        var days = numberOfDaysInCurrentMonth()
        var weeks = 01
        
        if weekDay > 1 {
            weeks += 1
            days -= (7 - weekDay + 1)
        }
        
        weeks += days / 7
        weeks += (days % 7 > 0 ) ? 1: 0
        return weeks
    }
}

extension NSDate{
    
    func nextMinute() -> NSDate {
        
        return NSCalendar.currentCalendar().dateByAddingUnit(.Minute, value: 1, toDate: self, options: .MatchFirst)!
    }
    func lastMinute() -> NSDate {
       return NSCalendar.currentCalendar().dateByAddingUnit(.Minute, value: -1, toDate: self, options: .MatchFirst)!
    }
    func nextHour() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Hour, value: 1, toDate: self, options: .MatchFirst)!
    }
    func lastHour() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Hour, value: -1, toDate: self, options: .MatchFirst)!
    }
    func nextDay() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: 1, toDate: self, options: .MatchFirst)!
    }
    func lastDay() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: -1, toDate: self, options: .MatchFirst)!
    }
    func nextWeek() -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Weekday, value: 1, toDate: self, options: .MatchFirst)!
    }
    func lastWeek() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Weekday, value: -1, toDate: self, options: .MatchFirst)!
    }
    func nextMonth() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: 1, toDate: self, options: .MatchFirst)!
    }
    func lastMonth() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: -1, toDate: self, options: .MatchFirst)!
    }
    func nextYear() -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Year, value: 1, toDate: self, options: .MatchFirst)!
    }
    func lastYear() -> NSDate {
         return NSCalendar.currentCalendar().dateByAddingUnit(.Year, value: -1, toDate: self, options: .MatchFirst)!
    }
}




