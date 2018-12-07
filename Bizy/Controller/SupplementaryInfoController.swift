//
//  SupplementaryInfoController.swift
//  Bizy
//
//  Created by Wolf on 12/6/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import ChameleonFramework
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialButtons_ButtonThemer
import Photos


class SupplementaryInfoController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  
  
  
  @IBOutlet weak var website:UITextField!
  @IBOutlet weak var linkedIn:UITextField!

  @IBOutlet weak var imgView: UIImageView!
  
  let imagePicker = UIImagePickerController()
  var picture: UIImage?
  
  @IBOutlet var nextButton: MDCButton!
  
  
  var thisuser = User(fname: "", lname: "", email: "")
  @IBOutlet weak var main: UILabel!
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("whooooo!!!")
    print(thisuser.firstName)
    // Do any additional setup after loading the view, typically from a nib.
    self.hideKeyboardWhenTappedAround()
    
    PHPhotoLibrary.requestAuthorization({_ in return})
    imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)

    
    initializeUI()
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  func initializeUI() {
    main.textColor = HexColor("E0C393")
    navigationController?.navigationBar.topItem?.title = "Let's Start With The Essentials!"
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
    
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.primaryColor = HexColor("A6DD69")!
    
    let buttonSchemeScan = MDCButtonScheme()
    MDCContainedButtonThemer.applyScheme(buttonSchemeScan, to: nextButton)
    MDCContainedButtonColorThemer.applySemanticColorScheme(colorScheme, to: nextButton)
    
    
  }
  
  
  
  @IBAction func goBack(sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func loadImageButtonTapped(sender: UIButton) {
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .photoLibrary
    
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      picture = pickedImage
      imgView.image = picture
    }
    
    dismiss(animated: true, completion: nil)
  }
  
  func textField(_ nameField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let oldText: NSString = nameField.text! as NSString
    let newText: NSString = oldText.replacingCharacters(in: range, with: string) as NSString
    

    return true
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Your code here
    if segue.identifier == "toEdit" {
      if let cardView = segue.destination as? EditProfileController {
        self.thisuser.website = website.text!
        self.thisuser.linkedIn = linkedIn.text!
        self.thisuser.image = imgView.image
        cardView.thisuser = self.thisuser
      }
      
    }
    
  }
}
