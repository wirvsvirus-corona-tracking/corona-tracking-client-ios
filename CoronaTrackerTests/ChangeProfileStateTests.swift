//
//  ChangeProfileStateTests.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

@testable import CoronaTracker

final class ChangeProfileStateTests: XCTestCase {
    
    func test_change_to_infected() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(provider: TestProfileIdentifierProvider(profileIdentifier: "6"))
        tracker.changeProfileState(to: .infected) { newProfileState, error in
            XCTAssertEqual(newProfileState, .infected)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_change_to_not_infected() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(provider: TestProfileIdentifierProvider(profileIdentifier: "6"))
        tracker.changeProfileState(to: .notInfected) { newProfileState, error in
            XCTAssertEqual(newProfileState, .notInfected)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_change_fails_with_client_error() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(provider: TestProfileIdentifierProvider(profileIdentifier: "5"))
        tracker.changeProfileState(to: .any) { newProfileState, error in
            XCTAssertNil(newProfileState)
            XCTAssertEqual(error as? CoronaTracker.ChangeProfileStateError, .clientError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_change_fails_with_missing_profile_identifier() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(provider: TestProfileIdentifierProvider(profileIdentifier: nil))
        tracker.changeProfileState(to: .any) { newProfileState, error in
            XCTAssertNil(newProfileState)
            XCTAssertEqual(error as? CoronaTracker.ChangeProfileStateError, .missingProfileIdentifier)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}

private extension CoronaTracker.ProfileState {
    static var any: CoronaTracker.ProfileState { .notInfected }
}
