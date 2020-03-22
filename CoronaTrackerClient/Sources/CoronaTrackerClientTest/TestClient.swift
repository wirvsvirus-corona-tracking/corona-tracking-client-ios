//
//  TestClient.swift
//  CoronaTrackerClientTest
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import Foundation
import CoronaTrackerClient

public final class TestClient: Client {

    public init() {}

    public func send(_ request: Request, response: @escaping (Response) -> Void) {
        switch request {
        case let ("POST", "/api/profiles", body):
            createProfile(body: body, response: response)
        case let ("PUT", "/api/profiles/2", body):
            updateProfileContactIdentifierReturningGeneralErrorCode(body: body, response: response)
        case let ("PUT", "/api/profiles/3", body):
            updateProfileContactIdentifierReturningNotInfectedState(body: body, response: response)
        case let ("PUT", "/api/profiles/4", body):
            updateProfileContactIdentifierReturningInfectedState(body: body, response: response)
        case let ("PUT", "/api/profiles/5", body):
            updateProfileStateReturningFailureStatusCode(body: body, response: response)
        case let ("PUT", "/api/profiles/6", body):
            updateProfileStateReturningSuccessStatusCode(body: body, response: response)
        case let ("PUT", "/api/profiles/7", body):
            updateProfileStateReturningFailureStatusCode(body: body, response: response)
        case let ("PUT", "/api/profiles/8", body):
            updateProfileStateReturningSuccessStatusCode(body: body, response: response)
        case let ("DELETE", "/api/profiles/9", body):
            deleteProfileReturningFailureStatusCode(body: body, response: response)
        case let ("DELETE", "/api/profiles/10", body):
            deleteProfileReturningSuccessStatusCode(body: body, response: response)
        case let ("GET", "/api/profiles/11", body):
            getProfileReturningGeneralErrorCode(body: body, response: response)
        case let ("GET", "/api/profiles/12", body):
            getProfileReturningNotInfectedState(body: body, response: response)
        case let ("GET", "/api/profiles/13", body):
            getProfileReturningInfectedState(body: body, response: response)
        default:
            fatalError("request not supported: \(request)")
        }
    }

    private func createProfile(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"profile_id":"12"}"#.data(using: .utf8), error: nil))
    }

    private struct ContactIdentifier: Decodable {
        private enum CodingKeys: String, CodingKey {
            case token
            case contactIdentifier = "contact_id"
        }
        let token: String
        let contactIdentifier: String
    }

    private func updateProfileContactIdentifierReturningGeneralErrorCode(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let contactIdentifier = try? JSONDecoder().decode(ContactIdentifier.self, from: body)
        guard contactIdentifier != nil else {
            response((nil, nil, nil))
            return
        }
        guard isTokenValid(token: contactIdentifier?.token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":-1}"#.data(using: .utf8), error: nil))
    }

    private func updateProfileContactIdentifierReturningNotInfectedState(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let contactIdentifier = try? JSONDecoder().decode(ContactIdentifier.self, from: body)
        guard contactIdentifier != nil else {
            response((nil, nil, nil))
            return
        }
        guard isTokenValid(token: contactIdentifier?.token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":0}"#.data(using: .utf8), error: nil))
    }

    private func updateProfileContactIdentifierReturningInfectedState(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let contactIdentifier = try? JSONDecoder().decode(ContactIdentifier.self, from: body)
        guard contactIdentifier != nil else {
            response((nil, nil, nil))
            return
        }
        guard isTokenValid(token: contactIdentifier?.token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":1}"#.data(using: .utf8), error: nil))
    }

    private func updateProfileStateReturningFailureStatusCode(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":-1}"#.data(using: .utf8), error: nil))
    }

    private func updateProfileStateReturningSuccessStatusCode(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":0}"#.data(using: .utf8), error: nil))
    }

    private func deleteProfileReturningFailureStatusCode(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":-1}"#.data(using: .utf8), error: nil))
    }

    private func deleteProfileReturningSuccessStatusCode(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"status_code":0}"#.data(using: .utf8), error: nil))
    }

    private func getProfileReturningGeneralErrorCode(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":-1}"#.data(using: .utf8), error: nil))
    }

    private func getProfileReturningNotInfectedState(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
        guard isTokenValid(token: token) else {
            response((nil, nil, nil))
            return
        }
        response((statusCode: nil, data: #"{"state":0}"#.data(using: .utf8), error: nil))
    }

    private func getProfileReturningInfectedState(body: Data?, response: (Response) -> Void) {
        guard let body = body else {
            response((nil, nil, nil))
            return
        }
        let token = String(data: body, encoding: .utf8)
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
