//
//  LoadingOverlay.swift
//  Eventy
//
//  Created by Harry Goodwin on 27/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

public class LoadingOverlay{
	
	var overlayView = UIView()
	var activityIndicator = UIActivityIndicatorView()
	
	class var shared: LoadingOverlay {
		struct Static {
			static let instance: LoadingOverlay = LoadingOverlay()
		}
		return Static.instance
	}
	
	public func showOverlay(view: UIView!, message: String)
	{
		overlayView = UIView(frame: UIScreen.mainScreen().bounds)
		overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
		activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
		activityIndicator.center = overlayView.center
		activityIndicator.color = AppColours.mainColour()
		overlayView.addSubview(activityIndicator)
		
		let label = UILabel(frame: CGRectMake(0, 0, 200, 21))
		var center = overlayView.center
		center.y += 60
		label.center = center
		label.textAlignment = NSTextAlignment.Center
		label.text = message
		label.textColor = AppColours.mainColour()
		overlayView.addSubview(label)
		
		
		activityIndicator.startAnimating()
		view.addSubview(overlayView)
	}
	
	public func hideOverlayView() {
		activityIndicator.stopAnimating()
		overlayView.removeFromSuperview()
	}
}
