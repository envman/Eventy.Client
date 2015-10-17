//
//  ChatHandler.swift
//  Eventy
//
//  Created by Harry Goodwin on 17/10/2015.
//  Copyright © 2015 GG. All rights reserved.
//

protocol ChatHandlerDelegate
{
	func chatMessagesReceived()
}

class ChatHandler: NSObject, ChatMessageDelegate
{
	var delegate: ChatHandlerDelegate?
	var eventId: String?
	var userName = ""
	var lastChatMessageId = ""
	var chatMessages = Array<ChatMessage>()
	let networkManager = NetworkManager()
	
	override init()
	{
		super.init()
		
		networkManager.chatMessageDelegate = self
		_ = NSTimer.scheduledTimerWithTimeInterval(7.0, target: self, selector: "update", userInfo: nil, repeats: true)
	}
	
	func getChatMessages()
	{
		if (eventId != nil)
		{
			networkManager.getAllChatMessages(eventId!)
		}
	}
	
	func update()
	{
		networkManager.checkForUpdatedChatMessages((eventId!), lastChatMessageId: lastChatMessageId)
	}
	
	func receivedChatMessages(messages: Array<ChatMessage>)
	{
		chatMessages = messages
		self.delegate?.chatMessagesReceived()
	}
	
	func postChatMessage(message: String)
	{
		networkManager.postChatMessage(eventId!, message: message)
	}
}
