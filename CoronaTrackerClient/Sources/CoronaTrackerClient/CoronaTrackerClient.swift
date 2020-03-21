//
//  CoronaTrackerClient.swift
//  CoronaTrackerClient
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import Foundation

public struct CoronaTrackerClient {

    public init(client: Client, tokenProvider: TokenProvider) {
        self.client = client
        self.tokenProvider = tokenProvider
    }

    public func createProfile(_ completion: @escaping (_ profileIdentifier: String?) -> Void) {
        client.send(("POST", "/api/profiles", tokenProvider.token.value)) { response in
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

    public func updateProfile(contactIdentifier: String, completion: @escaping (_ state: Int?) -> Void) {
        client.send(("PUT", "/api/profiles/\(contactIdentifier)", tokenProvider.token.value)) { response in
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
        client.send(("PUT", "/api/profiles/\(identifier)", tokenProvider.token.value)) { response in
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
        client.send(("DELETE", "/api/profiles/\(identifier)", tokenProvider.token.value)) { response in
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
