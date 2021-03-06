//
//  EventChatViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 16/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventChatViewController: EventViewControllerBase, UITableViewDelegate, UITableViewDataSource, ChatHandlerDelegate
{
	var selectedEvent: Event?
	var keyboardHeight: CGFloat?
	var keyboardDisplayed = false
	
	let networkManager = NetworkManager()
	let chatHandler = ChatHandler()
	
	@IBOutlet weak var chatTableView: UITableView!
	@IBOutlet weak var messageTextField: UITextField!
	@IBOutlet weak var messageViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet weak var messageView: UIView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupBaseEventViewController("Event Chat", backEnabled: true, rightButtonImageString:"")
	
		chatHandler.eventId = (selectedEvent?.id)!
		chatHandler.delegate = self
		chatHandler.getChatMessages()
		
		chatTableView.estimatedRowHeight = 140
		chatTableView.rowHeight = UITableViewAutomaticDimension
		
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillChangeFrameNotification, object: nil)
		
		var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tap)
	}
	
	func DismissKeyboard()
	{
		view.endEditing(true)
	}
	
	func keyboardWillShow(notification: NSNotification)
	{
		keyboardHeight = notification.userInfo![UIKeyboardFrameEndUserInfoKey]!.CGRectValue.size.height
		
		if keyboardDisplayed
		{
			self.animateTextView(false)
		}
		else
		{
			self.animateTextView(true)
		}
		
	}
	
	func chatMessagesReceived()
	{
		chatTableView.reloadData()
		tableViewScrollToBottom(true)
	}

	@IBAction func backButtonPressed(sender: AnyObject)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return chatHandler.chatMessages.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let chatMessage = chatHandler.chatMessages[indexPath.row]
		let cellIdentifier = (chatMessage.isUserMessage()) ? "SentChatCell" : "ReceivedChatCell"
		let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)! as! ChatMessageCell
		
		cell.messageLabel.text  = chatMessage.message
		cell.timeDateLabel.text = chatMessage.postTimeAsString()
		
		if !chatMessage.isUserMessage()
		{
			cell.userLabel.text = chatMessage.userName
		}
		
		return cell
	}
	
	func animateTextView(up: Bool)
	{
		if up
		{
			keyboardDisplayed = true
			messageViewBottomConstraint.constant = keyboardHeight!
		}
		else
		{
			if keyboardDisplayed
			{
				messageViewBottomConstraint.constant -= keyboardHeight!
				keyboardDisplayed = false
			}
		}
		
		tableViewScrollToBottom(true)
	}
	
	func tableViewScrollToBottom(animated: Bool)
	{
		
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
		if messageTextField.text!.characters.count > 0
		{
			chatHandler.postChatMessage(messageTextField.text!)
			messageTextField.text = ""
			messageTextField.resignFirstResponder()
			messageViewBottomConstraint.constant = 0
		}
		
	}
}
