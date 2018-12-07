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

import ChameleonFramework
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialButtons_ButtonThemer



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
  
 
   @IBOutlet weak var firstNameLabel:UILabel!
   @IBOutlet weak var lastNameLabel:UILabel!
   @IBOutlet weak var emailLabel:UILabel!
   @IBOutlet weak var phoneLabel:UILabel!
   @IBOutlet weak var companyLabel:UILabel!
   @IBOutlet weak var positionLabel:UILabel!
   @IBOutlet weak var summaryLabel:UILabel!

  @IBOutlet weak var linkedinLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var websiteLabel: UILabel!
  
  
  @IBOutlet weak var doneBarButton: MDCButton!
  @IBOutlet weak var picPreview: UIImageView!
  
  let imagePicker = UIImagePickerController()
  var picture: UIImage?
  var me: User? = nil
    var thisuser = User(fname: "", lname: "", email: "")
  
//  var detailItem: User? {
//    didSet{
//      self.configureView()
//    }
//
//  }
  // Step 3: Give object A an optional delegate variable
  //var delegate:DataEnteredDelegate?
  
  weak var delegate: EditProfileControllerDelegate?
  
  func configureView(){
    if let detail: User = self.thisuser{

      firstNameLabel.text = detail.firstName
      
  
      lastNameLabel.text = detail.lastName
      

      emailLabel.text = detail.email
      
      if let phone = detail.phone{
        phoneLabel.text = detail.phone
      }
      if let company = detail.company{
        companyLabel.text = detail.company
      }
      if let position = detail.position{
        positionLabel.text = detail.position
      }

      if let summary = detail.summary{
        summaryLabel.text = detail.summary
      }
      if let linkedin = detail.linkedIn{
        linkedinLabel.text = detail.linkedIn
      }
      if let state = detail.state{
        stateLabel.text = detail.state
      }
      if let city = detail.city{
        cityLabel.text = detail.city
      }
      if let website = detail.website{
        websiteLabel.text = detail.website
      }
      
      if let image = detail.image{
        picPreview.image = detail.image
      }
      
//      if let image = detail.picPreview {
//        image.image = detail.image
//      }
      
      
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
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
  func initializeButtons() {

    let colorSchemeCode = MDCSemanticColorScheme()
    colorSchemeCode.primaryColor = HexColor("E0C393")!
    
    
    let buttonSchemeScan = MDCButtonScheme()
    MDCContainedButtonThemer.applyScheme(buttonSchemeScan, to: doneBarButton)
    MDCContainedButtonColorThemer.applySemanticColorScheme(colorSchemeCode, to: doneBarButton)
  }
  
  
  @IBAction func done() {
    let user = User(fname: "", lname: "", email: "")
    user.firstName = thisuser.firstName
    user.lastName = thisuser.lastName
    user.email = thisuser.email
    user.phone = thisuser.phone
    user.company = thisuser.company
    user.position = thisuser.position
    user.summary = thisuser.summary
    
    //changes
    user.linkedIn = thisuser.linkedIn
    user.state = thisuser.state
    user.city = thisuser.city
    user.website = thisuser.website
    user.photo = "2";
    user.image = thisuser.image
    self.me = user
    
    sendPostRequest()
    
    _ = navigationController?.popToRootViewController(animated: true)
    
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
    newUser.setValue(user.state, forKey: "state")
    newUser.setValue(user.city, forKey: "city")
    newUser.setValue(user.website, forKey: "website")
    newUser.setValue(user.id, forKey: "id")
    
    if let pic = user.image {
      print("images saved")
      newUser.setValue(UIImagePNGRepresentation(pic), forKey: "image")
      if(UIImagePNGRepresentation(pic) != nil){
        print ("image is not nil")
      }
    }
    do {
      try context.save()
    } catch {
      print("Failed saving")
    }
  
  }
  
//  func textField(_ nameField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//    let oldText: NSString = nameField.text! as NSString
//    let newText: NSString = oldText.replacingCharacters(in: range, with: string) as NSString
//
//    doneBarButton.isEnabled = (newText.length > 0)
//    return true
//  }
  
  
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
