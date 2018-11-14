//
//  QRCodeController.swift
//  Bizy
//
//  Created by Wolf on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//
import UIKit

class QRCodeController: UIViewController {

  @IBOutlet weak var qrCodeImage: UIImageView!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var customizeButton: UIButton!
  @IBOutlet weak var back: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func goBack(sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
  }
  
  
}
