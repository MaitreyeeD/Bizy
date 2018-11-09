//
//  ProfileController.swift
//  Bizy
//
//  Created by Maitreyee Deshpande on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController,  DataEnteredDelegate {
  
//   @IBOutlet var edit: UIButton!
//   @IBOutlet var done: UIButton!

  
   @IBOutlet var firstNameLabel: UILabel!
   @IBOutlet var lastNameLabel: UILabel!
   @IBOutlet var companyLabel: UILabel!
   @IBOutlet var positionLabel: UILabel!
   @IBOutlet var workPhoneLabel: UILabel!
   @IBOutlet var pictureLabel: UIImageView!
  
  var detailItem: User? {
    didSet {
      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let detail: User = self.detailItem {
      if let fname = self.firstNameLabel {
        fname.text = detail.firstName
      }
      if let lname = self.lastNameLabel {
        lname.text = detail.lastName
      }
      if let company = self.companyLabel {
        company.text = detail.company
      }
      if let position = self.positionLabel {
        position.text = detail.position
      }
      if let workPhone = self.workPhoneLabel {
        workPhone.text = detail.phone
      }
     if let image = self.pictureLabel {
       image.image = detail.image
     }
 }
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    //self.configureView()
    firstNameLabel.text = "A name"

    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func userDidEnterInformation(info: String) {
    print("true")
    firstNameLabel.text = info
    print("-- Doing my job as a delegate")
    print("-- Sending to outlet: \(info)\n")
    print(info)
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addDataVC" {
      print("segue")
      let addDataVC:EditProfileController = segue.destination as! EditProfileController
      
      // Step 4: Tell object A (AddVC) that object B (VC) is now its delegate
      addDataVC.delegate = self as DataEnteredDelegate
      // declaring that this VC is acting as the delegate
      print("\n-- I'm \(String(describing: addDataVC))'s delegate: \(String(describing: addDataVC.delegate))\n")
    }
  }
  

  
}
