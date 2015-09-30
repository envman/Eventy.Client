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
	
	@IBOutlet weak var chatTableView: UITableView!
	override func viewDidLoad()
	{
		super.viewDidLoad()
		let networkManager = NetworkManager()
		//networkManager.getEventWithId((selectedEvent?.id)!)
		networkManager.getChatMessages((selectedEvent?.id)!)
		
		chatTableView.estimatedRowHeight = 44.0
		chatTableView.rowHeight = UITableViewAutomaticDimension
	}
	
	override func viewWillAppear(animated: Bool)
	{
		chatTableView.reloadData()
	}
	
	@IBAction func backButtonPressed(sender: AnyObject)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 4
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell: ChatMessageCell
		if indexPath.row % 2 == 0
		{
			cell = tableView.dequeueReusableCellWithIdentifier("ReceivedChatCell")! as! ChatMessageCell
			cell.message = "is a mid-1960s British science-fiction television series created by Gerry Anderson (pictured) and "
		}
		else
		{
			cell = tableView.dequeueReusableCellWithIdentifier("SentChatCell")! as! ChatMessageCell
			cell.message = "Really?"
		}
		
		return cell
	}
}
