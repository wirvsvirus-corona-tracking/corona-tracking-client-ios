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
        CoronaTrackerClient().createProfile() { profileIdentifier in
            XCTAssertEqual(profileIdentifier, "Hello, World!")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("testCreateProfile", testCreateProfile)
    ]
}

private extension CoronaTrackerClient {

    init() {
        self.init(client: TestClient(), tokenProvider: TestTokenProvider())
    }
}

private final class TestTokenProvider: TokenProvider {

    let token: Token

    init() {
        token = Token(value: "test-token")!
    }
}

private final class TestClient: Client {

    func send(_ request: Request, response: @escaping (Response) -> Void) {
        switch request {
        case let ("POST", "/api/profiles", body):
            createProfile(token: body, response: response)
        default:
            fatalError("request not supported: \(request)")
        }
    }

    private func createProfile(token: String?, response: (Response) -> Void) {
        guard let token = token else {
            response((nil, nil, nil))
            return
        }
        guard token.count <= 24 else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"profile_id":"Hello, World!"}"#.data(using: .utf8), error: nil))
    }
}
