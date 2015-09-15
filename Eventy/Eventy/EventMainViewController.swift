//
//  EventMainViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventMainViewController: UIViewController, SettingsDelegate, NetworkDelegate, EventDelegate, UITableViewDataSource, UITableViewDelegate
{
	var transitionOperator = TransitionOperator()
	var events:Array<DisplayEvent> = []
	var refreshControl:UIRefreshControl!
	var networkManager: NetworkManager!
	
	@IBOutlet weak var eventTable: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.refreshControl = UIRefreshControl()
		self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
		self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
		self.eventTable.addSubview(refreshControl)
		
		initialiseNetworkManager()
		networkManager.getEvents()
	}
	
	func refresh(sender:AnyObject)
	{
		networkManager.getEvents()
	}
	
	func initialiseNetworkManager()
	{
		networkManager = NetworkManager()
		networkManager.delegate = self
		networkManager.eventDelegate = self
		networkManager.tokenTest()
	}
	
	func receievedEvents(events: Array<DisplayEvent>)
	{
		self.events = events
		self.eventTable.reloadData()
	}
	
	@IBAction func eventGetTest(sender: AnyObject)
	{
		let networkManager = NetworkManager()
		networkManager.getEvents()
	}
	
	func userLoggedOut()
	{
		presentLoggedOutView()
	}
	
	@IBAction func presentNavigation(sender: AnyObject?)
	{
		performSegueWithIdentifier("presentSettings", sender: self)
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
	}
	
	func loginDenied()
	{
		presentLoggedOutView()
	}
	
	func presentLoggedOutView()
	{
		let loggedOutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoggedOutView")
		self.presentViewController(loggedOutViewController!, animated: true, completion: nil)
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
}
