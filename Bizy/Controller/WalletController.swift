//
//  WalletController.swift
//  Bizy
//
//  Created by Wolf on 11/8/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import UIKit

class WalletController: UIViewController {
  @IBOutlet weak var profile: UIBarButtonItem!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var scanCode: UIButton!
  @IBOutlet var qrCode: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

