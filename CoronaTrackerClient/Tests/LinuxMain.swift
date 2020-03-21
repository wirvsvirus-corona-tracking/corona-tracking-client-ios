//
//  LinuxMain.swift
//  CoronaTrackerClient
//
//  Created by Stephan Lemnitzer on 21.03.20.
//  Copyright © 2020 WirVsVirus - Corona Tracking. All rights reserved.
//

import XCTest

import CoronaTrackerClientTests

var tests = [XCTestCaseEntry]()
tests += CoronaTrackerClientTests.allTests()
XCTMain(tests)
