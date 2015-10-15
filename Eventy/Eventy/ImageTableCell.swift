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
	func detailEditFinished(eventTitle: String, eventDetail: String)
	func imageEditPressed()
}

class ImageTableCell: EventSummaryBaseTableViewCell
{
	var delegate: EventSummaryImageDelegate?
	
	@IBOutlet weak var eventImage: UIImageView!
	@IBOutlet weak var eventTitleLabel: UITextField!
	@IBOutlet weak var eventDescriptionLabel: UITextField!
	
	@IBOutlet weak var editDetailsButton: UIButton!
	@IBOutlet weak var cancelEditButton: UIButton!
	@IBOutlet weak var saveDetailsButton: UIButton!
	
	var originalEventName = ""
	var originalEventDescription = ""
	
	override func layoutSubviews()
	{
		eventTitleLabel.userInteractionEnabled = false
		eventDescriptionLabel.userInteractionEnabled = false
	}
	
	@IBAction func editDetailsPressed(sender: AnyObject)
	{
		originalEventName = eventTitleLabel.text!
		originalEventDescription = eventDescriptionLabel.text!
		
		editDetailsButton.hidden = true
		cancelEditButton.hidden = false
		saveDetailsButton.hidden = false
		
		eventTitleLabel.userInteractionEnabled = true
		eventDescriptionLabel.userInteractionEnabled = true
		
		eventTitleLabel.becomeFirstResponder()
	}
	
	@IBAction func editImagePressed(sender: AnyObject)
	{
		self.delegate?.imageEditPressed()
	}
	
	@IBAction func cancelDetailEditPressed(sender: AnyObject)
	{
		cancelEditButton.hidden = true
		saveDetailsButton.hidden = true
		editDetailsButton.hidden = false
		
		eventDescriptionLabel.text = originalEventDescription
		eventTitleLabel.text = originalEventName
		
		eventTitleLabel.userInteractionEnabled = false
		eventDescriptionLabel.userInteractionEnabled = false
		
		eventTitleLabel.resignFirstResponder()
		eventDescriptionLabel.resignFirstResponder()
	}
	
	@IBAction func saveDetailsPressed(sender: AnyObject)
	{
		cancelEditButton.hidden = true
		saveDetailsButton.hidden = true
		editDetailsButton.hidden = false
		
		eventTitleLabel.userInteractionEnabled = false
		eventDescriptionLabel.userInteractionEnabled = false
		
		eventTitleLabel.resignFirstResponder()
		eventDescriptionLabel.resignFirstResponder()
		
		self.delegate?.detailEditFinished(eventTitleLabel.text!, eventDetail: eventDescriptionLabel.text!)
	}

}
