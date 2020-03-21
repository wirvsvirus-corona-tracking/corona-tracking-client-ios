//
//  LinuxMain.swift
//  CoronaTrackerClientTests
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

import CoronaTrackerClientTests

var tests = [XCTestCaseEntry]()
tests += CreateProfileTests.allTests()
tests += UpdateProfileContactIdentifierTests.allTests()
tests += UpdateProfileStateTests.allTests()
tests += DeleteProfileTests.allTests()
tests += GetProfileTests.allTests()
XCTMain(tests)
