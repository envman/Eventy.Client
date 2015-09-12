//
//  SettingsViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 12/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol SettingsDelegate
{
	func userLoggedOut()
}

class SettingsViewController: UIViewController
{
	var delegate: SettingsDelegate?
	
	@IBAction func deleteAccountPressed(sender: AnyObject)
	{
		QuickAlert.showAlert("OH NO!!", message: "Not implmemeted yet")
	}
	
	@IBAction func logOutPressed(sender: AnyObject)
	{
		let networkManager = NetworkManager()
		networkManager.logout()
		AccessToken.deleteToken()
		self.navigationController?.popViewControllerAnimated(true)
		self.delegate?.userLoggedOut()
	}
}
