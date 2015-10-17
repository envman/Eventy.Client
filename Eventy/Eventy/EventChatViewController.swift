//
//  EventChatViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 16/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventChatViewController: EventViewControllerBase, UITableViewDelegate, UITableViewDataSource, ChatMessageDelegate
{
	var selectedEvent: Event?
	var keyboardHeight: CGFloat?
	let networkManager = NetworkManager()
	var receivedChatMessages = Array<ChatMessage>()
	var userName = ""
	var lastChatMessageId = ""
	
	@IBOutlet weak var chatTableView: UITableView!
	@IBOutlet weak var messageTextField: UITextField!
	@IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var messageView: UIView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupBaseEventViewController("Event Chat", backEnabled: true, rightButtonImageString:"")
		
		userName = AccessToken.loadUserName()
		networkManager.getAllChatMessages(selectedEvent!.id)
		networkManager.chatMessageDelegate = self
		
		chatTableView.estimatedRowHeight = 140
		chatTableView.rowHeight = UITableViewAutomaticDimension
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillChangeFrameNotification, object: nil)
		
		let timer = NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: "update", userInfo: nil, repeats: true)

	}
	
	func update()
	{
		print("Checking chat status")
		networkManager.checkForUpdatedChatMessages((selectedEvent?.id)!, lastChatMessageId: lastChatMessageId)
	}
	
	func keyboardWillShow(notification: NSNotification)
	{
		keyboardHeight = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size.height
		self.animateTextView(true)
	}

	@IBAction func backButtonPressed(sender: AnyObject)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func receivedChatMessages(messages: Array<ChatMessage>)
	{
		receivedChatMessages = messages
		lastChatMessageId = (receivedChatMessages.last?.messageId)!
		chatTableView.reloadData()
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return receivedChatMessages.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let chatMessage = receivedChatMessages[indexPath.row]
		var cell: ChatMessageCell
		
		if chatMessage.userName != userName
		{
			cell = tableView.dequeueReusableCellWithIdentifier("ReceivedChatCell")! as! ChatMessageCell
		}
		else
		{
			cell = tableView.dequeueReusableCellWithIdentifier("SentChatCell")! as! ChatMessageCell
		}
		
		cell.messageLabel.text  = chatMessage.message
		
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
		messageTextField.text = ""
		messageTextField.resignFirstResponder()
		messageViewBottomConstraint.constant = 0
	}
}
