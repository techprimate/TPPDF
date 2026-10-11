// swift-tools-version:6.1

import PackageDescription

var testingTargets: [Target] = []

let isTestingEnabled = /*TESTING_FLAG*/false/*TESTING_FLAG*/
if isTestingEnabled {
    testingTargets = [
        .testTarget(name: "TPPDFTests", dependencies: ["TPPDF"], resources: [
            .copy("resources/graphics-fixture.gif"),
            .copy("resources/sample.pdf"),
            .copy("resources/image-fixture.jpg"),
            .copy("resources/table-content-fixture.png"),
        ]),
        .testTarget(name: "TPPDFIntegrationTests", dependencies: ["TPPDF"], resources: [
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
    targets: [
        .target(name: "TPPDF", path: "Source"),
    ] + testingTargets
)
