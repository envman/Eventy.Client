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
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var loginButton: UIButton!
	
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
		animateViews()
	}
	
	func animateViews()
	{
		appearAnimationForView(titleLabel)
		appearAnimationForView(usernameTextField)
		appearAnimationForView(passwordTextField)
		
		appearAnimationForLogin()
	}
	
	func appearAnimationForView(view: UIView)
	{
		let originalViewHeight = view.frame.size.height
		view.frame.size.height = 0
		
		UIView.animateWithDuration(0.5, animations: {
			view.frame.size.height = originalViewHeight
		})
	}
	
	func appearAnimationForLogin()
	{
		let originalButtonPosition = loginButton.center
		loginButton.center = CGPointMake(originalButtonPosition.x, 1000)
		
		UIView.animateWithDuration(0.6, animations: {
			self.loginButton.center = originalButtonPosition
		})
	}
}

