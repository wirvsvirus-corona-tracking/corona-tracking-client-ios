//
//  Tracker.swift
//  CoronaTracker
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import CoronaTrackerClient

protocol ProfileIdentifierProvider {

    var profileIdentifier: String? { get }
}

final class Tracker {

    init(profileIdentifierProvider: ProfileIdentifierProvider, client: Client, tokenProvider: TokenProvider) {
        self.profileIdentifierProvider = profileIdentifierProvider
        self.client = CoronaTrackerClient(client: client, tokenProvider: tokenProvider)
    }

    func start(completion: @escaping (_ profileIdentifier: String, _ profileState: Int) -> Void) {
        if let profileIdentifier = profileIdentifierProvider.profileIdentifier {
            startClientToPoll(profileIdentifier: profileIdentifier, completion: completion)
        } else {
            client.createProfile { profileIdentifier in
                if let profileIdentifier = profileIdentifier {
                    self.startClientToPoll(profileIdentifier: profileIdentifier, completion: completion)
                } else {
                    fatalError("could not create profile")
                }
            }
        }
    }

    private func startClientToPoll(profileIdentifier: String, completion: @escaping (_ profileIdentifier: String, _ profileState: Int) -> Void) {
        client.getProfile(identifier: profileIdentifier) { profileState in
            if let profileState = profileState {
                completion(profileIdentifier, profileState)
            } else {
                fatalError("could not get profile")
            }
        }
    }

    private let profileIdentifierProvider: ProfileIdentifierProvider
    private let client: CoronaTrackerClient
}
