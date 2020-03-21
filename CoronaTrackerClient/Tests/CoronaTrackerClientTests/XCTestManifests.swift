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
        testCase(CreateProfileTests.allTests),
        testCase(UpdateProfileContactIdentifierTests.allTests),
        testCase(UpdateProfileStateTests.allTests),
        testCase(DeleteProfileTests.allTests),
        testCase(GetProfileTests.allTests)
    ]
}
#endif
