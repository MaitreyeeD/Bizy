//
//  QRCodeController.swift
//  Bizy
//
//  Created by Wolf on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//
import UIKit
import CoreData

class QRCodeController: UIViewController {

  @IBOutlet weak var qrCodeImage: UIImageView!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var customizeButton: UIButton!
  @IBOutlet weak var back: UIButton!
  
  var thisuser = User(fname: "", lname: "", email: "")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
    request.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(request)
      for data in result as! [NSManagedObject] {
        loadUsers(data: data)
      }
      
    } catch {
      
      print("Failed")
    }
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    loadInfo()
  }
  
  func loadUsers(data: NSManagedObject){
    let newUser = User(fname: "", lname: "", email: "")
    newUser.firstName = (data.value(forKey: "first_name") as! String)
    newUser.qrCode = (data.value(forKey: "qrcode") as! String)
    thisuser = newUser
    
  }
  
  func loadInfo() {
    if (thisuser.firstName.count > 0){
      statusLabel.text = "Your Bizy Code!"
      let qrCode = QRCode(thisuser.qrCode!)
      qrCodeImage.image = qrCode?.image
      return
    }
    
    statusLabel.text = "Create a Profile to Generate Your QRCode!"
    
  }
  
  //Go to Office hours or answer in work session.
  //Managing Core Data to manage:
    //1. The users own profile
    //2. The list of users you can generate
//  func loadContacts(data: NSManagedObject) {
//
//  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func goBack(sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
  }
  
  
}
