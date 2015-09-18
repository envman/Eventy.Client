//
//  LoggedOutViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 12/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class LoggedOutViewController: UIViewController, LoginDelegate, NetworkDelegate, EventMainDelegate
{
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var registerButton: UIButton!
	
	var networkManager: NetworkManager?
	
	override func viewDidLoad()
	{
		loginButton.hidden = true
		registerButton.hidden = true
		
		networkManager = NetworkManager()
		networkManager?.delegate = self
		networkManager?.tokenTest()
	}
	
	func userLoggedOut()
	{
		loginButton.hidden = false
		registerButton.hidden = false
	}
	
	func loginDenied()
	{
		loginButton.hidden = false
		registerButton.hidden = false
	}

	func tokenTestSuccessful()
	{
		showEvents()
	}
	
	func loginSuccessful()
	{
		showEvents()
	}
	
	func showEvents()
	{
		loginButton.hidden = true
		registerButton.hidden = true
		
		let eventMainController = self.storyboard?.instantiateViewControllerWithIdentifier("EventMainView") as! EventMainViewController
		eventMainController.delegate = self
		self.presentViewController(eventMainController, animated: true, completion: nil)
	}
	
	@IBAction func showRegisterView(sender: AnyObject)
	{
		let registerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterViewController") as! RegisterViewController
		registerViewController.delegate = self
		self.presentViewController(registerViewController, animated: true, completion: nil)
	}
	
	@IBAction func showLogInView(sender: AnyObject)
	{
		let loginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
		loginViewController.delegate = self
		self.presentViewController(loginViewController, animated: true, completion: nil)
	}
}
