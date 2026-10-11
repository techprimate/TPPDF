// swift-tools-version:6.1

import PackageDescription

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
)
