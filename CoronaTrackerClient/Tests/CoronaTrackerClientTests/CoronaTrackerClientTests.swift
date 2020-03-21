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

    func testUpdateProfileReturnsGeneralErrorCode() {
        let otherClientsProfileIdentifier = "2"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, -1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileReturnsNotInfectedState() {
        let otherClientsProfileIdentifier = "3"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, 0)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    func testUpdateProfileReturnsInfectedState() {
        let otherClientsProfileIdentifier = "4"

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient().updateProfile(contactIdentifier: otherClientsProfileIdentifier) { state in
            XCTAssertEqual(state, 1)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    static var allTests = [
        ("testCreateProfile", testCreateProfile),
        ("testUpdateProfileReturnsGeneralErrorCode", testUpdateProfileReturnsGeneralErrorCode),
        ("testUpdateProfileReturnsNotInfectedState", testUpdateProfileReturnsNotInfectedState),
        ("testUpdateProfileReturnsInfectedState", testUpdateProfileReturnsInfectedState)
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
        case let ("PUT", "/api/profiles/2", body):
            updateProfileReturningGeneralErrorCode(token: body, response: response)
        case let ("PUT", "/api/profiles/3", body):
            updateProfileReturningNotInfectedState(token: body, response: response)
        case let ("PUT", "/api/profiles/4", body):
            updateProfileReturningInfectedState(token: body, response: response)
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

    private func updateProfileReturningGeneralErrorCode(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":-1}"#.data(using: .utf8), error: nil))
    }

    private func updateProfileReturningNotInfectedState(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":0}"#.data(using: .utf8), error: nil))
    }

    private func updateProfileReturningInfectedState(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":1}"#.data(using: .utf8), error: nil))
    }

    private func isTokenValid(token: String?) -> Bool {
        guard let token = token else { return false }
        guard token.count <= 24 else { return false }
        return true
    }
}
