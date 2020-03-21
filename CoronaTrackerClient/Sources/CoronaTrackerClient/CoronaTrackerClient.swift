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
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
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

    private let client: Client
    private let tokenProvider: TokenProvider
}

private struct Profile: Decodable {

    private enum CodingKeys: String, CodingKey {
        case identifier = "profile_id"
    }

    let identifier: String
}
