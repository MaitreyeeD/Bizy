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
  var urlString: String!
////  var call: NSURL
  var dataResult: Data!
  var swiftyjson: JSON!
  var proPic = ["man.png", "woman.png", "wom.png"]
//  init(url: String) {
//    urlString = url
//  }
  
  
//  func parseURL(url: String) {
//    urlString = url
    
//    let urls = URL(string: url)
    
//    URLSession.shared.dataTask(with:urls!, completionHandler: {(data, response, error) in
//      guard let data = data, error == nil else { return }
//      do {
//        self.swiftyjson = try JSON(data: data)
////        let json = try JSON(data: data);
//      } catch let error as NSError {
//        print(error)
//      }
//    }).resume()
    
//    let call = NSURL(string: url)!
    
    
//    do {
//      let data = try Data(contentsOf: call as URL)
//        do {
//
//          let swiftyjson = try JSON(data: data)
//          return swiftyjson
//
//        } catch {
//          print("Error parsing this url!!")
//        }
//
//    } catch  {
//      print("Error parsing this url!!")
//    }
//
//    let data = Data(contentsOf: call as URL)
//    var swiftyjson :JSON
  
//    do {
//      if let data = self.dataResult {
//        let swiftyjson = try JSON(data: data)
//        return swiftyjson
//      }
//    } catch {
//      print("Error parsing this url!!")
//    }
//
//    return nil
//  }
  
  func createUser() -> User? {
    
//    parseURL(url: url)
//    guard let swiftyjson = parseURL(url: url) else {
//      print("Error parsing this url!!")
//      return nil
//    }
    print(swiftyjson["first_name"].string!)
//    guard let fname = swiftyjson["first_name"].string  else {
//      return nil
//    }
    let fname = swiftyjson["first_name"].string!
//    guard let lname = swiftyjson["last_name"].string  else {
//      return nil
//    }
    let lname = swiftyjson["last_name"].string!
//    guard let email = swiftyjson["email"].string  else {
//      return nil
//    }
    
    let email = swiftyjson["email"].string!
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
    
    if let id = swiftyjson["id"].int {
      user.id = String(id)
      print(id)
    }
    
    let number = Int.random(in: 0 ... 2)

    user.photo = proPic[number]
    
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
    
    
  }
  
  
  
}
