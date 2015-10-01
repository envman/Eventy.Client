//
//  InviteButtonCell.swift
//  Eventy
//
//  Created by Harry Goodwin on 01/10/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol InviteCellDelegate
{
	func inviteButtonPressed()
}

class InviteButtonCell: UITableViewCell
{
	var delegate: InviteCellDelegate?
	
	@IBAction func inviteButtonPressed(sender: AnyObject)
	{
		self.delegate?.inviteButtonPressed()
	}
}
