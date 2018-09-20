//
//  ConcentrationTests.swift
//  ConcentrationTests
//
//  Created by John Lee on 2018/9/20.
//  Copyright © 2018 John. All rights reserved.
//

import XCTest
@testable import Concentration

class ConcentrationTests: XCTestCase {
    let x = 10
    let y = 20
    var z:Int = 0
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        z = x + y
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        assert(z == (x + y))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
