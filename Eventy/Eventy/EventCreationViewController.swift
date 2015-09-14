//
//  EventCreationViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

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
		self.navigationController?.pushViewController(dateSelectViewController, animated: true)
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
	
	@IBAction func DatePickerClicked(sender: UIButton)
	{
		let datePicker = ActionSheetDatePicker(title: "Date:", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: {
			picker, value, index in
			
			print("value = \(value)")
			print("index = \(index)")
			print("picker = \(picker)")
			return
			}, cancelBlock: { ActionStringCancelBlock in return }, origin: sender.superview!.superview)
		let secondsInWeek: NSTimeInterval = 7 * 24 * 60 * 60;
		datePicker.minimumDate = NSDate(timeInterval: -secondsInWeek, sinceDate: NSDate())
		datePicker.maximumDate = NSDate(timeInterval: secondsInWeek, sinceDate: NSDate())
		
		datePicker.showActionSheetPicker()
	}
}
