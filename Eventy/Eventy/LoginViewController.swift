//
//  ViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 02/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol LoginDelegate
{
	func loginSuccessful()
}

class LoginViewController : UIViewController, NetworkDelegate
{
	var delegate: LoginDelegate?
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
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
	
	@IBAction func cancelPressed(sender: AnyObject)
	{
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	@IBAction func loginPressed(sender: AnyObject)
	{
		let networkManager: NetworkManager = NetworkManager()
		networkManager.delegate = self

		networkManager.login(usernameTextField.text!, password: passwordTextField.text!)
	}

	func loginSuccessful()
	{
		dismissViewControllerAnimated(true, completion: nil)
		self.delegate?.loginSuccessful()
	}
}

