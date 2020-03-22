//
//  CoronaTrackerTests.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

import CoronaTrackerClient
import CoronaTrackerClientTest
@testable import CoronaTracker

final class CoronaTrackerTests: XCTestCase {

    func test_start_tracker_the_first_time() {
        let expectation = self.expectation(description: "\(#function)")
        Tracker(provider: TestNoProfileIdentifier()).start { profileIdentifier, profileState in
            XCTAssertEqual(profileIdentifier, "12")
            XCTAssertEqual(profileState, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func test_start_tracker() {
        let expectation = self.expectation(description: "\(#function)")
        Tracker(provider: TestProfileIdentifier(profileIdentifier: "12")).start { profileIdentifier, profileState in
            XCTAssertEqual(profileIdentifier, "12")
            XCTAssertEqual(profileState, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}

private extension Tracker {

    convenience init(provider: ProfileIdentifierProvider) {
        self.init(profileIdentifierProvider: provider, client: TestClient(), tokenProvider: TestTokenProvider())
    }
}

private final class TestNoProfileIdentifier: ProfileIdentifierProvider {
    let profileIdentifier: String? = nil
}

private final class TestProfileIdentifier: ProfileIdentifierProvider {
    let profileIdentifier: String?

    init(profileIdentifier: String) {
        self.profileIdentifier = profileIdentifier
    }
}
