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
  

  func test_createUser() {
    let url = "https://api.github.com/search/repositories?q=language:swift&sort=stars&order=desc"
    let parser = UserParser()
    let user =  parser.createUser()
    XCTAssertNotNil(user)
    
  }

  func createUser(fname: String, lname: String, email: String) -> User {
    let user =  User(fname: "Obed", lname: "AA", email: "oo@gmail.com")
    XCTAssertEqual("Obed", user.firstName)
    XCTAssertEqual("AA", user.lastName)
    XCTAssertEqual("oo@gmail.com", user.email)
    return user
  }
  
  func test_editUser(){
    let user = User(fname: "Obed", lname: "AA", email: "oo@gmail.com")
    user.firstName = "maitreyee"
    XCTAssertEqual("maitreyee", user.firstName)
    
  }
  
  
  func test_deleteUser() {
    var user = User(fname: "Obed", lname: "AA", email: "oo@gmail.com")
    user = nil
    XCTAssertNil(user)
    
  }
  
  
  
}
