//
//  URLClientTests.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

import CoronaTrackerClient
import CoronaTrackerClientTest
@testable import CoronaTracker

final class URLClientTests: XCTestCase {

    override class func setUp() {
        config = Self.loadConfig()
    }

    func test_create_profile() throws {

        let expectation = self.expectation(description: "\(#function)")
        CoronaTrackerClient(client: client).createProfile() { profileIdentifier in
            XCTAssertNotNil(profileIdentifier)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1)
    }

    private var client: URLClient {
        URLClient(config: Self.config!)
    }

    private static var config: Config?

    private class func loadConfig() -> Config {
        let url = Bundle(for: Self.classForCoder()).url(forResource: "Config", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let config = try! PropertyListDecoder().decode(Config.self, from: data)
        guard let _: URL = URL(string: config.serverAddress) else {
            fatalError("please provide a valid server address")
        }
        return config
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

    let serverAddress: String
}
