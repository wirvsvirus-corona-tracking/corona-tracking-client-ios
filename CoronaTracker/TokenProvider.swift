//
//  TokenProvider.swift
//  CoronaTracker
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import CoronaTrackerClient

final class TestTokenProvider: TokenProvider {

    let token: Token

    init() {
        token = Token(value: "test-token")!
    }
}
