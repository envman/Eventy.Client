//
//  EventViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 14/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventSummaryViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, InviteCellDelegate
{
	@IBOutlet weak var tableView: UITableView!
	
	var selectedEvent: DisplayEvent?
	var selectedEventImage: UIImage?

	let cellHeights: [Int:CGFloat] = [0:200.0, 1:89.0]
	
	let testSchedule: Array = ["CS:GO", "Sonic The Hedgehog", "Splatoon", "THPS5"]
	
	override func viewWillAppear(animated: Bool)
	{
		tableView.reloadData()
	}
	
	@IBAction func backButtonPressed(sender: AnyObject)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	@IBAction func chatButtonPressed(sender: AnyObject)
	{
		presentChatView()
	}
	
	func presentChatView()
	{
		let eventChatViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EventChatPage") as? EventChatViewController
		eventChatViewController?.selectedEvent = selectedEvent
		
		presentViewController(eventChatViewController!, animated: true, completion: nil)
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 5 + testSchedule.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		switch (indexPath.row)
		{
		case 0:
			let cell  = tableView.dequeueReusableCellWithIdentifier("ImageCell") as! ImageTableCell
			cell.eventImage.image = selectedEventImage
			cell.eventTitleLabel.text = selectedEvent?.name
			cell.eventDescriptionLabel.text = selectedEvent?.description
			
			return cell
			
		case 1:
			let cell  = tableView.dequeueReusableCellWithIdentifier("DateCell") as! EventDateCell
			cell.startDate.text = "08:00 Saturday 3rd August"
			cell.endDate.text = "16:00 Saturday 3rd August"
			
			return cell
			
		case 2:
			let cell  = tableView.dequeueReusableCellWithIdentifier("JoinInButtonCell")
			return cell!
			
		case 3:
			let cell  = tableView.dequeueReusableCellWithIdentifier("InviteButtonCell") as! InviteButtonCell
			cell.delegate = self
			return cell
			
		case 4:
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleCell")
			return cell!

		default:
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleItemCell")
			cell!.textLabel?.textColor = UIColor.whiteColor()
			cell!.textLabel?.text = testSchedule[indexPath.row - 5]
			return cell!
		}
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
	{
		if let height = cellHeights[indexPath.row]
		{
			return height
		}
		
		return 44
	}
	
	func inviteButtonPressed()
	{
		let alert = UIAlertView()
		alert.title = "Event Invitation"
		alert.message = "Enter the email address of the person you wish to invite"
		alert.addButtonWithTitle("Cancel")
		alert.addButtonWithTitle("Invite")
		alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
		alert.textFieldAtIndex(0)!.delegate = self
		alert.show()
	}
	
	func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
	{
		if(buttonIndex == 1)
		{
			//alertView.textFieldAtIndex(0)!.text
		}
	}
}
