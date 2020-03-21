// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CoronaTrackerClient",
    products: [
        .library(name: "CoronaTrackerClient", targets: ["CoronaTrackerClient"])
    ],
    targets: [
        .target(name: "CoronaTrackerClient"),
        .testTarget(name: "CoronaTrackerClientTests", dependencies: ["CoronaTrackerClient"]),
    ]
)
