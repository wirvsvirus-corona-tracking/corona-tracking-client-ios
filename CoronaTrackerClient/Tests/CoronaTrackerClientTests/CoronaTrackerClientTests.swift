//
//  CoronaTrackerClientTests.swift
//  CoronaTrackerClient
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class CoronaTrackerClientTests: XCTestCase {

    func testCreateProfile() {
        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient(client: TestClient()).createProfile() { profileIdentifier in
            XCTAssertEqual(profileIdentifier, "Hello, World!")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("testCreateProfile", testCreateProfile)
    ]
}

private final class TestClient: Client {

    func send(_ request: Request, response: @escaping (Response) -> Void) {
        createProfile() { profileIdentifier in
            response((nil, profileIdentifier, nil))
        }
    }

    private func createProfile(response: (_ profileIdentifier: String?) -> Void) {
        response("Hello, World!")
    }
}
