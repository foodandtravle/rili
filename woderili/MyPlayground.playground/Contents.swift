//: Playground - noun: a place where people can play

import UIKit

let components = NSDateComponents()

let calendar = NSCalendar.currentCalendar()

var dateAsString = "24-12-2015 23:59"
let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
var newDate = dateFormatter.dateFromString(dateAsString)

newDate = NSDate.init()
components.day = 5
components.month = 01
components.year = 2016
components.hour = 19
components.minute = 30
newDate = calendar.dateFromComponents(components)

newDate = NSDate.init()
components.timeZone = NSTimeZone(abbreviation: "GMT")
newDate = calendar.dateFromComponents(components)
components.timeZone = NSTimeZone(abbreviation: "CST")
newDate = calendar.dateFromComponents(components)
components.timeZone = NSTimeZone(abbreviation: "CET")
newDate = calendar.dateFromComponents(components)



        
