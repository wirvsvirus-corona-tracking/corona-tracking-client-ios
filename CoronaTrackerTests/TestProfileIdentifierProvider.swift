//
//  TestProfileIdentifierProvider.swift
//  CoronaTrackerTests
//
//  Created by Stephan Lemnitzer on 22.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

@testable import CoronaTracker

final class TestProfileIdentifierProvider: ProfileIdentifierProvider {

    let profileIdentifier: String?

    init(profileIdentifier: String?) {
        self.profileIdentifier = profileIdentifier
    }
}
