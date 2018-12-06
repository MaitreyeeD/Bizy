//
//  ProfileViewController.swift
//  Bizy
//
//  Created by Maitreyee Deshpande on 11/11/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// Step 2: Make Object B (ViewController) conform to the
//         delegate protocol. First step is to declare
//         that VC will adopt the protocol
class ProfileViewController: UIViewController, EditProfileControllerDelegate {
  
  
  var thisuser = User(fname: "", lname: "", email: "")
  let test = "Test"
  var loaded = false
  
  var userController =  UserController()
  
  
  
  @IBOutlet weak var nameData: UILabel!
  @IBOutlet weak var emailData: UILabel!
  @IBOutlet weak var phoneData: UILabel!
  @IBOutlet weak var companyData: UILabel!
  @IBOutlet weak var positionData: UILabel!
  @IBOutlet weak var summaryData: UILabel!
  
  //changes
//  @IBOutlet weak var passwordData: UILabel!
  @IBOutlet weak var linkedinData: UILabel!
  @IBOutlet weak var websiteData: UILabel!
  @IBOutlet weak var cityData: UILabel!
  @IBOutlet weak var stateData: UILabel!
  @IBOutlet weak var imageData: UIImageView!
  
  
  
  @IBOutlet weak var editButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    userController.user = thisuser
    let modeluser = thisuser
    
    //self.navigationItem.leftBarButtonItem = self.editButtonItem
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      for data in result as! [NSManagedObject] {
        self.loadUsers(data: data)
//        nameData.text = thisuser.firstName
//        emailData.text = thisuser.email
        self.configureView()
        
//        print(data.value(forKey: "first_name") as! String)
//        print(data.value(forKey: "email") as! String)
      }
      
    } catch {
      
      print("Failed")
    }
   
    
    
  }
  
  
  
  func loadUsers(data: NSManagedObject){
    let newUser = User(fname: "", lname: "", email: "")
    newUser.firstName = (data.value(forKey: "first_name") as! String)
    newUser.lastName = (data.value(forKey: "last_name") as! String)
    newUser.email = (data.value(forKey: "email") as? String ?? "bop@gmil.com")
     newUser.phone = (data.value(forKey: "phone") as? String ?? "4083070736" )
     newUser.company = (data.value(forKey: "company") as? String ?? "Microsoft")
     newUser.position = (data.value(forKey: "position") as? String ?? "Intern")
     newUser.summary = (data.value(forKey: "summary") as? String ?? "I'm a developer")
    //changes
    
    newUser.city = (data.value(forKey: "city") as? String ?? "")
    newUser.state = (data.value(forKey: "state") as? String ?? "")
    newUser.website = (data.value(forKey: "website") as? String ?? "")
    newUser.linkedIn = (data.value(forKey: "linkedin") as? String ?? "")
   // newUser.password = (data.value(forKey: "password") as? String ?? "")
//    newUser.image = UIImage(data:(data.value(forKey: "image") as! NSData) as! Data)
//
    
//     newUser.qrCode = (data.value(forKey: "QRcode") as! QRCode)
//    users.append(newUser)
    thisuser = newUser
    userController.user = thisuser
    //self.loaded = true
  }
  
//  override func viewDidAppear(_ animated: Bool) {
//    super.viewDidAppear(animated)
//    configureView()
//  }
  
 
  
  func configureView() {
    
      
      nameData.text = thisuser.firstName + " " + thisuser.lastName
      emailData.text = thisuser.email
      phoneData.text = thisuser.phone ?? "N/A"
      companyData.text = thisuser.company ?? "N/A"
      positionData.text = thisuser.position ?? "N/A"
      summaryData.text = thisuser.summary ?? "N/A"
      linkedinData.text = thisuser.linkedIn ?? "N/A"
      websiteData.text = thisuser.website ?? "N/A"
      cityData.text = thisuser.city ?? "N/A"
      stateData.text = thisuser.state ?? "N/A"
//    imageData.image = thisuser.image ?? nil
    
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // Step 2b: Implementing the protocol; in this case,
  //          simply taking the data and displaying
  //          it in the outlet

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addDataVC" {
      
      
      let addDataVC: EditProfileController = segue.destination as! EditProfileController
      

      // Step 4: Tell object A (AddVC) that object B (VC) is now its delegate
      addDataVC.delegate = self as EditProfileControllerDelegate
      let us = thisuser
      (segue.destination as! EditProfileController).detailItem = us
      let thiscontroller = userController
      (segue.destination as! EditProfileController).modeluser = thiscontroller.user
      
      
    }
    else if segue.identifier == "backToHome" {
      let backToHome: WalletController = segue.destination as! WalletController
    }
    
    
  }
  
  
  
  func editProfileController(controller: EditProfileController, didFinishAddingProfile user: User) {
    
    thisuser = user
    
    dismiss(animated: true, completion: nil)
  }
  

  
}
