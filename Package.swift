// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TPPDF",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "TPPDF",
            targets: ["TPPDF"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "TPPDF",
            dependencies: [],
            path: "Source"
        )
    ]
)
