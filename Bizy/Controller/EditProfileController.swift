//
//  EditProfileController.swift
//  Bizy
//
//  Created by Maitreyee Deshpande on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import UIKit
import Photos
import CoreData

protocol DataEnteredDelegate {
  func userDidEnterInformation(info:String)
}


class EditProfileController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
  
  
  @IBOutlet var firstNameField: UITextField!
  @IBOutlet var lastNameField: UITextField!
  @IBOutlet var companyField: UITextField!
  @IBOutlet var positionField: UITextField!
  @IBOutlet var workPhoneField: UITextField!
  @IBOutlet weak var picturePreview: UIImageView!
  
  let imagePicker = UIImagePickerController()
  var pic: UIImage?
  
  var delegate:DataEnteredDelegate?
  
  
  @IBAction func sendData(_ sender: AnyObject) {
    // identifying my delegate
    print("\n* My delegate is: \(String(describing: delegate))")
    
    if let delegate = delegate {
      let information:String = firstNameField.text!
      
      // Step 5: Send info to my delegate so it can handle it appropriately on my behalf
      print("* Telling my delegate what was entered: \(information)\n")
      delegate.userDidEnterInformation(info: information)
      
      // even if you comment out the next line, the delegate will do its job (you just won't see it in the app...)
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    PHPhotoLibrary.requestAuthorization({_ in return})
    imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  @IBAction func loadImageButtonTapped(sender: UIButton) {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      pic = pickedImage
      picturePreview.image = pic
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  
  @IBAction func save() {
    let user = User(fname: "", lname: "", email: "")
    user.firstName = firstNameField.text!
    user.lastName = lastNameField.text!
    user.phone = workPhoneField.text
    user.company = companyField.text
    user.position = positionField.text
    user.image = pic
    self.saveProfile(profile: user)
    
  }
  
  
  func saveProfile(profile: User){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Person", in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
    newUser.setValue(profile.firstName, forKey: "fname")
    newUser.setValue(profile.lastName, forKey: "lname")
    newUser.setValue(profile.company, forKey: "company")
    newUser.setValue(profile.position, forKey: "position")
    newUser.setValue(profile.phone, forKey: "phone")
    if let p = profile.image {
      newUser.setValue(UIImagePNGRepresentation(p), forKey: "photo")
    }
    do {
      try context.save()
    } catch {
      print("Failed saving")
    }
    
    
    
    
  }
  
  

}
