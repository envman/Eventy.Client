//
//  DeleteEventTableViewCell.swift
//  Eventy
//
//  Created by Harry Goodwin on 16/10/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol DeleteEventDelegate
{
	func deleteEventPressed()
}

class DeleteEventTableViewCell: UITableViewCell
{
	var delegate: DeleteEventDelegate?
	
	@IBAction func deleteButtonPressed()
	{
		self.delegate!.deleteEventPressed()
	}
}
