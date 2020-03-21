//
//  UpdateProfileStateTests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class UpdateProfileStateTests: XCTestCase {

    func test_update_not_infected_returns_failure_status_code() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 0, identifier: "5") { statusCode in
            XCTAssertEqual(statusCode, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_update_not_infected_returns_success_status_code() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 0, identifier: "6") { statusCode in
            XCTAssertEqual(statusCode, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_update_infected_returns_failure_status_code() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 1, identifier: "7") { statusCode in
            XCTAssertEqual(statusCode, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_update_infected_returns_success_status_code() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 1, identifier: "8") { statusCode in
            XCTAssertEqual(statusCode, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("test_update_not_infected_returns_failure_status_code", test_update_not_infected_returns_failure_status_code),
        ("test_update_not_infected_returns_success_status_code", test_update_not_infected_returns_success_status_code),
        ("test_update_infected_returns_failure_status_code", test_update_infected_returns_failure_status_code),
        ("test_update_infected_returns_success_status_code", test_update_infected_returns_success_status_code)
    ]
}
