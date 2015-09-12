//
//  LoggedOutViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 12/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class LoggedOutViewController: UIViewController, LoginDelegate
{
	@IBOutlet weak var backgroundImage: UIImageView!
	
	override func viewDidAppear(animated: Bool)
	{
		Animations.moveImageAnimation(backgroundImage)
	}
	
	func loginSuccessful()
	{
		self.dismissViewControllerAnimated(true, completion: nil)
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
