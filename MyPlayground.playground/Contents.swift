//: Playground - noun: a place where people can play

import UIKit

var dateStr = "2015-10-16T20:34:20"
var newDateStr = "2015-10-16T22:24:20.353"

let dateFormatter = NSDateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
let date = dateFormatter.dateFromString(newDateStr)

var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: "update", userInfo: nil, repeats: true)

