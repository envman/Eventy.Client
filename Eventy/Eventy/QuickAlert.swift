//
//  QuickWarningAlert.swift
//  Eventy
//
//  Created by Harry Goodwin on 12/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class QuickAlert
{
	class func showAlert(title: String, message: String)
	{
		let alert = UIAlertView()
		alert.title = title
		alert.message = message
		alert.addButtonWithTitle("OK")
		alert.show()
	}
}
