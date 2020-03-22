//
//  CreateProfileTests.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

@testable import CoronaTracker

final class CreateProfileTests: XCTestCase {

    func test_create_succeeds() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(profileIdentifier: nil)
        tracker.createProfile() { identifier, error in
            XCTAssertEqual(identifier?.value, "12")
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    // TODO: At the moment this test can never succeed, since the `TestClient` can
    // not simulate network errors.
    func test_create_fails_with_client_error() {
        let expectation = self.expectation(description: "\(#function)")
        let tracker = CoronaTracker(profileIdentifier: nil)
        tracker.createProfile() { identifier, error in
            XCTAssertNil(identifier)
            XCTAssertEqual(error as? CoronaTracker.CreateProfileError, .clientError)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}
