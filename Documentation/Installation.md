# Installation

## Requirements

As of TPPDF 2.0 and Swift 5.2, we do not actively support older Swift versions anymore. If you still need an older Swift version, see the following table for their respective branches. Bleed development version can be found on the `develop` branch.

| Language  | Branch                                                           | Xcode version        | iOS version |
| --------- | ---------------------------------------------------------------- | -------------------- | ----------- |
| Swift 4.2 | [swift-4.2](https://github.com/techprimate/TPPDF/tree/swift-4.2) | Xcode 10.0+          | iOS 8.3+    |
| Swift 4.1 | [swift-4.1](https://github.com/techprimate/TPPDF/tree/swift-4.1) | Xcode 9.3            | iOS 8.3+    |
| Swift 3.0 | [swift-3.0](https://github.com/techprimate/TPPDF/tree/swift-3.0) | Xcode 8              | iOS 8.0+    |
| Swift 2.3 | [swift-2.3](https://github.com/techprimate/TPPDF/tree/swift-2.3) | Xcode 8, Xcode 7.3.x | iOS 8.0+    |
| Swift 2.2 | [swift-2.2](https://github.com/techprimate/TPPDF/tree/swift-2.3) | Xcode 7.3.x          | iOS 8.0+    |

## Swift Package Manager

Swift Package Manager is the supported dependency manager for TPPDF on iOS, macOS, Mac Catalyst, tvOS, watchOS, and visionOS.

Linux is not supported because TPPDF depends on Apple graphics frameworks.

Once you have your Swift package set up, adding TPPDF as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/techprimate/TPPDF", .upToNextMajor(from: "2.0.0"))
]
```

## Manual Installation

As Xcode project configurations are getting pretty complex, it is recommended to use a dependency manager.
If you still want to add TPPDF manually, please see issue [#97](https://github.com/techprimate/TPPDF/issues/97).
