//
//  EventMainViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol EventMainDelegate
{
	func userLoggedOut()
}

class EventMainViewController: UIViewController, SettingsDelegate, EventDelegate, UITableViewDataSource, UITableViewDelegate, UIPageViewControllerDataSource
{
	var delegate: EventMainDelegate?
	var transitionOperator = TransitionOperator()
	var events:Array<DisplayEvent> = []
	var refreshControl:UIRefreshControl!
	var networkManager: NetworkManager!
	
	@IBOutlet weak var eventTable: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let  eventSummaryViewController = storyboard?.instantiateViewControllerWithIdentifier("EventSummaryPage")
		let eventChatViewController = storyboard?.instantiateViewControllerWithIdentifier("EventChatPage")
		viewControllers = [eventSummaryViewController!, eventChatViewController!]
		
		initialiseNetworkManager()
	}
	
	func initialiseNetworkManager()
	{
		networkManager = NetworkManager()
		networkManager.eventDelegate = self
		networkManager.getEvents()
	}
	
	func receievedEvents(events: Array<DisplayEvent>)
	{
		self.events = events
		self.eventTable.reloadData()
	}
	
	func userLoggedOut()
	{
		dismissViewControllerAnimated(true, completion: nil)
		self.delegate?.userLoggedOut()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		if segue.identifier == "presentSettings"
		{
			let settingsViewController = segue.destinationViewController as! SettingsViewController
			settingsViewController.delegate = self
			self.modalPresentationStyle = UIModalPresentationStyle.Custom
			settingsViewController.transitioningDelegate = self.transitionOperator
		}
		
		if segue.identifier == "OpenEventSegue"
		{
			let pageViewController = segue.destinationViewController as! UIPageViewController
			pageViewController.dataSource = self
			pageViewController.setViewControllers([viewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
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
		
		return cell
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		performSegueWithIdentifier("OpenEventSegue", sender: self)
	}
	
	var viewControllers = Array(count: 2, repeatedValue: UIViewController())
	
	func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
		let currentIndex =  viewControllers.indexOf(viewController)! + 1
		if currentIndex >= viewControllers.count {
			return nil
		}
		return viewControllers[currentIndex]
	}
	
	func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
		let currentIndex =  viewControllers.indexOf(viewController)! - 1
		if currentIndex < 0 {
			return nil
		}
		return viewControllers[currentIndex]
	}
}
