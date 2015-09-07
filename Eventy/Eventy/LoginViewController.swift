//
//  ViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 02/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController
{
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	@IBOutlet weak var registerButton: UIButton!
	@IBOutlet weak var cancelButton: UIButton!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()

		let tapToResignKeyboard: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
		view.addGestureRecognizer(tapToResignKeyboard)
	}
	
	func DismissKeyboard()
	{
		view.endEditing(true)
	}
	
	override func viewDidAppear(animated: Bool)
	{
		setViewForLogin()
	}
	
	func setViewForLogin()
	{
		appearAnimationForView(titleLabel)
		appearAnimationForView(usernameTextField)
		appearAnimationForView(passwordTextField)
		
		appearAnimationForButton(loginButton)
		appearAnimationForButton(registerButton)
		
		emailTextField.hidden = true;
		cancelButton.hidden = true
		registerButton.hidden = false
		
		loginButton.setTitle("Login", forState:UIControlState.Normal)
	}
	
	func appearAnimationForView(view: UIView)
	{
		let originalViewHeight = view.frame.size.height
		view.frame.size.height = 0

		UIView.animateKeyframesWithDuration(0.5, delay: 0.3, options: [], animations: {
			view.frame.size.height = originalViewHeight
			}, completion: nil)
	}
	
	func appearAnimationForButton(view: UIView)
	{
		let originalButtonPosition = view.center
		view.center = CGPointMake(originalButtonPosition.x, 1000)
		
		UIView.animateKeyframesWithDuration(0.5, delay: 0.3, options: [], animations: {
			view.center = originalButtonPosition
		}, completion: nil)
	}
	@IBAction func registerButtonPressed(sender: AnyObject)
	{
		setViewForRegister()
	}
	
	func setViewForRegister()
	{
		loginButton.setTitle("Register", forState:UIControlState.Normal)
		
		cancelButton.hidden = false
		registerButton.hidden = true
		emailTextField.hidden = false
		emailTextField.alpha = 0
		
		let originalButtonPosition = emailTextField.center
		emailTextField.center = usernameTextField.center
		
		UIView.animateWithDuration(0.4, animations: {
			self.emailTextField.center = originalButtonPosition
			self.emailTextField.alpha = 1
		})
	}

	@IBAction func cancelButtonPressed(sender: AnyObject)
	{
		setViewForLogin()
	}
	
	@IBAction func registerDetailsPressed(sender: AnyObject)
	{
		let networkManager: NetworkManager = NetworkManager()
		if emailTextField.hidden == false
		{
			networkManager.register(usernameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!)
		}
		else
		{
			networkManager.login(usernameTextField.text!, password: passwordTextField.text!)
		}
	}
	
	@IBAction func tokenTestPressed(sender: AnyObject)
	{
		let networkManager: NetworkManager = NetworkManager()
		networkManager.tokenTest()
	}
}

