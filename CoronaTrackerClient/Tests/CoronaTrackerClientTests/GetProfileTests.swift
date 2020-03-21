//
//  GetProfileTests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class GetProfileTests: XCTestCase {

    func test_get_returns_general_error_code() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().getProfile(identifier: "11") { state in
            XCTAssertEqual(state, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_get_returns_not_infected_state() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().getProfile(identifier: "12") { state in
            XCTAssertEqual(state, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_get_returns_infected_state() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().getProfile(identifier: "13") { state in
            XCTAssertEqual(state, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("test_get_returns_general_error_code", test_get_returns_general_error_code),
        ("test_get_profile_state_returns_not_infected_state", test_get_returns_not_infected_state),
        ("test_get_returns_infected_state", test_get_returns_infected_state)
    ]
}
