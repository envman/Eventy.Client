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
	var keyboardHeight: CGFloat?
	let networkManager = NetworkManager()
	
	@IBOutlet weak var chatTableView: UITableView!
	@IBOutlet weak var messageTextField: UITextField!
	@IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var messageView: UIView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		networkManager.getAllChatMessages(selectedEvent!.id!)
		
		chatTableView.estimatedRowHeight = 140
		chatTableView.rowHeight = UITableViewAutomaticDimension
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillChangeFrameNotification, object: nil)
	}
	
	func keyboardWillShow(notification: NSNotification)
	{
		keyboardHeight = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size.height
		self.animateTextView(true)
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
		return 10
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell: ChatMessageCell
		if indexPath.row % 2 == 0
		{
			cell = tableView.dequeueReusableCellWithIdentifier("ReceivedChatCell")! as! ChatMessageCell
				cell.messageLabel.text  = "is a mid-1960s British science-fiction television series created by Gerry Anderson (pictured) and "
		}
		else
		{
			cell = tableView.dequeueReusableCellWithIdentifier("SentChatCell")! as! ChatMessageCell
				cell.messageLabel.text = "Really?"
		}
		
		return cell
	}
	
	func animateTextView(up: Bool)
	{
		messageViewBottomConstraint.constant = keyboardHeight!
		tableViewScrollToBottom(true)
	}
	
	func tableViewScrollToBottom(animated: Bool) {
		
		let delay = 0.1 * Double(NSEC_PER_SEC)
		let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
		
		dispatch_after(time, dispatch_get_main_queue(), {
			
			let numberOfSections = self.chatTableView.numberOfSections
			let numberOfRows = self.chatTableView.numberOfRowsInSection(numberOfSections-1)
			
			if numberOfRows > 0 {
				let indexPath = NSIndexPath(forRow: numberOfRows-1, inSection: (numberOfSections-1))
				self.chatTableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: animated)
			}
		})
	}
	
	@IBAction func sendButtonPressed(sender: AnyObject)
	{
		networkManager.postChatMessage((selectedEvent?.id)!, message: messageTextField.text!)
		messageTextField.resignFirstResponder()
		messageViewBottomConstraint.constant = 0
	}
}
