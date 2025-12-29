// swift-tools-version:6.1

import PackageDescription

var testingDependencies: [Package.Dependency] = []
var testingTargets: [Target] = []

let isTestingEnabled = /*TESTING_FLAG*/false/*TESTING_FLAG*/
if isTestingEnabled {
    testingDependencies = [
        .package(url: "https://github.com/Quick/Quick", exact: "3.1.2"),
        .package(url: "https://github.com/Quick/Nimble", exact: "9.2.1"),
    ]
    testingTargets = [
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
}

let package = Package(
    name: "TPPDF",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14),
        .macCatalyst(.v13),
        .visionOS(.v1),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(name: "TPPDF", targets: ["TPPDF"]),
    ],
    dependencies: testingDependencies,
    targets: [
        .target(name: "TPPDF", path: "Source"),
    ] + testingTargets
)
