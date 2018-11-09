//
//  File.swift
//  Bizy
//
//  Created by Wolf on 11/3/18.
//  Copyright © 2018 Wolf. All rights reserved.
//
typealias JSONDictionary = [String: AnyObject]

import Foundation
import Alamofire
import SwiftyJSON

class UserParser {
//  var urlString: String
////  var call: NSURL
////  var data: NSData
//  init(url: String) {
//    urlString = url
//  }
  
  func parseURL(urlString: String) -> JSON? {
    let call = NSURL(string: urlString)!
    
    let data = NSData(contentsOf: call as URL) as Data?
//    var swiftyjson :JSON
  
    do {
      if let data = data {
        let swiftyjson = try JSON(data: data)
        return swiftyjson
      }
    } catch {
      print("Error parsing this url!!")
    }
    
    return nil
  }
  
  func createUser(url: String) -> User? {
    guard let swiftyjson = parseURL(urlString: url) else {
      print("Error parsing this url!!")
      return nil
    }
    
    guard let fname = swiftyjson["first_name"].string  else {
      return nil
    }
    guard let lname = swiftyjson["last_name"].string  else {
      return nil
    }
    guard let email = swiftyjson["email"].string  else {
      return nil
    }
    
    let user = User(fname: fname, lname: lname, email: email);
    if let password = swiftyjson["password"].string {
      user.password = password
    }
    
    if let phone = swiftyjson["phone"].string {
      user.phone = phone
    }
    if let summary = swiftyjson["summary"].string {
      user.summary = summary
    }
    
    if let position = swiftyjson["positon"].string {
      user.position = position
    }
    if let linkedIn = swiftyjson["linkedIn"].string {
      user.linkedIn = linkedIn
    }
    
    if let company = swiftyjson["company"].string {
      user.company = company
    }
    
    
    if let state = swiftyjson["state"].string {
      user.state = state
    }
    
    if let city = swiftyjson["city"].string {
      user.city = city
    }
    
    if let website = swiftyjson["website"].string {
      user.website = website
    }
    
    if let id = swiftyjson["id"].string {
      user.id = id
    }
    
    //To Be Determined!!!!!!
    //How do we store and access images into our database!!!
    //var image: UIImageView?
    
    return user;
  }
  
  func postUser(person: User) {
    let urlString: String = "https://desolate-springs-29566.herokuapp.com/users/"

    
    let parameters: Parameters = [
      "email": person.email,
      "password": person.password ?? "",
      "first_name": person.firstName,
      "last_name": person.lastName,
      "company": person.company ?? "",
      "position": person.position ?? "",
      "phone": person.phone ?? "",
      "city": person.city ?? "",
      "state": person.state ?? "",
      "linkedin": person.linkedIn ?? "",
      "website": person.website ?? "",
      "summary": person.summary ?? "",
    ]
    
    Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
      response in
      switch response.result {
      case .success:
        do {

          let swiftyjson = try JSON(data: response.data!)
          let userId = swiftyjson["id"].string
          person.id = userId;
          if let bop = userId {
            let qrString = urlString + bop
            person.qrCode = QRCode(qrString)
          }
          
          
        } catch {
          print("Error sending the post request with this information!")
        }
        
        break
      case .failure(let error):

        print(error)
      }
    }
    
  }
  
  
  
}
