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
            XCTAssertEqual(profileIdentifier, "1")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

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

    static var allTests = [
        ("testCreateProfile", testCreateProfile),
        ("testUpdateProfileReturnsGeneralErrorCode", testUpdateProfileContactIdentifierReturnsGeneralErrorCode),
        ("testUpdateProfileReturnsNotInfectedState", testUpdateProfileContactIdentifierReturnsNotInfectedState),
        ("testUpdateProfileReturnsInfectedState", testUpdateProfileContactIdentifierReturnsInfectedState),
        ("testUpdateProfileStateToNotInfectedReturnsFailureStatusCode", testUpdateProfileStateToNotInfectedReturnsFailureStatusCode),
        ("testUpdateProfileStateToNotInfectedReturnsSuccessStatusCode", testUpdateProfileStateToNotInfectedReturnsSuccessStatusCode),
        ("testUpdateProfileStateToInfectedReturnsFailureStatusCode", testUpdateProfileStateToInfectedReturnsFailureStatusCode),
        ("testUpdateProfileStateToInfectedReturnsSuccessStatusCode", testUpdateProfileStateToInfectedReturnsSuccessStatusCode)
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
        case let ("PUT", "/api/profiles/5", body):
            updateProfileStateReturningFailureStatusCode(token: body, response: response)
        case let ("PUT", "/api/profiles/6", body):
            updateProfileStateReturningSuccessStatusCode(token: body, response: response)
        case let ("PUT", "/api/profiles/7", body):
            updateProfileStateReturningFailureStatusCode(token: body, response: response)
        case let ("PUT", "/api/profiles/8", body):
            updateProfileStateReturningSuccessStatusCode(token: body, response: response)
        default:
            fatalError("request not supported: \(request)")
        }
    }

    private func createProfile(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"profile_id":"1"}"#.data(using: .utf8), error: nil))
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

    private func updateProfileStateReturningFailureStatusCode(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":-1}"#.data(using: .utf8), error: nil))
    }

    private func updateProfileStateReturningSuccessStatusCode(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":0}"#.data(using: .utf8), error: nil))
    }

    private func isTokenValid(token: String?) -> Bool {
        guard let token = token else { return false }
        guard token.count <= 24 else { return false }
        return true
    }
}
