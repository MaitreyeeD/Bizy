//
//  QRCodeController.swift
//  Bizy
//
//  Created by Wolf on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//
import UIKit
import CoreData
import ChameleonFramework
import MaterialComponents.MaterialButtons
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialButtons_ButtonThemer



class QRCodeController: UIViewController {

  @IBOutlet weak var qrCodeImage: UIImageView!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var customizeButton: MDCButton!
  @IBOutlet weak var back: UIButton!
  
  @IBOutlet weak var main: UILabel!
  
  var thisuser = User(fname: "", lname: "", email: "")
  var codePlaced = false
  var mainImage : UIImage!
  
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
    main.textColor = HexColor("E0C393")
    initializeUI()
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if (self.codePlaced != true ) {
        loadInfo()
    }
    
  }
  
  func initializeUI() {
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
    
    let colorScheme = MDCSemanticColorScheme()
    colorScheme.primaryColor = HexColor("A6DD69")!
    
    let buttonSchemeScan = MDCButtonScheme()
    MDCContainedButtonThemer.applyScheme(buttonSchemeScan, to: customizeButton)
    MDCContainedButtonColorThemer.applySemanticColorScheme(colorScheme, to: customizeButton)
    
    
  }
  
  func loadUsers(data: NSManagedObject){
    let newUser = User(fname: "", lname: "", email: "")
    newUser.firstName = (data.value(forKey: "first_name") as! String)
    newUser.qrCode = (data.value(forKey: "qrcode") as! String)
    thisuser = newUser
    
  }
  
  func loadInfo() {
    if (thisuser.firstName.count > 0){
      
      print("WHOAAAAAAAAAOAOAOAOOA")
      statusLabel.text = "Go ahead and share!"
      let qrCode = QRCode(thisuser.qrCode!)
//      qrCode!.color = CIColor(rgba: "E0C393")
//      qrCode!.backgroundColor = CIColor(rgba: "000000")
      qrCodeImage.image = qrCode?.image
      codePlaced = true
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
