//
//  CoronaTracker.swift
//  CoronaTracker
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import CoronaTrackerClient

protocol ProfileIdentifierProvider {

    var profileIdentifier: String? { get }
}

final class CoronaTracker {

    init(profileIdentifierProvider: ProfileIdentifierProvider, client: Client, tokenProvider: TokenProvider) {
        self.profileIdentifierProvider = profileIdentifierProvider
        self.client = CoronaTrackerClient(client: client, tokenProvider: tokenProvider)
    }

    func start(completion: @escaping (_ profileIdentifier: String?, _ profileState: Int?) -> Void) {
        if let profileIdentifier = profileIdentifierProvider.profileIdentifier {
            startClientToPoll(profileIdentifier: profileIdentifier, completion: completion)
        } else {
            createProfile { profileIdentifier, error in
                if let profileIdentifier = profileIdentifier {
                    self.startClientToPoll(profileIdentifier: profileIdentifier.value, completion: completion)
                } else {
                    completion(nil, nil)
                }
            }
        }
    }

    struct ProfileIdentifier {
        let value: String
        fileprivate init(value: String) {
            self.value = value
        }
    }

    enum CreateProfileError: Error {
        case clientError
    }

    func createProfile(completion: @escaping (ProfileIdentifier?, Error?) -> Void) {
        client.createProfile { profileIdentifier in
            if let profileIdentifier = profileIdentifier {
                completion(.init(value: profileIdentifier), nil)
            } else {
                completion(nil, CreateProfileError.clientError)
            }
        }
    }

    enum ProfileState {
        case infected
        case notInfected

        fileprivate init?(clientProfileState: Int?) {
            switch clientProfileState {
            case 1: self = .infected
            case 0: self = .notInfected
            default: return nil
            }
        }

        fileprivate var clientProfileState: Int {
            switch self {
            case .notInfected: return 0
            case .infected: return 1
            }
        }
    }

    enum ChangeProfileStateError: Error {
        case missingProfileIdentifier
        case clientError
    }

    func changeProfileState(to state: ProfileState, completion: @escaping (ProfileState?, Error?) -> Void) {
        if let profileIdentifier = profileIdentifierProvider.profileIdentifier {
            client.updateProfile(state: state.clientProfileState, identifier: profileIdentifier) { statusCode in
                switch statusCode {
                case 0: completion(state, nil)
                default: completion(nil, ChangeProfileStateError.clientError)
                }
            }
        } else {
            completion(nil, ChangeProfileStateError.missingProfileIdentifier)
        }
    }

    struct ContactIdentifier {
        let value: String
    }

    enum RegisterContactIdentifierError: Error {
        case missingProfileIdentifier
        case clientError
    }

    func registerContactIdentifier(_ identifier: ContactIdentifier, completion: @escaping (ProfileState?, Error?) -> Void) {
        if let profileIdentifier = profileIdentifierProvider.profileIdentifier {
            client.updateProfile(contactIdentifier: identifier.value, profileIdentifier: profileIdentifier) { state in
                if let profileState = ProfileState(clientProfileState: state) {
                    completion(profileState, nil)
                } else {
                    completion(nil, RegisterContactIdentifierError.clientError)
                }
            }
        } else {
            completion(nil, RegisterContactIdentifierError.missingProfileIdentifier)
        }
    }

    enum DeleteProfileError: Error {
        case missingProfileIdentifier
        case clientError
    }

    func deleteProfile(completion: @escaping (Error?) -> Void) {
        if let profileIdentifier = profileIdentifierProvider.profileIdentifier {
            client.deleteProfile(identifier: profileIdentifier) { statusCode in
                switch statusCode {
                case 0: completion(nil)
                default: completion(DeleteProfileError.clientError)
                }
            }
        } else {
            completion(DeleteProfileError.missingProfileIdentifier)
        }
    }

    private func startClientToPoll(profileIdentifier: String, completion: @escaping (_ profileIdentifier: String, _ profileState: Int?) -> Void) {
        client.getProfile(identifier: profileIdentifier) { profileState in
            completion(profileIdentifier, profileState)
        }
    }

    private let profileIdentifierProvider: ProfileIdentifierProvider
    private let client: CoronaTrackerClient
}
