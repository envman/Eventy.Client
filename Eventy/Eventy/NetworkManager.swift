//
//  NetworkManager.swift
//  Eventy
//
//  Created by Harry Goodwin on 05/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation

class NetworkManager
{
	func login(userName: String, email: String, password: String)
	{
		let parameters = ["UserName": userName, "Email":email, "Password":password] as Dictionary<String, String>

		let url = NSURL(string: "http://joinin.azurewebsites.net/Api/Account/Register")
		let session = NSURLSession.sharedSession()
		let request = NSMutableURLRequest(URL: url!)
		
		request.HTTPMethod = "POST"

		do
		{
			request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
		} catch let parseError {
			print(parseError)
		}
		
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.addValue("application/json", forHTTPHeaderField: "Accept")
		

		let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
			print("Response: \(response)")
			let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
			print("Body: \(strData)")
			
			var json: NSDictionary
			
			do
			{
				json =  try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as! NSDictionary
			}catch let parseError {
				print(parseError)
			}
		})
		task.resume()
	}
}

