//
//  UpdateProfileContactIdentifierTests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class UpdateProfileContactIdentifierTests: XCTestCase {

    func test_update_returns_general_error_code() {
        let otherClientsProfileIdentifier = "2"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_update_returns_not_infected_state() {
        let otherClientsProfileIdentifier = "3"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_update_returns_infected_state() {
        let otherClientsProfileIdentifier = "4"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("test_update_returns_general_error_code", test_update_returns_general_error_code),
        ("test_update_returns_not_infected_state", test_update_returns_not_infected_state),
        ("test_update_returns_infected_state", test_update_returns_infected_state),
    ]
}
