//
//  NetworkManager.swift
//  Eventy
//
//  Created by Harry Goodwin on 05/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol NetworkDelegate
{
	optional func loginSuccessful()
	optional func loginDenied()
	optional func tokenTestSuccessful()
}

protocol EventDelegate
{
	func receievedEvents(events: Array<DisplayEvent>)
}

class NetworkManager
{
	var delegate: NetworkDelegate?
	var eventDelegate: EventDelegate?
	let url: String = "http://joinin.azurewebsites.net"
	
	let authenticationHeaders = [
		"Authorization": "Bearer " + AccessToken.loadTokenData(),
		"Content-Type": "application/x-www-form-urlencoded"]
	
	func register(userName: String, email: String, password: String)
	{
		let registerParameters = ["UserName": userName, "Email":email, "Password":password]
		Alamofire.request(.POST, url+"/Api/Account/Register", parameters: registerParameters, encoding: .JSON).responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				let responseJson = JSON(json.value!)
				let responseMessage = responseJson["Message"].stringValue
				QuickAlert.showAlert("Error", message:responseMessage)
			}
			else
			{
				self.login(userName, password: password)
			}
		}
	}
	
	func login(username: String, password: String)
	{
		let loginParameters = ["grant_type": "password", "UserName": username, "Password":password]	
		Alamofire.request(.POST, url+"/Token", parameters: loginParameters, encoding: .URL).responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				let responseJson = JSON(json.value!)
				let errorMessage = responseJson["error_description"].stringValue
				
				if (errorMessage == "")
				{
					AccessToken.saveTokenData(json.value!)
					self.delegate?.loginSuccessful!()
				}
				else
				{
					QuickAlert.showAlert("Failure", message: "Response: \(errorMessage)")
				}
			}
		}
	}
	
	func logout()
	{
		Alamofire.request(.POST, url+"/api/Account/Logout", headers: authenticationHeaders).responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				let responseJson = JSON(json.value!)
				let responseMessage = responseJson["Message"].stringValue
					
				if (responseMessage != "")
				{
					QuickAlert.showAlert("Failure", message: "Response: \(responseMessage)")
				}
			}
		}
	}
	
	func tokenTest()
	{
		Alamofire.request(.GET, url+"/api/Values", headers: authenticationHeaders)
		.responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				let responseJson = JSON(json.value!)
				let responseMessage = responseJson["Message"].stringValue
				print(responseMessage)
					
				if (responseMessage.containsString("denied"))
				{
					self.delegate?.loginDenied!()
				}
				else
				{
					self.delegate?.tokenTestSuccessful!()
				}
			}
		}
	}
	
	func createEvent(event: Event)
	{
		let eventParameters = ["Id": event.id, "Name": event.name, "Description": event.description,
								"StartDateTime":event.startTime, "EndDateTime":event.endTime]

		Alamofire.request(.PUT, url+"/api/Event/"+event.id, parameters: eventParameters, headers: authenticationHeaders)
			.responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				
				let responseJson = JSON(json.value!)
				let responseMessage = responseJson["Message"].stringValue
					
				if (responseMessage.containsString("denied"))
				{
					QuickAlert.showAlert("Fail to create event:", message: "Respons: \(responseMessage)")
				}
			}
		}
	}
	
	func getEvents()
	{
		var events: Array<DisplayEvent> = []
		
		Alamofire.request(.GET, url+"/api/Event", headers: authenticationHeaders)
			.responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				let responseJson = JSON(json.value!)
				let responseMessage = responseJson["Message"].stringValue
				
				
				for (_, subJson) in responseJson
				{
					
					let event: DisplayEvent = DisplayEvent()
					event.description = subJson["Description"].string
					event.name = subJson["Name"].string
					event.imageId = subJson["ImageId"].string
					event.id = subJson["Id"].string
					
					events.append(event)
				}
				
				self.eventDelegate?.receievedEvents(events)				
				if (responseMessage != "")
				{
					QuickAlert.showAlert("Failure", message: "Response: \(responseMessage)")
				}
			}
		}
	}
	
	func getChatMessages(eventId: String)
	{
		Alamofire.request(.GET, url+"/api/Chat?eventId=\(eventId)", headers: authenticationHeaders).responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				let responseJson = JSON(json.value!)
				let responseMessage = responseJson["Message"].stringValue
				print(responseMessage)
				
				if (responseMessage.containsString("denied"))
				{
					self.delegate?.loginDenied!()
				}
			}
		}
	}
	
	func postChatMessage(eventId: String, message: String)
	{
		let chatParameters = ["EventId": eventId, "Message": message]
		Alamofire.request(.POST, url+"/api/Chat", parameters: chatParameters, headers: authenticationHeaders).responseJSON{
			_, _, json in
			if (json.value != nil)
			{
				let responseJson = JSON(json.value!)
				let responseMessage = responseJson["Message"].stringValue
				
				if (responseMessage != "")
				{
					QuickAlert.showAlert("Failure", message: "Response: \(responseMessage)")
				}
			}
		}

	}

	func uploadImage(imageURL: NSURL)
	{
		let imageId = NSUUID().UUIDString
		Alamofire.upload(.PUT, url + "/api/Image/" + imageId, file: imageURL).responseString {
			_, _, result in
			print("Success: \(result.isSuccess)")
			print("Response String: \(result.value)")
			
			self.downloadImage(imageId)
		}
	}
	
	func downloadImage(imageId: String)
	{
		Alamofire.request(.GET, url + "/api/Image/" + imageId).response() {
			(_, _, data, _) in
			let image = UIImage(data: data! )
		}
	}
}
