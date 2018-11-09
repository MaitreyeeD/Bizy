//
//  WalletParser.swift
//  Bizy
//
//  Created by Wolf on 11/3/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class WalletParser {
  var userParser = UserParser()
  var usersInWallet = [User]()
  
  
  func postWalletCard(mainId: String, contactId: String, category: String) {
    var one = Int(mainId)
    var two = Int(contactId)
    let parameters: Parameters = [
      "user_id": one,
      "contact_Id": two,
      "category" : category
      ]
    
    //    Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {
    //      response in
    //      switch response.result {
    //      case .success:
    //        do {
    //
    //          let swiftyjson = try JSON(data: response.data!)
    //          let id = swiftyjson["id"].string
    //          person.id = id;
    ////          http://localhost:3000/users/1.json
    ////          person.qrCode =
    //
    //        } catch {
    //          print("Error sending the post request with this information!")
    //        }
    //
    //        break
    //      case .failure(let error):
    //
    //        print(error)
    //      }
    //    }
    
  }
  
//  func refreshWallet(userId: String) {
//    usersInWallet.removeAll()
//    var contactIds = [String]()
//    var allWalletsUrl: String
//    var specificUrl: String
//
//    let call = NSURL(string: allWalletsUrl)!
//
//    let data = NSData(contentsOf: call as URL) as Data?
//    //    var swiftyjson :JSON
//
//    do {
//      if let data = data {
//        let swiftyjson = try JSON(data: data)
//        for swift in swiftyjson {
//          if (swift["user_id"] == userId) {
//
//          }
//        }
//      }
//    } catch {
//      print("Error parsing this url!!")
//    }
//
//  }
  
  
}
