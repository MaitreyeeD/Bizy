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

  
  @IBOutlet weak var nameData: UILabel!
  @IBOutlet weak var emailData: UILabel!
  @IBOutlet weak var phoneData: UILabel!
  @IBOutlet weak var companyData: UILabel!
  @IBOutlet weak var positionData: UILabel!
  @IBOutlet weak var summaryData: UILabel!
  
  @IBOutlet weak var editButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //self.navigationItem.leftBarButtonItem = self.editButtonItem
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      for data in result as! [NSManagedObject] {
        self.loadUsers(data: data)
        nameData.text = (data.value(forKey: "first_name") as! String)
        emailData.text = (data.value(forKey: "email") as? String ?? "bop@gmil.com")

        
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
//     newUser.qrCode = (data.value(forKey: "qrcode") as! QRCode)
//    users.append(newUser)
    self.thisuser = newUser
    self.loaded = true
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    configureView()
  }
  
  func configureView() {
    
      
      nameData.text = thisuser.firstName + " " + thisuser.lastName
      emailData.text = thisuser.email
      phoneData.text = thisuser.phone ?? "N/A"
      companyData.text = thisuser.company ?? "N/A"
      positionData.text = thisuser.position ?? "N/A"
      summaryData.text = thisuser.summary ?? "N/A"
      
    
    
  }
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // Step 2b: Implementing the protocol; in this case,
  //          simply taking the data and displaying
  //          it in the outlet

  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "addDataVC" {
      
//      let navigationController = segue.destination as! UINavigationController
//      let controller = navigationController.topViewController as! EditProfileController
//      controller.delegate = self
      
      
      let addDataVC: EditProfileController = segue.destination as! EditProfileController

      // Step 4: Tell object A (AddVC) that object B (VC) is now its delegate
      addDataVC.delegate = self as EditProfileControllerDelegate
      // declaring that this VC is acting as the delegate
      print("\n-- I'm \(String(describing: addDataVC))'s delegate: \(String(describing: addDataVC.delegate))\n")
    }
    
    
  }
  
  
  
  func editProfileController(controller: EditProfileController, didFinishAddingProfile user: User) {
    
    thisuser = user
    
    dismiss(animated: true, completion: nil)
  }
  
}
