//
//  ChatMessageCell.swift
//  Eventy
//
//  Created by Harry Goodwin on 30/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell
{
	var message = ""
	
	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var timeDateLabel: UILabel!
	@IBOutlet weak var userLabel: UILabel!
}
