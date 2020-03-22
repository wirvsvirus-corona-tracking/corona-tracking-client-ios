//
//  CoronaTrackerClient.swift
//  CoronaTrackerClient
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import Foundation

private extension Token {
    var data: Data { value.data(using: .utf8)! }
}

public struct CoronaTrackerClient {

    public init(client: Client, tokenProvider: TokenProvider) {
        self.client = client
        self.tokenProvider = tokenProvider
    }

    public func createProfile(_ completion: @escaping (_ profileIdentifier: String?) -> Void) {
        client.send(("POST", "/api/profiles", tokenProvider.token.data)) { response in
            let profileIdentifier: String?
            if let data = response.data {
                do {
                    let profile = try JSONDecoder().decode(ProfileIdentifier.self, from: data)
                    profileIdentifier = profile.identifier
                } catch {
                    profileIdentifier = nil
                }
            } else {
                profileIdentifier = nil
            }
            completion(profileIdentifier)
        }
    }

    public func getProfile(identifier: String, completion: @escaping (_ state: Int?) -> Void) {
        client.send(("GET", "/api/profiles/\(identifier)", tokenProvider.token.data)) { response in
            let state: Int?
            if let data = response.data {
                do {
                    let profile = try JSONDecoder().decode(ProfileState.self, from: data)
                    state = profile.state
                } catch {
                    state = nil
                }
            } else {
                state = nil
            }
            completion(state)
        }
    }

    public func updateProfile(contactIdentifier: String, profileIdentifier: String, completion: @escaping (_ state: Int?) -> Void) {
        let body = try! JSONEncoder().encode(ContactIdentifier(token: tokenProvider.token.value, contactIdentifier: contactIdentifier))
        client.send(("PUT", "/api/profiles/\(profileIdentifier)", body)) { response in
            let state: Int?
            if let data = response.data {
                do {
                    let profile = try JSONDecoder().decode(ProfileState.self, from: data)
                    state = profile.state
                } catch {
                    state = nil
                }
            } else {
                state = nil
            }
            completion(state)
        }
    }

    public func updateProfile(state: Int, identifier: String, completion: @escaping (_ statusCode: Int?) -> Void) {
        client.send(("PUT", "/api/profiles/\(identifier)", tokenProvider.token.data)) { response in
            let statusCode: Int?
            if let data = response.data {
                do {
                    let profile = try JSONDecoder().decode(StatusCode.self, from: data)
                    statusCode = profile.statusCode
                } catch {
                    statusCode = nil
                }
            } else {
                statusCode = nil
            }
            completion(statusCode)
        }
    }

    public func deleteProfile(identifier: String, completion: @escaping (_ statusCode: Int?) -> Void) {
        client.send(("DELETE", "/api/profiles/\(identifier)", tokenProvider.token.data)) { response in
            let statusCode: Int?
            if let data = response.data {
                do {
                    let profile = try JSONDecoder().decode(StatusCode.self, from: data)
                    statusCode = profile.statusCode
                } catch {
                    statusCode = nil
                }
            } else {
                statusCode = nil
            }
            completion(statusCode)
        }
    }

    private let client: Client
    private let tokenProvider: TokenProvider
}

private struct ContactIdentifier: Encodable {

    private enum CodingKeys: String, CodingKey {
        case token
        case contactIdentifier = "contact_id"
    }

    let token: String
    let contactIdentifier: String
}

private struct ProfileIdentifier: Decodable {

    private enum CodingKeys: String, CodingKey {
        case identifier = "profile_id"
    }

    let identifier: String
}

private struct ProfileState: Decodable {

    let state: Int
}

private struct StatusCode: Decodable {

    private enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
    }

    let statusCode: Int
}
