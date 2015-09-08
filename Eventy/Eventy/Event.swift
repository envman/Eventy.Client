//
//  Event.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation

class Event
{
	var id: String
	var name: String
	var description: String
	var startTime: NSDate
	var endTime: NSDate
	
	init(name: String, description: String, startTime: NSDate, endTime: NSDate)
	{
		id = NSUUID().UUIDString
		self.name = name
		self.description = description
		self.startTime = startTime
		self.endTime = endTime
	}
}
