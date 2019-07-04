//
//  NSObject+ClassName.swift
//  Tests
//
//  Created by Alex Zarochintsev on 5/21/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import XCTest
@testable import GitHub

class NSObject_ClassName: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testClassName() {
    let className = RepositoryTableViewCell.className
    XCTAssertEqual(className, "RepositoryTableViewCell")
  }
  
}
