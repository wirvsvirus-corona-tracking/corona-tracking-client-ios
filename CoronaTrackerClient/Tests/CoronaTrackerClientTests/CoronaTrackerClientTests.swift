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
        ("testCreateProfile", testCreateProfile),
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
        case let ("DELETE", "/api/profiles/9", body):
            deleteProfileReturningFailureStatusCode(token: body, response: response)
        case let ("DELETE", "/api/profiles/10", body):
            deleteProfileReturningSuccessStatusCode(token: body, response: response)
        case let ("GET", "/api/profiles/11", body):
            getProfileReturningGeneralErrorCode(token: body, response: response)
        case let ("GET", "/api/profiles/12", body):
            getProfileReturningNotInfectedState(token: body, response: response)
        case let ("GET", "/api/profiles/13", body):
            getProfileReturningInfectedState(token: body, response: response)
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

    private func deleteProfileReturningFailureStatusCode(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":-1}"#.data(using: .utf8), error: nil))
    }

    private func deleteProfileReturningSuccessStatusCode(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":0}"#.data(using: .utf8), error: nil))
    }

    private func getProfileReturningGeneralErrorCode(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":-1}"#.data(using: .utf8), error: nil))
    }

    private func getProfileReturningNotInfectedState(token: String?, response: (Response) -> Void) {
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":0}"#.data(using: .utf8), error: nil))
    }

    private func getProfileReturningInfectedState(token: String?, response: (Response) -> Void) {
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
