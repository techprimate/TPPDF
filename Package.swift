// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "TPPDF",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_14),
    ],
    products: [
        .library(name: "TPPDF", targets: ["TPPDF"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", .exact("3.1.2")),
        .package(url: "https://github.com/Quick/Nimble", .exact("9.2.1")),
    ],
    targets: [
        .target(name: "TPPDF", path: "Source"),
        .testTarget(name: "TPPDFTests", dependencies: [
            "TPPDF",
            "Quick",
            "Nimble",
        ], resources: [
            .copy("resources/sample.pdf"),
        ]),
        .testTarget(name: "TPPDFIntegrationTests", dependencies: [
            "TPPDF",
            "Quick",
            "Nimble",
        ], resources: [
            .copy("resources/50-pages.pdf"),
        ]),
    ]
)
