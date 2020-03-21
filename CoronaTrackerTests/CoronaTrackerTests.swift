//
//  CoronaTrackerTests.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
@testable import CoronaTracker
import CoronaTrackerClient

final class CoronaTrackerTests: XCTestCase {

    func testURLClientCreateProfile() {
        let url = Bundle(for: Self.classForCoder()).url(forResource: "Config", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let config = try! PropertyListDecoder().decode(Config.self, from: data)

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient(client: URLClient(config: config)).createProfile() { profileIdentifier in
            XCTAssertEqual(profileIdentifier, "Hello, World!")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }
}

private extension CoronaTrackerClient {

    init(client: Client) {
        self.init(client: client, tokenProvider: TestTokenProvider())
    }
}

private extension URLClient {

    convenience init(config: Config) {
        self.init(serverAddress: config.serverAddress)
    }
}

private struct Config: Decodable {

    private enum CodingKeys: String, CodingKey {
        case serverAddress = "Server Address"
    }

    var serverAddress: String
}
