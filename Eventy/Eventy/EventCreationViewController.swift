//
//  EventCreationViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventCreationViewController: UIViewController, DateSelectDelegate, UITextFieldDelegate
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
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	func DismissKeyboard()
	{
		view.endEditing(true)
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool
	{
		if textField != eventDescriptionTextField
		{
			eventDescriptionTextField.becomeFirstResponder()
		}
		else
		{
			textField.resignFirstResponder()
		}
		
		return true
	}
	
	@IBAction func publishEventButtonPressed(sender: AnyObject)
	{
		if ((eventDescriptionTextField.text == "") && (eventDescriptionTextField.text == "") &&
		(startDate == nil) && (endDate == nil))
		{
			QuickAlert.showAlert("Warnimg", message: "Please enter all evet details")
		}
		else
		{
			
			let event = Event(name: eventNameTextField.text!, description: eventDescriptionTextField.text!, startTime: startDate!, endTime: endDate!)
			let networkManager = NetworkManager()
			networkManager.createEvent(event)
		}
		
		dismissViewControllerAnimated(true, completion: nil)
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
		let dateSelectViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DateSelectViewController") as! DateSelectViewController
		dateSelectViewController.delegate = self
		presentViewController(dateSelectViewController, animated: true, completion: nil)
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
	
	@IBAction func backButtonPressed(Sender: UIButton)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
}
