//
//  EventMainViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventMainViewController: UIViewController, SettingsDelegate, NetworkDelegate
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
	
		performTokenTest()
		setupNavBar()
	}
	
	func performTokenTest()
	{
		let networkManager = NetworkManager()
		networkManager.delegate = self
		networkManager.tokenTest()
	}
	
	func setupNavBar()
	{
		navigationController!.navigationBar.barTintColor = AppColours.mainColour()
		navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
		navigationController?.navigationBar.tintColor = UIColor.whiteColor()
	}
	
	@IBAction func eventGetTest(sender: AnyObject)
	{
		let networkManager = NetworkManager()
		networkManager.getEvents()
	}
	
	func userLoggedOut()
	{
		presentLoggedOutView()
	}
	
	@IBAction func settingsPressed(sender: AnyObject)
	{
		let settingsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SettingsView") as! SettingsViewController
		settingsViewController.delegate = self
		self.navigationController?.pushViewController(settingsViewController, animated: true)
	}
	
	func loginDenied()
	{
		presentLoggedOutView()
	}
	
	func presentLoggedOutView()
	{
		let loggedOutViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoggedOutView")
		self.presentViewController(loggedOutViewController!, animated: true, completion: nil)
	}
}
