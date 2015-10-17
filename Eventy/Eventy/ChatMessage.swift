//
//  ChatMessage.swift
//  Eventy
//
//  Created by Harry Goodwin on 16/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

class ChatMessage: NSObject
{
	var postTime: NSDate?
	var messageId: String?
	var userName: String?
	var message: String?
	
	func isUserMessage() -> Bool
	{
		return (AccessToken.loadUserName() == userName)
	}
}
