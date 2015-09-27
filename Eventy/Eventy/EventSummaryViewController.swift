//
//  EventViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 14/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventSummaryViewController: UIViewController
{
	var selectedEvent: DisplayEvent?
	
	@IBOutlet weak var eventImage: UIImageView!
	
	override func viewDidLoad()
	{
		let urlString = "http://joinin.azurewebsites.net/api/Image/" + selectedEvent!.imageId!
		let imageURL: NSURL = NSURL(string: urlString)!
		eventImage.hnk_setImageFromURL(imageURL)
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
}
