//
//  SimpleSDKTests.swift
//  SimpleSDKTests
//
//  Created by Nicholas Mata on 3/15/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import XCTest
@testable import SimpleSDK

class SimpleSDKTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        PhilinqSDK.domain = "http://192.168.2.2/"
//        let semaphore = DispatchSemaphore(value: 1)
//        let loginRequest = LoginRequest()
//        loginRequest.username = "testing@testing.com"
//        loginRequest.password = "testing"
//        PhilinqSDK.Auth.login(model: loginRequest).subscribe(onNext: { (model) in
//            semaphore.signal()
//        }) { (error) in
//            semaphore.signal()
//        }
//        semaphore.wait()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogin() {
        let ex = expectation(description: "Login")
        let loginRequest = LoginRequest()
        loginRequest.username = "testing@testing.com"
        loginRequest.password = "password"
        PhilinqSDK.Auth.login(model: loginRequest).subscribe(onNext: { (model) in
            print(model.toJson())
            assert(true)
            ex.fulfill()
        }) { (error) in
            assert(false)
            ex.fulfill()
        }
        waitForExpectations(timeout: 60) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testMillenniumStore() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let ex = expectation(description: "MillenniumStore")
        PhilinqSDK.Millennium.last().subscribe(onNext: { (storeModel) in
            print(storeModel.toJson())
            assert(true)
            ex.fulfill()
        }) { (error) in
            print(error)
            assert(false)
            ex.fulfill()
        }
        waitForExpectations(timeout: 60) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
