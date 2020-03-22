//
//  CoronaTrackerUITests.swift
//  CoronaTrackerUITests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

final class CoronaTrackerUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func test_initial_start() {
        let app = XCUIApplication()
        app.launch()
        XCTAssert(app.wait(for: .runningForeground, timeout: 5))
        let profileState = app.images["ProfileState"]
        XCTAssert(profileState.waitForExistence(timeout: 3))
        XCTAssertEqual(profileState.label, "You are not infected")
    }
}
