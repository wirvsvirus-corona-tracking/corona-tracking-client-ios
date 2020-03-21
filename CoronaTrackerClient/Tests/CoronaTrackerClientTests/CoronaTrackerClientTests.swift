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

    func testUpdateProfileContactIdentifierReturnsGeneralErrorCode() {
        let otherClientsProfileIdentifier = "2"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileContactIdentifierReturnsNotInfectedState() {
        let otherClientsProfileIdentifier = "3"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileContactIdentifierReturnsInfectedState() {
        let otherClientsProfileIdentifier = "4"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileStateToNotInfectedReturnsFailureStatusCode() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 0, identifier: "5") { statusCode in
            XCTAssertEqual(statusCode, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileStateToNotInfectedReturnsSuccessStatusCode() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 0, identifier: "6") { statusCode in
            XCTAssertEqual(statusCode, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileStateToInfectedReturnsFailureStatusCode() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 1, identifier: "7") { statusCode in
            XCTAssertEqual(statusCode, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileStateToInfectedReturnsSuccessStatusCode() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(state: 1, identifier: "8") { statusCode in
            XCTAssertEqual(statusCode, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

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
        ("testUpdateProfileContactIdentifierReturnsGeneralErrorCode", testUpdateProfileContactIdentifierReturnsGeneralErrorCode),
        ("testUpdateProfileContactIdentifierReturnsNotInfectedState", testUpdateProfileContactIdentifierReturnsNotInfectedState),
        ("testUpdateProfileContactIdentifierReturnsInfectedState", testUpdateProfileContactIdentifierReturnsInfectedState),
        ("testUpdateProfileStateToNotInfectedReturnsFailureStatusCode", testUpdateProfileStateToNotInfectedReturnsFailureStatusCode),
        ("testUpdateProfileStateToNotInfectedReturnsSuccessStatusCode", testUpdateProfileStateToNotInfectedReturnsSuccessStatusCode),
        ("testUpdateProfileStateToInfectedReturnsFailureStatusCode", testUpdateProfileStateToInfectedReturnsFailureStatusCode),
        ("testUpdateProfileStateToInfectedReturnsSuccessStatusCode", testUpdateProfileStateToInfectedReturnsSuccessStatusCode),
        ("testDeleteProfileReturnsFailureStatusCode", testDeleteProfileReturnsFailureStatusCode),
        ("testDeleteProfileReturnsSuccessStatusCode", testDeleteProfileReturnsSuccessStatusCode),
        ("testGetProfileStateReturnsGeneralErrorCode", testGetProfileStateReturnsGeneralErrorCode),
        ("testGetProfileStateReturnsNotInfectedState", testGetProfileStateReturnsNotInfectedState),
        ("testGetProfileStateReturnsInfectedState", testGetProfileStateReturnsInfectedState)
    ]
}
