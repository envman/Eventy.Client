//
//  EventViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 14/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventSummaryViewController: EventViewControllerBase, UITextFieldDelegate, UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource, InviteCellDelegate, DateSelectDelegate, ImageDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, EventSummaryImageDelegate
{
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var editDoneButton: UIButton!
	
	var selectedEvent: Event?
	var selectedEventImage: UIImage?
	
	let imagePicker = UIImagePickerController()
	let loadingOverlay = LoadingOverlay()
	let networkManager = NetworkManager()
	
	var newImage: UIImage?
	var newImageId: String?

	let cellHeights: [Int:CGFloat] = [0:200.0, 1:89.0]
	
	let testSchedule: Array = ["CS:GO", "Sonic The Hedgehog", "Splatoon", "THPS5"]
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupBaseEventViewController((selectedEvent?.name)!, backEnabled: true, rightButtonImageString: "Chat")
		
		NSNotificationCenter.defaultCenter().addObserver(
			self,
			selector: "refreshEventTables:",
			name: "refreshEventTable",
			object: nil)
	}
	
@objc	func refreshEventTables(notification: NSNotification)
	{
		tableView.reloadData()
	}
	
	override func viewWillAppear(animated: Bool)
	{
		tableView.reloadData()
	}
	
	override func rightButtonPressed()
	{
		let eventChatViewController = self.storyboard?.instantiateViewControllerWithIdentifier("EventChatPage") as? EventChatViewController
		eventChatViewController?.selectedEvent = selectedEvent
		
		presentViewController(eventChatViewController!, animated: true, completion: nil)
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int
	{
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return 5 + testSchedule.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		switch (indexPath.row)
		{
		case 0:
			let cell  = tableView.dequeueReusableCellWithIdentifier("ImageCell") as! ImageTableCell
			cell.eventImage.image = selectedEventImage
			cell.eventTitleLabel.text = selectedEvent?.name
			cell.eventDescriptionLabel.text = selectedEvent?.description
			cell.fieldEditable = true
			cell.delegate = self
			
			return cell
			
		case 1:
			let cell  = tableView.dequeueReusableCellWithIdentifier("DateCell") as! EventDateCell
			let dayTimePeriodFormatter = NSDateFormatter()
			dayTimePeriodFormatter.dateFormat = "h:mm a EEE MMM yyyy"
			
			cell.startDate.text = dayTimePeriodFormatter.stringFromDate((selectedEvent?.startTime)!)
			cell.endDate.text = dayTimePeriodFormatter.stringFromDate((selectedEvent?.endTime)!)
			cell.fieldEditable = true
			
			return cell
			
		case 2:
			let cell  = tableView.dequeueReusableCellWithIdentifier("JoinInButtonCell")
			return cell!
			
		case 3:
			let cell  = tableView.dequeueReusableCellWithIdentifier("InviteButtonCell") as! InviteButtonCell
			cell.delegate = self
			return cell
			
		case 4:
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleCell") as! EventSummaryBaseTableViewCell
			cell.fieldEditable = true
			return cell

		default:
			let cell  = tableView.dequeueReusableCellWithIdentifier("ScheduleItemCell")
			cell!.textLabel?.textColor = UIColor.whiteColor()
			cell!.textLabel?.text = testSchedule[indexPath.row - 5]
			return cell!
		}
	}
	
	func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
	{
		if let height = cellHeights[indexPath.row]
		{
			return height
		}
		
		return 44
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
	{
		if (indexPath.row == 1)
		{
			presentDateSelectView()
		}
	}
		
	func presentDateSelectView()
	{
		let dateSelectViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DateSelectViewController") as! DateSelectViewController
		dateSelectViewController.delegate = self
		presentViewController(dateSelectViewController, animated: true, completion: nil)
	}
	
	func datesSelected(startDate: NSDate, endDate: NSDate)
	{
		selectedEvent?.startTime = startDate
		selectedEvent?.endTime = endDate
		tableView.reloadData()
		
		saveEditedEvent()
	}
	
	func inviteButtonPressed()
	{
		let alert = UIAlertView()
		alert.title = "Event Invitation"
		alert.message = "Enter the email address of the person you wish to invite"
		alert.addButtonWithTitle("Cancel")
		alert.addButtonWithTitle("Invite")
		alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
		alert.textFieldAtIndex(0)!.delegate = self
		alert.delegate = self
		alert.show()
	}
	
	func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int)
	{
		if(buttonIndex == 1)
		{
			let networkManager = NetworkManager()
			networkManager.inviteUserToEvent(selectedEvent!, userEmail: alertView.textFieldAtIndex(0)!.text!)
		}
	}
	
	func imageEditPressed()
	{
		let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
		let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
			{
				UIAlertAction in
				self.openCamera()
		}
		let gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default)
			{
				UIAlertAction in
				self.openGallary()
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
			{
				UIAlertAction in
		}
		
		imagePicker.delegate = self
		alert.addAction(cameraAction)
		alert.addAction(gallaryAction)
		alert.addAction(cancelAction)
		
		self.presentViewController(alert, animated: true, completion: nil)
	}
	
	func openCamera()
	{
		if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
		{
			imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
			self .presentViewController(imagePicker, animated: true, completion: nil)
		}
		else
		{
			let alertWarning = UIAlertView(title:"Warning", message: "You don't have camera", delegate:nil, cancelButtonTitle:"OK", otherButtonTitles:"")
			alertWarning.show()
		}
	}
	
	func openGallary()
	{
		imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
		self.presentViewController(imagePicker, animated: true, completion: nil)
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
	{
		if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
		{
			newImage = pickedImage
			let imageData: NSData = UIImageJPEGRepresentation(pickedImage, 0.4)!
			
			networkManager.imageDelegate = self
			newImageId = NSUUID().UUIDString
			networkManager.uploadImage(imageData, imageId: newImageId!)
			loadingOverlay.showOverlay(self.view, message: "Updating Event Image")
		}
		
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func uploadedImage(uploaded: Bool)
	{
		loadingOverlay.hideOverlayView()
		
		if (uploaded)
		{
			selectedEvent?.imageId = newImageId!
			saveEditedEvent()
			selectedEventImage = newImage
			tableView.reloadData()
		}
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func detailEditFinished(eventTitle: String, eventDetail: String)
	{
		selectedEvent?.description = eventDetail
		selectedEvent?.name = eventTitle
		
		saveEditedEvent()
	}
	
	func saveEditedEvent()
	{
		networkManager.createEvent(selectedEvent!)
	}
}
