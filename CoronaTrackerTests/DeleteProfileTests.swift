//
//  DeleteProfileTests.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
@testable import CoronaTracker

final class DeleteProfileTests: XCTestCase {

    func test_delete_succeeds() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = Tracker(provider: TestProfileIdentifierProvider(profileIdentifier: "10"))
        tracker.deleteProfile() { error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_delete_fails_with_client_error() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = Tracker(provider: TestProfileIdentifierProvider(profileIdentifier: "9"))
        tracker.deleteProfile() { error in
            XCTAssertEqual(error as? Tracker.DeleteProfileError, .clientError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_delete_fails_with_profile_identifier_missing() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = Tracker(provider: TestProfileIdentifierProvider(profileIdentifier: nil))
        tracker.deleteProfile() { error in
            XCTAssertEqual(error as? Tracker.DeleteProfileError, .missingProfileIdentifier)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
