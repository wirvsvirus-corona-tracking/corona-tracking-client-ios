//
//  Token.swift
//  CoronaTrackerClient
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

public struct Token {

    let value: String

    public init?(value: String) {
        guard value.count <= 24 else { return nil }
        self.value = value
    }
}
