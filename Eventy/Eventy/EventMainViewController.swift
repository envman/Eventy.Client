//
//  EventMainViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit
import Haneke

protocol EventMainDelegate
{
	func userLoggedOut()
}

class EventMainViewController: EventViewControllerBase, SettingsDelegate, EventDelegate, UITableViewDataSource, UITableViewDelegate, EventDetailDelegate
{
	var delegate: EventMainDelegate?
	var transitionOperator = TransitionOperator()
	var events:Array<DisplayEvent> = []
	var networkManager: NetworkManager!
	var selectedEvent: DisplayEvent?
	var noEvents = false
	
	var selectedIndexPath: NSIndexPath?
	let loadingOverlay = LoadingOverlay()
	
	@IBOutlet weak var eventTable: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		initialiseNetworkManager()
		
		NSNotificationCenter.defaultCenter().addObserver(
			self,
			selector: "refreshEventTables:",
			name: "refreshEventTable",
			object: nil)
	}
	
	func initialiseNetworkManager()
	{
		networkManager = NetworkManager()
		networkManager.eventDelegate = self
		networkManager.getEvents()
		loadingOverlay.showOverlay(self.eventTable, message: "Updating Events...")
	}
	
@objc	func refreshEventTables(notification: NSNotification)
	{
		networkManager.getEvents()
		loadingOverlay.showOverlay(self.eventTable, message: "Updating Events...")
	}
	
	func receievedEvents(events: Array<DisplayEvent>)
	{
		self.events = events
		noEvents = (self.events.count > 0) ? false : true
		
		let delay = 0.5 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		dispatch_after(time, dispatch_get_main_queue(), {
			self.loadingOverlay.hideOverlayView()
			self.eventTable.reloadData()
		})
	}
	
	func userLoggedOut()
	{
		dismissViewControllerAnimated(true, completion: nil)
		self.delegate?.userLoggedOut()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		if segue.identifier == "OpenSettingsSegue"
		{
			let settingsViewController = segue.destinationViewController as! SettingsViewController
			settingsViewController.delegate = self
			self.modalPresentationStyle = UIModalPresentationStyle.Custom
			settingsViewController.transitioningDelegate = self.transitionOperator
		}
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return noEvents ? 1 : self.events.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell: EventCell
		
		if (noEvents)
		{
			cell  = tableView.dequeueReusableCellWithIdentifier("NoEventCell") as! EventCell
		}
		else
		{
			cell  = tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventCell
			let event = events[indexPath.row]
			
			cell.nameLabel.text = event.name
			cell.descriptionLabel.text = event.description
			
			
			let urlString = "http://joinin.azurewebsites.net/api/Image/" + event.imageId!
			let imageURL: NSURL = NSURL(string: urlString)!
			cell.eventImage.hnk_setImageFromURL(imageURL)
		}
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		if (!noEvents)
		{
			self.loadingOverlay.showOverlay(self.view, message: "loading Event...")
			selectedIndexPath = indexPath
			selectedEvent = events[indexPath.row]
			networkManager.getEventWithId(selectedEvent!.id!)
			networkManager.eventDetailDelegate = self
		}
		else
		{
			self.performSegueWithIdentifier("CreateEventSegue", sender: self)
		}
	}
	
	func receivedEvent(event: Event)
	{
		self.loadingOverlay.hideOverlayView()
		let cell  = eventTable.cellForRowAtIndexPath(selectedIndexPath!) as! EventCell
		
		let eventSummaryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EventSummaryPage") as? EventSummaryViewController
		eventSummaryViewController?.selectedEvent = event
		eventSummaryViewController?.selectedEventImage = cell.eventImage.image
		
		presentViewController(eventSummaryViewController!, animated: true, completion: nil)
	}
}
