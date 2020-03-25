// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "CoronaTrackerClient",
    products: [
        .library(name: "CoronaTrackerClient", targets: ["CoronaTrackerClient"]),
        .library(name: "CoronaTrackerClientTest", targets: ["CoronaTrackerClientTest"])
    ],
    targets: [
        .target(name: "CoronaTrackerClient"),
        .target(name: "CoronaTrackerClientTest", dependencies: ["CoronaTrackerClient"]),
        .testTarget(name: "CoronaTrackerClientTests", dependencies: ["CoronaTrackerClient", "CoronaTrackerClientTest"]),
    ]
)
