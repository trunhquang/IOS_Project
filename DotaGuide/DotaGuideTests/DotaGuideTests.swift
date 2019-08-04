//
//  DotaGuideTests.swift
//  DotaGuideTests
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import XCTest
@testable import DotaGuide

class DotaGuideTests: XCTestCase {

    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        ThisAPI.search(key: "22") { (hero) in
//            <img src="images/heroes/22.jpg" width="64" height="64">
            XCTAssert(hero?.imageAvatar ?? "" == "images/heroes/22.jpg")
        }
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
