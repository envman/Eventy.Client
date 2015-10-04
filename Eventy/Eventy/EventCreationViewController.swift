//
//  EventCreationViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

protocol EventCreateDelegate
{
	func eventCreated()
}

class EventCreationViewController: EventViewControllerBase, DateSelectDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImageDelegate
{
	var delegate: EventCreateDelegate?
	var startDate: NSDate?
	var endDate: NSDate?
	var currentImage: UIImage?
	var newEvent: Event?
	
	let networkManager =  NetworkManager()
	let imagePicker = UIImagePickerController()
	let loadingOverlay = LoadingOverlay()
	
	@IBOutlet weak var startDateButton: UIButton!
	@IBOutlet weak var eventNameTextField: UITextField!
	@IBOutlet weak var eventDescriptionTextField: UITextField!
	@IBOutlet weak var startDateLabel: UILabel!
	@IBOutlet weak var endDateLabel: UILabel!
	@IBOutlet weak var eventImage: UIImageView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		setupBaseEventViewController("Create Event", backEnabled: true, rightButtonImageString: "")
	}
	
	@IBAction func selectImagePressed(sender: AnyObject)
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
			eventImage.contentMode = .ScaleAspectFit
			eventImage.image = pickedImage
			currentImage = pickedImage
		}
		
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(picker: UIImagePickerController)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	func DismissKeyboard()
	{
		view.endEditing(true)
	}
	
	func textFieldShouldReturn(textField: UITextField) -> Bool
	{
		if textField != eventDescriptionTextField
		{
			eventDescriptionTextField.becomeFirstResponder()
		}
		else
		{
			textField.resignFirstResponder()
		}
		
		return true
	}
	
	@IBAction func publishEventButtonPressed(sender: AnyObject)
	{
		if ((eventDescriptionTextField.text == "") && (eventDescriptionTextField.text == "") &&
		(startDate == nil) && (endDate == nil))
		{
			QuickAlert.showAlert("Warnimg", message: "Please enter all evet details")
		}
		else
		{
			newEvent = Event(name: eventNameTextField.text!, description: eventDescriptionTextField.text!, startTime: startDate!, endTime: endDate!)
			let imageData: NSData = UIImageJPEGRepresentation(currentImage!, 0.7)!
			
			networkManager.imageDelegate = self
			networkManager.uploadImage(imageData, imageId: newEvent!.imageId)
			loadingOverlay.showOverlay(self.view, message: "Creating Event...")
		}
	}
	
	func uploadedImage(uploaded: Bool)
	{
		if uploaded
		{
			networkManager.createEvent(newEvent!)
			loadingOverlay.hideOverlayView()
			
			self.delegate?.eventCreated()
			dismissViewControllerAnimated(true, completion: nil)
		}
	}
	
	@IBAction func startDateSetPressed(sender: AnyObject)
	{
		presentDateSelectView()
	}
	
	func presentDateSelectView()
	{
		let dateSelectViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DateSelectViewController") as! DateSelectViewController
		dateSelectViewController.delegate = self
		presentViewController(dateSelectViewController, animated: true, completion: nil)
	}
	
	func datesSelected(startDate: NSDate, endDate: NSDate)
	{
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = "h:mm a EEE MMM yyyy"
		
		let startDatestring = dateFormatter.stringFromDate(startDate)
		startDateLabel.text = "\(startDatestring)"
		
		let endDateString = dateFormatter.stringFromDate(endDate)
		endDateLabel.text = "\(endDateString)"
		
		self.startDate = startDate
		self.endDate = endDate
	}
	
	@IBAction func backButtonPressed(Sender: UIButton)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
}
