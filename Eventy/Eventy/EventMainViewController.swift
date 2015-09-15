//
//  EventMainViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventMainViewController: UIViewController, SettingsDelegate, NetworkDelegate, UITableViewDataSource, UITableViewDelegate
{
	var transitionOperator = TransitionOperator()
	
	@IBOutlet weak var eventTable: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		performTokenTest()
	}
	
	func performTokenTest()
	{
		let networkManager = NetworkManager()
		networkManager.delegate = self
		networkManager.tokenTest()
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
		return 2
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		var cell  = tableView.dequeueReusableCellWithIdentifier("EventCell")
		if !(cell != nil)
		{
			cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "EventCell")
		}
		
		return cell!
	}
}
