//
//  User.swift
//  Bizy
//
//  Created by Wolf on 10/29/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit

class User  {
//  NSObject, NSCoding
  // MARK: - Properties
  var firstName: String
  var lastName: String
  var email: String
  var password: String?
  
  
  var phone: String?
  var summary: String?
  var position: String?
  var linkedIn: String?
  var company: String?
  var state: String?
  var city: String?
  var website: String?
  var image: UIImage?
  var qrCode: String?
  var id: String?

  
  // MARK: - General
  
//  override init() {
//    super.init()
//  }
  
  init(fname: String, lname: String, email: String) {
    self.firstName = fname
    self.lastName = lname
    self.email = email
  }
  
  
  func equals(first: User, second: User) -> Bool {
    if(first.id! == second.id!) {
      return true
    }
    return false
  }
  
//  For Encoding and Decoding.
//  required init(coder aDecoder: NSCoder) {
//    self.firstName = aDecoder.decodeObject(forKey: "First_Name") as! String
//    self.lastName = aDecoder.decodeObject(forKey: "Last_Name") as! String
//    self.password = aDecoder.decodeObject(forKey: "Password") as? String
//    self.email = aDecoder.decodeObject(forKey: "Email") as! String
//
//    self.phone = aDecoder.decodeObject(forKey: "Phone") as? String
//    self.summary = aDecoder.decodeObject(forKey: "Summary") as? String
//    self.position = aDecoder.decodeObject(forKey: "Position") as? String
//    self.linkedIn = aDecoder.decodeObject(forKey: "LinkedIn") as? String
//    self.company = aDecoder.decodeObject(forKey: "Company") as? String
//    self.state = aDecoder.decodeObject(forKey: "State") as? String
//    self.city = aDecoder.decodeObject(forKey: "City") as? String
//    self.website = aDecoder.decodeObject(forKey: "Website") as? String
//    self.image = aDecoder.decodeObject(forKey: "Image") as? UIImageView
//    self.qrCode = aDecoder.decodeObject(forKey: "QRCode") as? String
//    super.init()
//  }
//
//  func encode(with aCoder: NSCoder) {
//    aCoder.encode(firstName, forKey: "Name")
//    aCoder.encode(lastName, forKey: "Email")
//    aCoder.encode(password, forKey: "Work Phone")
//    aCoder.encode(email, forKey: "Home Phone")
//
//    aCoder.encode(phone, forKey: "Phone")
//    aCoder.encode(summary, forKey: "Summary")
//    aCoder.encode(position, forKey: "Position")
//    aCoder.encode(linkedIn, forKey: "Linkedin")
//    aCoder.encode(company, forKey: "Company")
//    aCoder.encode(state, forKey: "State")
//    aCoder.encode(city, forKey: "City")
//    aCoder.encode(website, forKey: "Website")
//    aCoder.encode(image, forKey: "Image")
//    aCoder.encode(qrCode, forKey: "QRCode")
//  }
  
}
