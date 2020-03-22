//
//  CoronaTracker+TestInit.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

@testable import CoronaTracker
import CoronaTrackerClientTest

extension CoronaTracker {

    convenience init(provider: ProfileIdentifierProvider) {
        self.init(profileIdentifierProvider: provider, client: TestClient(), tokenProvider: TestTokenProvider())
    }
}
