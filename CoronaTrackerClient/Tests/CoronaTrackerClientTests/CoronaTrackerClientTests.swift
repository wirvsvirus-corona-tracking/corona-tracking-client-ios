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

    func testDeleteProfileReturnsFailureStatusCode() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().deleteProfile(identifier: "9") { statusCode in
            XCTAssertEqual(statusCode, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testDeleteProfileReturnsSuccessStatusCode() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().deleteProfile(identifier: "10") { statusCode in
            XCTAssertEqual(statusCode, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

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
        ("testDeleteProfileReturnsFailureStatusCode", testDeleteProfileReturnsFailureStatusCode),
        ("testDeleteProfileReturnsSuccessStatusCode", testDeleteProfileReturnsSuccessStatusCode),
        ("testGetProfileStateReturnsGeneralErrorCode", testGetProfileStateReturnsGeneralErrorCode),
        ("testGetProfileStateReturnsNotInfectedState", testGetProfileStateReturnsNotInfectedState),
        ("testGetProfileStateReturnsInfectedState", testGetProfileStateReturnsInfectedState)
    ]
}
