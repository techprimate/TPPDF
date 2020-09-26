// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "TPPDF",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_14)
    ],
    products: [
        .library(name: "TPPDF", targets: ["TPPDF"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", .exact("2.2.0")),
        .package(url: "https://github.com/Quick/Nimble",  .exact("8.0.7")),
    ],
    targets: [
        .target(name: "TPPDF", path: "Source"),
        .testTarget(name: "TPPDFTests", dependencies: [
            "TPPDF",
            "Quick",
            "Nimble"
        ]),
    ]
)
