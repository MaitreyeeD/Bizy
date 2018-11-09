//
//  UserParserTests.swift
//  BizyTests
//
//  Created by Wolf on 11/8/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import XCTest
@testable import Bizy

class UserParserTests: XCTestCase {
  
  
//  func test_postUser() {
//    let user = createUser()
//    let parser = UserParser()
//    parser.postUser(person: user)
//    XCTAssertEqual(user.id!, "1")
//
//  }
  
  func test_createUser() {
    let url = "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc"
    
//    let user = createUser()
    let parser = UserParser()
   let user =  parser.createUser(url: url)
    XCTAssertNotNil(user)
    
  }

  
  
  func createUser() -> User {
    let user =  User(fname: "Obed", lname: "AA", email: "oo@gmail.com")
    user.password = "nil"
    return user
  }
}
