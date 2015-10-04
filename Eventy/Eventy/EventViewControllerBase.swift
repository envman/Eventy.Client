//
//  EventViewControllerBase.swift
//  Eventy
//
//  Created by Harry Goodwin on 03/10/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventViewControllerBase: UIViewController
{
	override func viewDidLoad()
	{
		let statusBarBackgroundView = UIView(frame: CGRectMake(0, 0, self.view.frame.width, 20))
		statusBarBackgroundView.backgroundColor = AppColours.mainColour()
		self.view.addSubview(statusBarBackgroundView)
	}
	
	func setupBaseEventViewController(title: String, backEnabled: Bool, rightButtonImageString: String)
	{
		if (backEnabled)
		{
			let image = UIImage(named: "Back") as UIImage?
			let backButton   = UIButton(frame: CGRectMake(0, 25, 30, 30))
			backButton.setImage(image, forState: .Normal)
			backButton.addTarget(self, action: "backButtonPressed", forControlEvents:.TouchUpInside)
			self.view.addSubview(backButton)
		}
		
		let rightButtonImage = UIImage(named: rightButtonImageString) as UIImage?
		let rightButton   = UIButton(frame: CGRectMake(self.view.frame.width - 35, 25, 30, 30))
		rightButton.setImage(rightButtonImage, forState: .Normal)
		rightButton.addTarget(self, action: "rightButtonPressed", forControlEvents:.TouchUpInside)
		self.view.addSubview(rightButton)
		
		let label = UILabel(frame: CGRectMake(0, 0, 300, 21))
		label.center = CGPointMake(self.view.frame.width/2, 40)
		label.textAlignment = NSTextAlignment.Center
		label.textColor = AppColours.mainColour()
		label.text = title
		label.font = UIFont(name:"HelveticaNeue-Light", size: 25)
		self.view.addSubview(label)
	}
	
	func rightButtonPressed()
	{
		print("OVERRIDE ME!!!")
	}
	
	func backButtonPressed()
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
}
