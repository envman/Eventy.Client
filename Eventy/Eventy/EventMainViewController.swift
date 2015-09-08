//
//  EventMainViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventMainViewController: UIViewController
{
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		navigationController!.navigationBar.barTintColor = AppColours.mainColour()
		navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
		navigationController?.navigationBar.tintColor = UIColor.whiteColor()
	}
	
	@IBAction func eventGetTest(sender: AnyObject)
	{
		let networkManager = NetworkManager()
		networkManager.getEvents()
	}
}
