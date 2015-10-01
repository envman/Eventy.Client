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

class EventMainViewController: UIViewController, SettingsDelegate, EventDelegate, UITableViewDataSource, UITableViewDelegate, EventCreateDelegate
{
	var delegate: EventMainDelegate?
	var transitionOperator = TransitionOperator()
	var events:Array<DisplayEvent> = []
	var refreshControl:UIRefreshControl!
	var networkManager: NetworkManager!
	var selectedEvent: DisplayEvent?
	let loadingOverlay = LoadingOverlay()
	
	@IBOutlet weak var eventTable: UITableView!
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		initialiseNetworkManager()
		segmentedControl.selectedSegmentIndex = 0
	}
	
	func initialiseNetworkManager()
	{
		networkManager = NetworkManager()
		networkManager.eventDelegate = self
		networkManager.getEvents()
		loadingOverlay.showOverlay(self.eventTable, message: "Updating Events...")
	}
	
	func eventCreated()
	{
		networkManager.getEvents()
		loadingOverlay.showOverlay(self.eventTable, message: "Updating Events...")
	}
	
	func receievedEvents(events: Array<DisplayEvent>)
	{
		self.events = events
		
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
		
		if segue.identifier == "CreateEventSegue"
		{
			let eventCreationViewController = segue.destinationViewController as! EventCreationViewController
			eventCreationViewController.delegate = self
		}
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return events.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell  = tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventCell
		let event = events[indexPath.row]
		
		cell.nameLabel.text = event.name
		cell.descriptionLabel.text = event.description
		
		
		let urlString = "http://joinin.azurewebsites.net/api/Image/" + event.imageId!
		let imageURL: NSURL = NSURL(string: urlString)!
		cell.eventImage.hnk_setImageFromURL(imageURL)
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		selectedEvent = events[indexPath.row]
		networkManager.getEventWithId(selectedEvent!.id!)
		
		let cell  = tableView.cellForRowAtIndexPath(indexPath) as! EventCell
		
		let eventSummaryViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EventSummaryPage") as? EventSummaryViewController
		eventSummaryViewController?.selectedEvent = selectedEvent
		eventSummaryViewController?.selectedEventImage = cell.eventImage.image
		
		presentViewController(eventSummaryViewController!, animated: true, completion: nil)
	}
}
