//
//  EventChatViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 16/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
	var selectedEvent: DisplayEvent?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		let networkManager = NetworkManager()
		//networkManager.getEventWithId((selectedEvent?.id)!)
		networkManager.getChatMessages((selectedEvent?.id)!)
	}
	
	@IBAction func backButtonPressed(sender: AnyObject)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 2
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell: UITableViewCell
		if indexPath.row % 2 == 0
		{
			cell  = tableView.dequeueReusableCellWithIdentifier("ReceivedChatCell")!
		}
		else
		{
			cell = tableView.dequeueReusableCellWithIdentifier("SentChatCell")!
		}
		
		return cell
	}
}
