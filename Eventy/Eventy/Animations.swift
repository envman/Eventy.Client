//
//  Animations.swift
//  Eventy
//
//  Created by Harry Goodwin on 12/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class Animations
{
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
}
