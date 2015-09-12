//
//  EventCreationViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventCreationViewController: UIViewController, DateSelectDelegate
{
	var startDate: NSDate?
	var endDate: NSDate?
	
	@IBOutlet weak var startDateButton: UIButton!
	@IBOutlet weak var eventNameTextField: UITextField!
	@IBOutlet weak var eventDescriptionTextField: UITextField!
	@IBOutlet weak var startDateLabel: UILabel!
	@IBOutlet weak var endDateLabel: UILabel!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		navigationController!.navigationBar.barTintColor = AppColours.mainColour()
		navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
		navigationController?.navigationBar.tintColor = UIColor.whiteColor()
		
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	func DismissKeyboard()
	{
		view.endEditing(true)
	}
	
	@IBAction func publishEventButtonPressed(sender: AnyObject)
	{
		let event = Event(name: eventNameTextField.text!, description: eventDescriptionTextField.text!, startTime: startDate!, endTime: endDate!)
		let networkManager = NetworkManager()
		networkManager.createEvent(event)
	}
	
	@IBAction func startDateSetPressed(sender: AnyObject)
	{
		presentDateSelectView()
	}
	
	@IBAction func endDateSetPressed(sender: AnyObject)
	{
		presentDateSelectView()
	}
	
	func presentDateSelectView()
	{
		if ((eventNameTextField.text == "") || (eventDescriptionTextField.text == ""))
		{
			let alert = UIAlertView()
			alert.title = "Warning"
			alert.message = "Please fill out event name and description"
			alert.addButtonWithTitle("OK")
			alert.show()
		}
		else
		{
			let vc = self.storyboard!.instantiateViewControllerWithIdentifier("DateSelectViewController") as! DateSelectViewController
			vc.delegate = self
			self.navigationController?.pushViewController(vc, animated: true)
		}
	}
	
	func datesSelected(startDate: NSDate, endDate: NSDate)
	{
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "dd-MM-yyyy 'at' h:mm a"
		
		let startDatestring = dateFormatter.stringFromDate(startDate)
		startDateLabel.text = "\(startDatestring)"
		
		let endDateString = dateFormatter.stringFromDate(endDate)
		endDateLabel.text = "\(endDateString)"
		
		self.startDate = startDate
		self.endDate = endDate
	}
}
