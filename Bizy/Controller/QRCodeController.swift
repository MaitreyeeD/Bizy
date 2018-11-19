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
  
  var me: User? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    loadInfo()
  }
  
  func loadInfo() {
    if let user = me {
      statusLabel.text = "Your Bizy Code!"
      qrCodeImage.image = user.qrCode?.image
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
