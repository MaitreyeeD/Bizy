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
import Alamofire
import SwiftyJSON
import RealmSwift

// Step 1: Define a protocol for being a delegate for
//         Object A (AddViewController)
//protocol DataEnteredDelegate {
//  func userDidEnterInformation(fname:String, lname:String, email:String, phone: String, company: String, position: String, summary:String)
//}

extension UIViewController {
  func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

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
  //must remove
   @IBOutlet weak var password: UITextField!

  @IBOutlet weak var linkedin: UITextField!
  @IBOutlet weak var state: UITextField!
  @IBOutlet weak var city: UITextField!
  @IBOutlet weak var website: UITextField!
  
  
   @IBOutlet weak var doneBarButton: UIButton!
  @IBOutlet weak var picPreview: UIImageView!
  
  let imagePicker = UIImagePickerController()
  var picture: UIImage?
  var me: User? = nil
  
  var detailItem: User? {
    didSet{
      self.configureView()
    }
    
  }
  // Step 3: Give object A an optional delegate variable
  //var delegate:DataEnteredDelegate?
  
  weak var delegate: EditProfileControllerDelegate?
  
  func configureView(){
    if let detail: User = self.detailItem{
      if let fname = self.firstName{
        fname.text = detail.firstName
      }
      if let lname = self.lastName{
        lname.text = detail.lastName
      }
      if let email = self.email {
        email.text = detail.email
      }
      if let phone = self.phone{
        phone.text = detail.phone
      }
      if let company = self.company{
        company.text = detail.company
      }
      if let position = self.position{
        position.text = detail.position
      }
      //changes
      if let password = self.password{
        password.text = detail.password
      }
      if let summary = self.summary{
        summary.text = detail.summary
      }
      if let linkedin = self.linkedin{
        linkedin.text = detail.linkedIn
      }
      if let state = self.state{
        state.text = detail.state
      }
      if let city = self.city{
        city.text = detail.city
      }
      if let website = self.website{
        website.text = detail.website
      }
      if let image = self.picPreview {
        image.image = detail.image
      }
      
      
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.hideKeyboardWhenTappedAround() 
    
    PHPhotoLibrary.requestAuthorization({_ in return})
    imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    self.configureView()
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
    
    //changes
    //must remove password
    user.password = password.text!
    user.linkedIn = linkedin.text!
    user.state = state.text!
    user.city = city.text!
    user.website = website.text!
    user.image = picture
    self.me = user
    
    sendPostRequest()
    
    
    
    delegate?.editProfileController(controller: self, didFinishAddingProfile: me!)
    
  }
  
  //Finish With Core Data OR Realm
  // Change informaiton bs
  func sendPostRequest() {
    guard let person = self.me else {
      print("There is no user to be saved!")
      return
    }
    let parameters: Parameters = [
      "email": person.email,
      "password": person.password ?? "",
      "first_name": person.firstName,
      "last_name": person.lastName,
      "company": person.company ?? "",
      "position": person.position ?? "",
      "phone": person.phone ?? "",
      "city": person.city ?? "",
      "state": person.state ?? "",
      "linkedin": person.linkedIn ?? "",
      "website": person.website ?? "",
      "summary": person.summary ?? "",
      ]
    let urlString: String = "https://desolate-springs-29566.herokuapp.com/users/"
    DispatchQueue.main.async() {
      Alamofire.request(urlString, method: .post, parameters: parameters).responseJSON(completionHandler: {(response) in
        
        print("YELLOOOOOOO")
        print(response.result)
        guard let rep = response.result.value else {
          print("Could Not Convert")
          return
        }
        
        let json = rep as! [String: AnyObject]
        print(json)
//        if let jsonId = json["id"] {
//          let bop = jsonId as! Int
//          print(jsonId)
//          print(bop)
//        }
//
//        guard let jsonId = json["id"] else {
//          print("No Can Do")
//          return
//        }
        
        let userId = json["id"] as! Int
        self.me!.id = String(userId)
        
        let code = urlString + String(userId)
        print(code)
        self.me!.qrCode = code
        print("SAVED IN DATABASE- WHOOO HOOO")
        self.saveUser(user: self.me!)
      })
      
      
    }
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
    newUser.setValue(user.qrCode, forKey: "qrcode")
    newUser.setValue(user.linkedIn, forKey: "linkedin")
    newUser.setValue(user.password, forKey: "password")
    newUser.setValue(user.state, forKey: "state")
    newUser.setValue(user.city, forKey: "city")
    newUser.setValue(user.website, forKey: "website")
    
    if let pic = user.image {
      newUser.setValue(UIImagePNGRepresentation(pic), forKey: "image")
    }
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
