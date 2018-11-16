//
//  EditProfileController.swift
//  Bizy
//
//  Created by Maitreyee Deshpande on 11/11/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit
import Photos
import CoreData

// Step 1: Define a protocol for being a delegate for
//         Object A (AddViewController)
//protocol DataEnteredDelegate {
//  func userDidEnterInformation(fname:String, lname:String, email:String, phone: String, company: String, position: String, summary:String)
//}

protocol EditProfileControllerDelegate: class {
  //func addContactControllerDidCancel(controller: AddContactController)
  
  func editProfileController(controller: EditProfileController, didFinishAddingProfile user: User)
}




class EditProfileController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
 
   @IBOutlet weak var firstName:UITextField!
   @IBOutlet weak var lastName:UITextField!
   @IBOutlet weak var email:UITextField!
   @IBOutlet weak var phone:UITextField!
   @IBOutlet weak var company:UITextField!
   @IBOutlet weak var position:UITextField!
   @IBOutlet weak var summary:UITextField!
   @IBOutlet weak var picPreview: UIImageView!
   @IBOutlet weak var doneBarButton: UIButton!
  
  let imagePicker = UIImagePickerController()
  var picture: UIImage?
  
  // Step 3: Give object A an optional delegate variable
  //var delegate:DataEnteredDelegate?
  
  weak var delegate: EditProfileControllerDelegate?
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    PHPhotoLibrary.requestAuthorization({_ in return})
    imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    firstName.becomeFirstResponder()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func done() {
    let user = User(fname: "", lname: "", email: "")
    user.firstName = firstName.text!
    user.lastName = lastName.text!
    user.email = email.text!
    user.phone = phone.text!
    user.company = company.text!
    user.position = position.text!
    user.summary = summary.text!
   
    
    self.saveUser(user: user)
    delegate?.editProfileController(controller: self, didFinishAddingProfile: user)
  }
  
  func saveUser(user: User){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
    newUser.setValue(user.firstName, forKey: "first_name")
    newUser.setValue(user.lastName, forKey: "last_name")
    newUser.setValue(user.email, forKey: "email")
    newUser.setValue(user.phone, forKey: "phone")
    newUser.setValue(user.company, forKey: "company")
    newUser.setValue(user.position, forKey: "position")
    newUser.setValue(user.summary, forKey: "summary")
    
//    if let pic = contact.picture {
//      newUser.setValue(UIImagePNGRepresentation(pic), forKey: "photo")
//    }
    do {
      try context.save()
    } catch {
      print("Failed saving")
    }
  }
  
  func textField(_ nameField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText: NSString = nameField.text! as NSString
    let newText: NSString = oldText.replacingCharacters(in: range, with: string) as NSString
    
    doneBarButton.isEnabled = (newText.length > 0)
    return true
  }
  
  
  @IBAction func loadImageButtonTapped(sender: UIButton) {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      picture = pickedImage
      picPreview.image = picture
    }
    
    dismiss(animated: true, completion: nil)
  }
  
}
