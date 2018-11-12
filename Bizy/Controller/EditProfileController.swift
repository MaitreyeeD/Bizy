//
//  EditProfileController.swift
//  Bizy
//
//  Created by Maitreyee Deshpande on 11/11/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit

// Step 1: Define a protocol for being a delegate for
//         Object A (AddViewController)
protocol DataEnteredDelegate {
  func userDidEnterInformation(fname:String, lname:String, email:String, phone: String, company: String, position: String, summary:String)
}

class EditProfileController: UIViewController {
  
 
  @IBOutlet weak var firstName:UITextField!
  @IBOutlet weak var lastName:UITextField!
   @IBOutlet weak var email:UITextField!
   @IBOutlet weak var phone:UITextField!
   @IBOutlet weak var company:UITextField!
   @IBOutlet weak var position:UITextField!
   @IBOutlet weak var summary:UITextField!
  
  // Step 3: Give object A an optional delegate variable
  var delegate:DataEnteredDelegate?
  
  
  @IBAction func sendData(_ sender: AnyObject) {
    // identifying my delegate
    print("\n* My delegate is: \(String(describing: delegate))")
    
    if let delegate = delegate {
      let fn:String = firstName.text!
      let ln:String = lastName.text!
      let em:String = email.text!
      let ph:String = phone.text!
      let co:String = company.text!
      let po:String = position.text!
      let su:String = summary.text!
      
      // Step 5: Send info to my delegate so it can handle it appropriately on my behalf
      print("* Telling my delegate what was entered: \(fn)\n")
      delegate.userDidEnterInformation(fname: fn, lname: ln, email: em, phone: ph, company: co, position: po, summary: su)
      
      // even if you comment out the next line, the delegate will do its job (you just won't see it in the app...)
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}