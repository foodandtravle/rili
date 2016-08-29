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

private extension NSDate {
    
    //另外一个时间的类型,分为上一个、下一个
    enum anotherType {
        case next   //下一个
        case last   //上一个
    }
    
    //时间类型
    enum timeType {
        case minute //分钟
        case hour   //小时
        case day    //天
        case week   //周
        case month  //月
        case year   //年
    }
    
    /**
     *  Description :
     *  计算下一个时间，或者说日期,date
     *  @param type1 : 另外一个时间的类型,分为上一个、下一个
     *  @param type2 : 时间类型
     *  @param date : 当前日期 date
     *  @param num : 数量
     */
     func anotherDateWithParameters(type1 : anotherType , type2 : timeType , date : NSDate) -> NSDate {
        
        var interval = 1.00 //Second 秒  一个月按30天计算
        
        switch type2 {
        case .minute:
                interval = interval * 60
            break
        case .hour:
                interval = interval * 60 * 60
            break
        case .day:
            interval = interval * 60 * 60 * 24
            break
        case .week:
             interval = interval * 60 * 60 * 24 * 7
            break
        case .month:
            interval = interval * 60 * 60 * 24 * 30
            break
        default:
            interval = interval * 60 * 60 * 24 * 365
            break
        }
        
        //next 为正    last 上一个  为负
        interval = type1 == .next ? interval : 0 - interval
        
        return date.dateByAddingTimeInterval(interval)
    }
}


extension NSDate{
    
    func nextMinute() -> NSDate {
        
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = NSTimeZone.init(abbreviation: "CST")!
        
        return calendar.dateByAddingUnit(.Minute, value: 1, toDate: self, options: .MatchFirst)!
//        return self.anotherDateWithParameters(.next, type2: .minute, date: self)
    }
    func lastMinute() -> NSDate {
        return self.anotherDateWithParameters(.last, type2: .minute, date: self)
    }
    func nextHour() -> NSDate {
        return self.anotherDateWithParameters(.next, type2: .hour, date: self)
    }
    func lastHour() -> NSDate {
        return self.anotherDateWithParameters(.last, type2: .hour, date: self)
    }
    func nextDay() -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        return calendar.dateByAddingUnit(.Day, value: 1, toDate: self, options: .MatchFirst)!
    }
    func lastDay() -> NSDate {
        return self.anotherDateWithParameters(.last, type2: .day, date: self)
    }
    func nextWeek() -> NSDate {
        return self.anotherDateWithParameters(.next, type2: .week, date: self)
    }
    func lastWeek() -> NSDate {
        return self.anotherDateWithParameters(.last, type2: .week, date: self)
    }
    func nextMonth() -> NSDate {
        return self.anotherDateWithParameters(.next, type2: .month, date: self)
    }
    func lastMonth() -> NSDate {
        return self.anotherDateWithParameters(.last, type2: .month, date: self)
    }
    func nextYear() -> NSDate {
        return self.anotherDateWithParameters(.next, type2: .year, date: self)
    }
    func lastYear() -> NSDate {
        return self.anotherDateWithParameters(.last, type2: .year, date: self)
    }
}




