//
//  DateSelectViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 09/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol DateSelectDelegate
{
	func datesSelected(startDate: NSDate, endDate: NSDate)
}

class DateSelectViewController: UIViewController
{
	var delegate:DateSelectDelegate?
	
	
	@IBOutlet weak var startDatePicker: UIDatePicker!
	@IBOutlet weak var endDatePicker: UIDatePicker!
	
	@IBAction func setDateButtonPressed(sender: AnyObject)
	{
		if ((self.delegate) != nil)
		{
			delegate?.datesSelected(startDatePicker.date, endDate: endDatePicker.date)
			self.navigationController?.popViewControllerAnimated(true)
		}
	}
}
