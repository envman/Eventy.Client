//
//  OpenEventSegue.swift
//  Eventy
//
//  Created by Harry Goodwin on 19/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class OpenEventSegue: UIStoryboardSegue
{
	override func perform()
	{
		
		let sourceViewController: UIViewController = self.sourceViewController as UIViewController
		let destinationViewController: UIViewController = self.destinationViewController as UIViewController
		
		sourceViewController.view.addSubview(destinationViewController.view)
		
		destinationViewController.view.transform = CGAffineTransformMakeScale(0.05, 0.05)
		
		UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
			
			destinationViewController.view.transform = CGAffineTransformMakeScale(1.0, 1.0)
			
			}) { (finished) -> Void in
				
				destinationViewController.view.removeFromSuperview()
				sourceViewController.presentViewController(destinationViewController, animated: false, completion: nil)
				
		}
 }
}
