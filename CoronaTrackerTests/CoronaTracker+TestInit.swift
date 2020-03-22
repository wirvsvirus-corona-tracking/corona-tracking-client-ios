//
//  CoronaTracker+TestInit.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import Foundation

@testable import CoronaTracker
import CoronaTrackerClientTest

private enum TestClientImplementation: String {
    case offline
    case webservice
}

extension CoronaTracker {

    convenience init(profileIdentifier: String?) {
        let implementation: TestClientImplementation = ProcessInfo().arguments.compactMap({ TestClientImplementation(rawValue: $0) }).first ?? .offline
        switch implementation {
        case .offline:
            self.init(
                profileIdentifierProvider: TestProfileIdentifierProvider(profileIdentifier: profileIdentifier),
                client: TestClient(),
                tokenProvider: TestTokenProvider()
            )
        case .webservice:
            self.init(
                profileIdentifierProvider: TestProfileIdentifierProvider(profileIdentifier: profileIdentifier),
                client: URLClient(serverAddress: loadConfig().serverAddress),
                tokenProvider: TestTokenProvider()
            )
        }
    }
}

private final class TestProfileIdentifierProvider: ProfileIdentifierProvider {

    let profileIdentifier: String?

    init(profileIdentifier: String?) {
        self.profileIdentifier = profileIdentifier
    }
}

private extension Bundle {
    static var tests: Bundle { Bundle(identifier: "de.wirvsvirus.corona-tracking.ios.CoronaTrackerTests")! }
}

private struct Config: Decodable {
    private enum CodingKeys: String, CodingKey {
        case serverAddress = "Server Address"
    }
    let serverAddress: String
}

private func loadConfig() -> Config {
    let url = Bundle.tests.url(forResource: "Config", withExtension: "plist")!
    let data = try! Data(contentsOf: url)
    let config = try! PropertyListDecoder().decode(Config.self, from: data)
    guard let _: URL = URL(string: config.serverAddress) else {
        fatalError("please provide a valid server address")
    }
    return config
}
