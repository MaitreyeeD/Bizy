//
//  EditProfile2Controller.swift
//  Bizy
//
//  Created by Maitreyee Deshpande on 12/5/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class EditProfile2Controller: UIViewController{
  
  @IBOutlet weak var linked:UITextField!
  @IBOutlet weak var phone:UITextField!
  @IBOutlet weak var company:UITextField!
  @IBOutlet weak var website:UITextField!
  @IBOutlet weak var summary:UITextField!
  @IBOutlet weak var city:UITextField!
  @IBOutlet weak var state:UITextField!
  @IBOutlet weak var position:UITextField!
  
  var modeluser: User? {
    didSet{
      print(modeluser?.linkedIn)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    linked.text = modeluser?.linkedIn
    company.text = modeluser?.company
    phone.text = modeluser?.phone
    position.text = modeluser?.position
    summary.text = modeluser?.summary
    city.text = modeluser?.city
    state.text = modeluser?.state
    website.text = modeluser?.website
  }
  
  @IBAction func save(_ sender: AnyObject) {
    
    modeluser?.linkedIn = linked.text!
    modeluser?.company = company.text!
    modeluser?.phone = phone.text!
    modeluser?.position = position.text!
    modeluser?.website = website.text!
    modeluser?.city = city.text!
    modeluser?.state = state.text!
    modeluser?.summary = summary.text!
    
    //dismiss(animated: true, completion: nil)
  }
}
  

