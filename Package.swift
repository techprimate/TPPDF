// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "TPPDF",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_14),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "TPPDF", targets: ["TPPDF"]),
    ],
    dependencies: [
        //dev .package(url: "https://github.com/Quick/Quick", from: "3.1.2"),
        //dev .package(url: "https://github.com/Quick/Nimble", from: "9.2.1"),
    ],
    targets: [
        .target(name: "TPPDF", path: "Source"),
        //dev .testTarget(name: "TPPDFTests", dependencies: [
        //dev     "TPPDF",
        //dev     "Quick",
        //dev     "Nimble",
        //dev ], resources: [
        //dev     .copy("resources/sample.pdf"),
        //dev ]),
        //dev .testTarget(name: "TPPDFIntegrationTests", dependencies: [
        //dev     "TPPDF",
        //dev     "Quick",
        //dev     "Nimble",
        //dev ], resources: [
        //dev     .copy("resources/50-pages.pdf"),
        //dev ]),
    ]
)
