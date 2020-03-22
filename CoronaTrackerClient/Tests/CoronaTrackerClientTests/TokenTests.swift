//
//  TokenTests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest
import CoronaTrackerClient

final class TokenTests: XCTestCase {

    func test_token_is_valid() {
        let token = Token(value: "")
        XCTAssertNotNil(token)
    }

    func test_token_has_not_more_than_24_characters() {
        let token = Token(value: "444466664444666644446666444466661")
        XCTAssertNil(token)
    }
}
