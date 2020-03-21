//
//  CreateProfileTests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class CreateProfileTests: XCTestCase {

    func test_create_returns_profile_identifier() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().createProfile() { profileIdentifier in
            XCTAssertEqual(profileIdentifier, "1")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("test_create_returns_profile_identifier", test_create_returns_profile_identifier)
    ]
}
