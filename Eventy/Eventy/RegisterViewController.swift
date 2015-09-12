//
//  RegisterViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 12/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class RegisterViewController: LoginViewController
{
	@IBOutlet weak var emailTextField: UITextField!
	
	@IBAction func registerPressed(sender: AnyObject)
	{
		let networkManager: NetworkManager = NetworkManager()
		networkManager.delegate = self
		
		networkManager.register(self.usernameTextField.text!, email: self.emailTextField.text!, password: self.passwordTextField.text!)
	}
	
	override func textFieldShouldReturn(textField: UITextField) -> Bool
	{
		if textField == passwordTextField
		{
			resignFirstResponder()
			loginPressed(textField)
		}
			
		else if textField == emailTextField
		{
			usernameTextField.becomeFirstResponder()
		}
		else
		{
			passwordTextField.becomeFirstResponder()
		}
		
		return true
	}
}
