//
//  EventViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 14/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventSummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	var selectedEvent: DisplayEvent?
	var selectedEventImage: UIImage?
	@IBOutlet weak var tableView: UITableView!
	
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
		return 8
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		if indexPath.row == 0
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("ImageCell") as! ImageTableCell
			cell.eventImage.image = selectedEventImage
			cell.eventTitleLabel.text = selectedEvent?.name
			cell.eventDescriptionLabel.text = selectedEvent?.description
			
			return cell
		}
		else if indexPath.row == 1
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("DateCell") as! EventDateCell
			cell.startDate.text = "08:00 Saturday 3rd August"
			cell.endDate.text = "16:00 Saturday 3rd August"
			
			return cell
		}
		else if indexPath.row == 2
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("JoinInButtonCell")
			return cell!
		}
		else if indexPath.row == 3
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("InviteButtonCell")
			return cell!
		}
		else if indexPath.row == 4
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleCell")
			return cell!
		}
		else if indexPath.row == 5
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleItemCell")
			cell?.textLabel?.textColor = UIColor.whiteColor()
			cell?.textLabel?.text = "08:00  Rocket League"
			cell?.imageView?.image = UIImage(named: "RocketTest")
			return cell!
		}
		else if indexPath.row == 6
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleItemCell")
			cell?.textLabel?.textColor = UIColor.whiteColor()
			cell?.textLabel?.text = "10:00  Metal Gear Solid FTW"
			cell?.imageView?.image = UIImage(named: "MetalGearTest")
			return cell!
		}
		else if indexPath.row == 7
		{
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleItemCell")
			cell?.textLabel?.textColor = UIColor.whiteColor()
			cell?.textLabel?.text = "12:00  CS:GO"
			cell?.imageView?.image = UIImage(named: "CSGOTest")
			return cell!
		}
		
		let cell = UITableViewCell()
		return cell
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
	{
		if indexPath.row == 0
		{
			return 200
		}
		else if indexPath.row == 1
		{
			return 89
		}
		else if indexPath.row == 2
		{
			return 44
		}
		else if indexPath.row == 3
		{
			return 44
		}
		
		return 44
	}
}
