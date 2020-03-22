//
//  RegisterContactIdentifierTests.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

@testable import CoronaTracker

final class RegisterContactIdentifierTests: XCTestCase {

    func test_register_succeeds_returning_infected_state() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(profileIdentifier: "4")
        tracker.registerContactIdentifier(.init(value: "100")) { newProfileState, error in
            XCTAssertEqual(newProfileState, .infected)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_register_succeeds_returning_not_infected_state() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(profileIdentifier: "3")
        tracker.registerContactIdentifier(.init(value: "100")) { newProfileState, error in
            XCTAssertEqual(newProfileState, .notInfected)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_register_fails_with_client_error() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(profileIdentifier: "2")
        tracker.registerContactIdentifier(.init(value: "100")) { newProfileState, error in
            XCTAssertNil(newProfileState)
            XCTAssertEqual(error as? CoronaTracker.RegisterContactIdentifierError, .clientError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_register_fails_with_missing_profile_identifier() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(profileIdentifier: nil)
        tracker.registerContactIdentifier(.init(value: "100")) { newProfileState, error in
            XCTAssertNil(newProfileState)
            XCTAssertEqual(error as? CoronaTracker.RegisterContactIdentifierError, .missingProfileIdentifier)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
