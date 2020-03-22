//
//  TestClient.swift
//  CoronaTrackerClientTest
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import CoronaTrackerClient

public final class TestClient: Client {

    public init() {}

    public func send(_ request: Request, response: @escaping (Response) -> Void) {
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
        response((statusCode: nil, data: #"{"profile_id":"12"}"#.data(using: .utf8), error: nil))
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
