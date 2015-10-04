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

class DateSelectViewController: EventViewControllerBase
{
	var delegate:DateSelectDelegate?
	
	@IBOutlet weak var startDatePicker: UIDatePicker!
	@IBOutlet weak var endDatePicker: UIDatePicker!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupBaseEventViewController("Event Date", backEnabled: true, rightButtonImageString: "")
	}
	
	@IBAction func setDateButtonPressed(sender: AnyObject)
	{
		self.delegate?.datesSelected(startDatePicker.date, endDate: endDatePicker.date)
		self.dismissViewControllerAnimated(true, completion: nil)
	}
}
