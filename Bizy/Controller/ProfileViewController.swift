//
//  ProfileViewController.swift
//  Bizy
//
//  Created by Maitreyee Deshpande on 11/11/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation

import UIKit

// Step 2: Make Object B (ViewController) conform to the
//         delegate protocol. First step is to declare
//         that VC will adopt the protocol
class ProfileViewController: UIViewController, DataEnteredDelegate {
  
  
  
  @IBOutlet weak var displayData: UILabel!
  @IBOutlet weak var emailData: UILabel!
  @IBOutlet weak var phoneData: UILabel!
  @IBOutlet weak var companyData: UILabel!
  @IBOutlet weak var positionData: UILabel!
  @IBOutlet weak var summaryData: UILabel!
  
  @IBOutlet weak var editButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    displayData.text = "First Last"
    if(displayData.text == "First Last"){
      editButton.title = "Create"
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // Step 2b: Implementing the protocol; in this case,
  //          simply taking the data and displaying
  //          it in the outlet
 func userDidEnterInformation(fname:String, lname:String, email:String, phone: String, company: String, position: String, summary:String) {
    displayData.text = fname + " " + lname
    emailData.text = email
    phoneData.text = phone
    companyData.text = company
    positionData.text = position
    summaryData.text = summary
    editButton.title = "Edit"
  
    print("-- Doing my job as a delegate")
    print("-- Sending to displayData outlet: \(fname)\n")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addDataVC" {
      let addDataVC: EditProfileController = segue.destination as! EditProfileController
      
      // Step 4: Tell object A (AddVC) that object B (VC) is now its delegate
      addDataVC.delegate = self as DataEnteredDelegate
      // declaring that this VC is acting as the delegate
      print("\n-- I'm \(String(describing: addDataVC))'s delegate: \(String(describing: addDataVC.delegate))\n")
    }
  }
  
}
