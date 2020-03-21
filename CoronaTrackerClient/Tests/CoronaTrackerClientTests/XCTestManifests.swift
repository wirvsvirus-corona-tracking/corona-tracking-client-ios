//
//  XCTestManifests.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CoronaTrackerClientTests.allTests),
        testCase(CreateProfileTests.allTests),
        testCase(UpdateProfileContactIdentifierTests.allTests),
        testCase(UpdateProfileStateTests.allTests)
    ]
}
#endif
