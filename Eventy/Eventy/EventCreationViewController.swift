//
//  EventCreationViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventCreationViewController: UIViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		navigationController!.navigationBar.barTintColor = AppColours.mainColour()
		navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
		navigationController?.navigationBar.tintColor = UIColor.whiteColor()
	}
	
	@IBOutlet weak var eventNameTextField: UITextField!
	@IBOutlet weak var eventDescriptionTextField: UITextField!
	
	@IBAction func publishEventButtonPressed(sender: AnyObject)
	{
		let testTimeInterval = NSTimeInterval()
		let testDate = NSDate(timeIntervalSinceNow: testTimeInterval)
		let event = Event(name: eventNameTextField.text!, description: eventDescriptionTextField.text!, startTime: testDate, endTime: testDate)
		
		let networkManager = NetworkManager()
		networkManager.createEvent(event)
	}
}
