//
//  WalletController.swift
//  Bizy
//
//  Created by Wolf on 11/8/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import UIKit
import CoreData
import UIKit

class WalletController: UIViewController {
  @IBOutlet var profile: UIButton!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var scanCode: UIButton!
  @IBOutlet var qrCode: UIButton!
  @IBOutlet weak var nameData: UILabel!
  
  var thisuser = User(fname: "", lname: "", email: "")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    //Possibly Move to View Did Appear
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
        
        
        //        print(data.value(forKey: "first_name") as! String)
        //        print(data.value(forKey: "email") as! String)
      }
      
    } catch {
      
      print("Failed")
    }
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated);
    configureView()
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
    newUser.password = (data.value(forKey: "password") as? String ?? "")
    //    newUser.image = UIImage(data:(data.value(forKey: "image") as! NSData) as! Data)
    //
    
    //     newUser.qrCode = (data.value(forKey: "QRcode") as! QRCode)
    //    users.append(newUser)
    thisuser = newUser
    //self.loaded = true
  }
  
  func configureView() {
    if (thisuser.firstName.count > 0) {
      nameData.text = thisuser.firstName + "'s Wallet"
      return
    } else {
      nameData.text = "Wallet"
    }
    
  }
  
 
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

