//
//  ImageTableCell.swift
//  Eventy
//
//  Created by Harry Goodwin on 30/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol EventSummaryImageDelegate
{
	func detailEditPressed()
}

class ImageTableCell: EventSummaryBaseTableViewCell
{
	var delegate: EventSummaryImageDelegate?
	
	@IBOutlet weak var eventImage: UIImageView!
	@IBOutlet weak var eventTitleLabel: UILabel!
	@IBOutlet weak var eventDescriptionLabel: UILabel!
	
	@IBAction func editDetailsPressed(sender: AnyObject)
	{
		self.delegate?.detailEditPressed()
	}
}
