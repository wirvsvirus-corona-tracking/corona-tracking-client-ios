//
//  CoronaTrackerClientTests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class CoronaTrackerClientTests: XCTestCase {

    func testGetProfileStateReturnsGeneralErrorCode() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().getProfile(identifier: "11") { state in
            XCTAssertEqual(state, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testGetProfileStateReturnsNotInfectedState() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().getProfile(identifier: "12") { state in
            XCTAssertEqual(state, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testGetProfileStateReturnsInfectedState() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().getProfile(identifier: "13") { state in
            XCTAssertEqual(state, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("testGetProfileStateReturnsGeneralErrorCode", testGetProfileStateReturnsGeneralErrorCode),
        ("testGetProfileStateReturnsNotInfectedState", testGetProfileStateReturnsNotInfectedState),
        ("testGetProfileStateReturnsInfectedState", testGetProfileStateReturnsInfectedState)
    ]
}
