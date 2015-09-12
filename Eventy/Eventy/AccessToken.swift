//
//  AccessToken.swift
//  Eventy
//
//  Created by Harry Goodwin on 07/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import Foundation
import SwiftyJSON
import Locksmith

class AccessToken
{
	static var userName: String = ""
	static var token: String = ""
	static var issued: String = ""
	static var expires: String = ""
	static var type: String = ""
	static var expiresIn: Int = 0
	
	class func saveTokenData(json: AnyObject)
	{
		let responseJson = JSON(json)
		
		token = responseJson["access_token"].stringValue
		userName = responseJson["userName"].stringValue
		type = responseJson["token_type"].stringValue
		expires = responseJson[".expires"].stringValue
		issued = responseJson[".issued"].stringValue
		expiresIn = responseJson["expires_in"].int!
		
		do
		{
			try Locksmith.updateData(["userName": userName, "token": token], forUserAccount: "JoinInUserAccount")
		}
		catch
		{
			print("Saving item to keychain failed")
		}
	}
	
	class func loadTokenData() ->String
	{
		if let tokenDictionary = Locksmith.loadDataForUserAccount("JoinInUserAccount")
		{
			let responseJson = JSON(tokenDictionary)
			return responseJson["token"].stringValue
		}
		
		return ""
	}
	
	class func deleteToken()
	{
		do
		{
			try Locksmith.deleteDataForUserAccount("JoinInUserAccount")
		}
		catch
		{
			print("Deleting keychain item failed")
		}
	}
}