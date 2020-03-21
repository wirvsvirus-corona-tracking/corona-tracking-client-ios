//
//  CoronaTrackerClient+Init.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import CoronaTrackerClient

extension CoronaTrackerClient {

    init() {
        self.init(client: TestClient(), tokenProvider: TestTokenProvider())
    }
}
