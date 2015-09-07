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
	let registerUrl: String = "http://joinin.azurewebsites.net/Api/Account/Register"
	let loginUrl: String = "http://joinin.azurewebsites.net/Token"
	
	func register(userName: String, email: String, password: String)
	{
		let registerParameters = ["UserName": userName, "Email":email, "Password":password]
		Alamofire.request(.POST, registerUrl, parameters: registerParameters).responseJSON
		{
			_, _, json in
			if (json.value != nil)
			{
				print(json.value)
			}
		}
	}
	
	func login(email: String, password: String)
	{
		let loginParameters = ["grant_type": "password", "UserName": email, "Password":password]
		Alamofire.request(.POST, loginUrl, parameters: loginParameters).responseJSON
			{
				_, _, json in
				if (json.value != nil)
				{
					print(json.value)
				}
		}
	}
}

