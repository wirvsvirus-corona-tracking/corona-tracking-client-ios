//
//  TestClient.swift
//  CoronaTrackerClientTest
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import CoronaTrackerClient

public final class TestTokenProvider: TokenProvider {

    public let token: Token

    public init() {
        token = Token(value: "test-token")!
    }
}
