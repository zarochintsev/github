//
//  String+Formatter.swift
//  Tests
//
//  Created by Alex Zarochintsev on 5/20/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import XCTest
@testable import GitHub

class String_Formatter: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testCrop() {
    let cropTo = 2
    let numbers = "1234567890".cropTo(letters: cropTo)
    XCTAssertTrue(cropTo == numbers.count)
  }
  
}
