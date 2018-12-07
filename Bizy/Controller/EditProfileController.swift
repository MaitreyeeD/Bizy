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
  func editProfileController(controller: EditProfileController, didFinishAddingProfile user: User)
}

class EditProfileController: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate,  UIImagePickerControllerDelegate {
  
   @IBOutlet weak var firstName:UITextField!
   @IBOutlet weak var lastName:UITextField!
   @IBOutlet weak var email:UITextField!
   @IBOutlet weak var phone:UITextField!
   @IBOutlet weak var company:UITextField!
   @IBOutlet weak var position:UITextField!
   @IBOutlet weak var summary:UITextField!
  @IBOutlet weak var linkedin: UITextField!
  @IBOutlet weak var state: UITextField!
  @IBOutlet weak var city: UITextField!
  @IBOutlet weak var website: UITextField!
   @IBOutlet weak var doneBarButton: UIButton!
  
  @IBOutlet weak var imgView: UIImageView!
  
  let imagePicker = UIImagePickerController()
  var picture: UIImage?
  
  var userController: UserController!
  
//  let picker = UIImagePickerController()
//  var pickedImagePath: NSURL?
//  var pickedImageData: NSData?
//  var localPath: String?
  
  
  var user: User? = nil
  
  var detailItem: User? {
    didSet{
      self.configureView()
    }
    
  }
  var modeluser: User? {
    didSet{
      print("set")
      
    }
  }
 
  weak var delegate: EditProfileControllerDelegate?
  
  //METHODS
  
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
      if let image = self.imgView {
        image.image = detail.image
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    PHPhotoLibrary.requestAuthorization({_ in return})
    imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    self.hideKeyboardWhenTappedAround()
    self.configureView()
    
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    firstName.becomeFirstResponder()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func loadImageButtonTapped(sender: UIButton) {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      print("setting image")
      picture = pickedImage
      imgView.image = picture
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  
//  @IBAction func onBtnOpenClicked(sender: UIButton) {
//    //presentViewController(picker, animated: true, completion: nil)
//    present(picker, animated: true, completion: nil)
//    print("image to choose")
//  }
//
//  @IBAction func onBtnSubmitClicked(sender: UIButton) {
//    print("submit clicked")
//    print(localPath)
//    guard let path = localPath else {
//      return
//    }
//
//
//    Alamofire.upload(multipartFormData: { formData in
//      //let filePath = NSURL(fileURLWithPath: path)
//      let filePath = URL(fileURLWithPath: path)
//      //formData.append(filePath, withName: "upload")
//      //formData.append(URL(fileURLWithPath: filePath), withName: "upload")
//      formData.append(filePath, withName: "upload")
//      formData.append("Alamofire".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: "test")
//
//    }, to: "http://128.237.221.220:3000", encodingCompletion: { encodingResult in
//      switch encodingResult{
//      case .success:
//        print("success")
//
//      case .failure(let error):
//        print(error)
//    }
//  })
//  }
  
  
  @IBAction func done() {
    let user = User(fname: "", lname: "", email: "")
    user.firstName = firstName.text!
    user.lastName = lastName.text!
    user.email = email.text!
    user.phone = modeluser?.phone
    user.company = modeluser?.company
    user.position = modeluser?.position
    user.summary = modeluser?.summary
    user.linkedIn = modeluser?.linkedIn
    user.city = modeluser?.city
    user.state = modeluser?.state
    user.website = modeluser?.website
    
    user.image = picture
    
    
    sendPostRequest()
    self.saveUser(user: user)
    
    delegate?.editProfileController(controller: self, didFinishAddingProfile: user)
    
  }
  
  
  
  func sendPostRequest() {
    guard let person = self.user else {
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
        print(response.response)
        print(response.data)
        let swifty = JSON(response.result.value)
        let id = swifty["id"].string
        self.user!.id = id
        var code = urlString + id!
        self.user!.qrCode = QRCode(code)
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
    newUser.setValue(modeluser?.phone, forKey: "phone")
    newUser.setValue(modeluser?.company, forKey: "company")
    newUser.setValue(modeluser?.position, forKey: "position")
    newUser.setValue(modeluser?.summary, forKey: "summary")
    newUser.setValue(user.qrCode, forKey: "qrcode")
    
    newUser.setValue(modeluser?.linkedIn, forKey: "linkedin")
//    newUser.setValue(user.password, forKey: "password")
    newUser.setValue(modeluser?.state, forKey: "state")
    newUser.setValue(modeluser?.city, forKey: "city")
    newUser.setValue(modeluser?.website, forKey: "website")
    
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
  
  func textField(_ nameField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText: NSString = nameField.text! as NSString
    let newText: NSString = oldText.replacingCharacters(in: range, with: string) as NSString
    
    doneBarButton.isEnabled = (newText.length > 0)
    return true
  }
  
  
  
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "profilePartTwo" {
      
      let thisusercontroller = modeluser
      (segue.destination as! EditProfile2Controller).modeluser = thisusercontroller
    }
   
  }
  
//  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//    print("I am being called")
//    guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
//      return
//    }
//
//    imgView.image = image
//
//    let documentDirectory: NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
//
//    let imageName = "temp"
//    let imagePath = documentDirectory.appendingPathComponent(imageName)
//
//    if let data = UIImageJPEGRepresentation(image, 80) {
//      do{
//        try data.write(to: URL(fileURLWithPath: imagePath))
//        print("image uploaded")
//      }
//      catch{
//        print("cannot upload image")
//      }
//
//    }
//
//    localPath = imagePath
//
//    dismiss(animated: true, completion: {
//
//    })
//  }
//
//  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
//    dismiss(animated: true, completion: nil)
//  }
//
  
  
  
 
}


