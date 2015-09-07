//
//  NetworkManager.swift
//  Eventy
//
//  Created by Harry Goodwin on 05/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager
{
	let url: String = "http://joinin.azurewebsites.net"
	
	func register(userName: String, email: String, password: String)
	{
		let registerParameters = ["UserName": userName, "Email":email, "Password":password]
		Alamofire.request(.POST, url+"/Api/Account/Register", parameters: registerParameters, encoding: .JSON).responseJSON
		{
			_, _, json in
			if (json.value != nil)
			{
				print(json.value)
			}
		}
	}
	
	func login(username: String, password: String)
	{
		let loginParameters = ["grant_type": "password", "UserName": username, "Password":password]	
		Alamofire.request(.POST, url+"/Token", parameters: loginParameters, encoding: .URL).responseJSON
			{
			_, _, json in
			if (json.value != nil)
			{
				print(json.value)				
				AccessToken.saveTokenData(json.value!)
			}
		}
	}
	
	func tokenTest()
	{
		let headers = [
			"Authorization": "Bearer " + AccessToken.loadTokenData(),
			"Content-Type": "application/x-www-form-urlencoded"
		]
		Alamofire.request(.GET, url+"/api/Values", headers: headers)
			.responseString
			{ _, _, result in
				print("Success: \(result.isSuccess)")
				print("Response String: \(result.value)")
		}
	}
}

