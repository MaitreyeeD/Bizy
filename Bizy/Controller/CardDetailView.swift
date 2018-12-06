//
//  CardDetailView.swift
//  Bizy
//
//  Created by Wolf on 11/30/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework


class CardDetailView: UIViewController {
  
  
  
  @IBOutlet weak var firstNameLabel: UILabel!
  @IBOutlet weak var lastNameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var companyLabel: UILabel!
  @IBOutlet weak var positionLabel: UILabel!
  @IBOutlet weak var websiteLabel: UILabel!
  @IBOutlet weak var linkedInLabel: UILabel!
  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var summaryLabel: UILabel!
  
  //Waiting for images.
  @IBOutlet weak var resume: UIImageView!
  @IBOutlet weak var picture: UIImageView!
  var thisuser = User(fname: "", lname: "", email: "")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(thisuser.firstName)
    loadInfo()
    
  }
  
  func loadInfo() {
    if (self.thisuser.firstName.count > 0) {
      initializeUI()
      emailLabel.text = thisuser.email
      
      if let company = thisuser.company {
        companyLabel.text = company
      }
      
      if let pos = thisuser.position {
        positionLabel.text = pos
      }
      if let website = thisuser.website {
        websiteLabel.text = website
      }
//      if let link = thisuser.linkedIn {
//        linkedInLabel.text = link
//      }
      if let city = thisuser.city {
        cityLabel.text = city
      }
      if let state = thisuser.state {
        stateLabel.text = state
      }
      if let sum = thisuser.summary {
        summaryLabel.text = sum
      }

      
//      companyLabel.text = thisuser.company ?? "Not Available"
//      positionLabel.text = thisuser.position ?? "Not Available"
//      websiteLabel.text = thisuser.website ?? "Not Available"
//      linkedInLabel.text = thisuser.linkedIn ?? "Not Available"
//      cityLabel.text = thisuser.company ?? "Not Available"
//      stateLabel.text = thisuser.state ?? "Not Available"
//      summaryLabel.text = thisuser.summary ?? "Not Available"
    }
  }
  
  func initializeUI() {
    let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    navigationController?.navigationBar.titleTextAttributes = textAttributes
    
    let name = thisuser.firstName + " " + thisuser.lastName
    self.navigationController?.title = name;
//    main.textColor = HexColor("E0C393")
  }
  

}
