// swift-tools-version:5.3

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
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble",  .upToNextMajor(from: "9.0.0")),
    ],
    targets: [
        .target(name: "TPPDF", path: "Source"),
        .testTarget(name: "TPPDFTests", dependencies: [
            "TPPDF",
            "Quick",
            "Nimble"
        ], resources: [
            .copy("resources/sample.pdf"),
        ]),
        .testTarget(name: "TPPDFIntegrationTests", dependencies: [
            "TPPDF",
            "Quick",
            "Nimble"
        ], resources: [
            .copy("resources/50-pages.pdf"),
        ]),
    ]
)
