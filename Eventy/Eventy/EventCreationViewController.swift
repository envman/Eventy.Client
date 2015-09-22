//
//  EventCreationViewController.swift
//  Eventy
//
//  Created by Harry Goodwin on 08/09/2015.
//  Copyright © 2015 GG. All rights reserved.
//

import UIKit

class EventCreationViewController: UIViewController, DateSelectDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
	var startDate: NSDate?
	var endDate: NSDate?
	var currentImageURL: NSURL?
	
	let networkManager =  NetworkManager()
	let imagePicker = UIImagePickerController()
	
	@IBOutlet weak var startDateButton: UIButton!
	@IBOutlet weak var eventNameTextField: UITextField!
	@IBOutlet weak var eventDescriptionTextField: UITextField!
	@IBOutlet weak var startDateLabel: UILabel!
	@IBOutlet weak var endDateLabel: UILabel!
	@IBOutlet weak var eventImage: UIImageView!
	
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
		}
			
		if let imageURL = info[UIImagePickerControllerReferenceURL]
		{
			currentImageURL = imageURL as? NSURL
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
			
			let event = Event(name: eventNameTextField.text!, description: eventDescriptionTextField.text!, startTime: startDate!, endTime: endDate!)
			networkManager.uploadImage(currentImageURL!, imageId: event.imageId)
			networkManager.createEvent(event)
		}
		
		dismissViewControllerAnimated(true, completion: nil)
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
		dateFormatter.dateFormat = "dd-MM-yyyy 'at' h:mm a"
		
		let startDatestring = dateFormatter.stringFromDate(startDate)
		startDateLabel.text = "\(startDatestring)"
		
		let endDateString = dateFormatter.stringFromDate(endDate)
		endDateLabel.text = "\(endDateString)"
		
		self.startDate = startDate
		self.endDate = endDate
	}
	
	@IBAction func downloadTest(sender: AnyObject)
	{
		let testID = "EC72F93F-8B3C-4CF2-A9F1-4ACC15C1D463"
		networkManager.downloadImage(testID)
	}
	
	@IBAction func backButtonPressed(Sender: UIButton)
	{
		dismissViewControllerAnimated(true, completion: nil)
	}
}
