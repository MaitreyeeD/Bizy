//
//  ShowUserController.swift
//  Bizy
//
//  Created by Wolf on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class ShowUserController: UIViewController {
  
  var urlString: String!
  var userData: User!
  let parser = UserParser()
  
  @IBOutlet var addButton: UIButton!
  @IBOutlet var declineButton: UIButton!
  
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
  @IBOutlet weak var picture: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    fetchUserData()
  }
  
  func fetchUserData() {
     DispatchQueue.main.async() {
      Alamofire.request(self.urlString).responseJSON(completionHandler: {(response) in
        switch response.result {
        case.success(let value):
            let json = JSON(value);
            self.parser.swiftyjson = json
            if let user = self.parser.createUser() {
                self.userData = user
            }
          
        case.failure(let error):
          print(error.localizedDescription)
        }
      })
      }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    populateView()
  }
  
  func populateView() {
    
    if let user = self.userData {
      firstNameLabel.text = user.firstName
      lastNameLabel.text = user.lastName
      emailLabel.text = user.email
      
      companyLabel.text = user.company ?? "Not Available"
      positionLabel.text = user.position ?? "Not Available"
      websiteLabel.text = user.website ?? "Not Available"
      linkedInLabel.text = user.linkedIn ?? "Not Available"
      cityLabel.text = user.company ?? "Not Available"
      stateLabel.text = user.state ?? "Not Available"
      summaryLabel.text = user.summary ?? "Not Available"
    }
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
