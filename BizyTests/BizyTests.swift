//
//  BizyTests.swift
//  BizyTests
//
//  Created by Wolf on 10/29/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import XCTest
@testable import Bizy

class BizyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
      let q = QRCodeController()
      XCTAssertNotNil(q)
      
      
      
      
      
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
