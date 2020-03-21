//
//  DeleteProfileTests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class DeleteProfileTests: XCTestCase {

    func test_delete_returns_failure_status_code() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().deleteProfile(identifier: "9") { statusCode in
            XCTAssertEqual(statusCode, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_delete_returns_success_status_code() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().deleteProfile(identifier: "10") { statusCode in
            XCTAssertEqual(statusCode, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("test_delete_returns_failure_status_code", test_delete_returns_failure_status_code),
        ("test_delete_returns_success_status_code", test_delete_returns_success_status_code)
    ]
}
