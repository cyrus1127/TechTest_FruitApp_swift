//
//  TechTest_FruitApp_swiftTests.swift
//  TechTest_FruitApp_swiftTests
//
//  Created by Chun Yip Lam on 14/9/2021.
//

import XCTest
@testable import TechTest_FruitApp_swift

class TechTest_FruitApp_swiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductListDataConnection() throws {
        ConnectionUtility.instance().getProductListData { (isSuccess:Bool) in
            XCTAssertEqual(true , isSuccess)
        }
    }
    
    func testTimeCounting() throws {
        let waitTil = 1.0
        let exp = expectation(description: "Test after \(waitTil) seconds")
        CommonUtility.instance().setTimemark()
        let result = XCTWaiter.wait(for: [exp], timeout: waitTil)
         if result == XCTWaiter.Result.timedOut {
            let diffMS = CommonUtility.instance().getTimediff()
            XCTAssertEqual( Int64((waitTil*1000)) , diffMS)
         } else {
             XCTFail("Delay interrupted")
         }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
