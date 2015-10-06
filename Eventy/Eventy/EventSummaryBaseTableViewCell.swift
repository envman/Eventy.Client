//
//  EventSummaryBaseTableViewCell.swift
//  Eventy
//
//  Created by Harry Goodwin on 04/10/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventSummaryBaseTableViewCell: UITableViewCell
{
	var fieldEditable: Bool?
	@IBOutlet var editIcon: UIImageView!
	
	override func layoutSubviews()
	{
		editIcon.hidden = (fieldEditable == true) ? false : true
		self.userInteractionEnabled = (fieldEditable == true) ? true : false
	}
}
