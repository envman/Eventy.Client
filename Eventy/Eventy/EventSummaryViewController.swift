//
//  EventViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 14/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventSummaryViewController: UIViewController
{
	@IBAction func backButtonPressed(sender: AnyObject)
	{
		self.parentViewController?.dismissViewControllerAnimated(true, completion: nil)
	}
}
