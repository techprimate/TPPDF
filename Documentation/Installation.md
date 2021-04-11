# Installation

## Requirements

As of TPPDF 2.0 and Swift 5.2, we do not actively support older Swift versions anymore. If you still need an older Swift version, see the following table for their respective branches. Bleed development version can be found on the `develop` branch.

| Language  | Branch                                                           | Pod version | Xcode version         | iOS version |
| --------- | ---------------------------------------------------------------- | ----------- | --------------------- | ----------- |
| Swift 4.2 | [swift-4.2](https://github.com/techprimate/TPPDF/tree/swift-4.2) | >= 1.3.x    | Xcode 10.0+           | iOS 8.3+    |
| Swift 4.1 | [swift-4.1](https://github.com/techprimate/TPPDF/tree/swift-4.1) | >= 1.0.x    | Xcode 9.3             | iOS 8.3+    |
| Swift 3.0 | [swift-3.0](https://github.com/techprimate/TPPDF/tree/swift-3.0) | >= 0.2.x    | Xcode 8               | iOS 8.0+    |
| Swift 2.3 | [swift-2.3](https://github.com/techprimate/TPPDF/tree/swift-2.3) | 0.1.5       | Xcode 8, Xcode 7.3.x  | iOS 8.0+    |
| Swift 2.2 | [swift-2.2](https://github.com/techprimate/TPPDF/tree/swift-2.3) | 0.1.4       | Xcode 7.3.x           | iOS 8.0+    |


## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate TPPDF into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://cdn.cocoapods.org/'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'TPPDF'
end
```

Then, run the following command:

```bash
$ pod install
```

## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate TPPDF into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "techprimate/TPPDF" ~> 1.4
```

Run `carthage update` to build the framework and drag the built `TPPDF.framework` into your Xcode project

## Swift Package Manager

Swift Package Manager is now supported for iOS. macOS support is a requested feature and work-in-progress. 

Linux support is not available, as `UIKit` is not available on linux.

Once you have your Swift package set up, adding TPPDF as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/techprimate/TPPDF", .upToNextMajor(from: "2.0.0"))
]
```

## Manual Installation

As Xcode project configurations are getting pretty complex, it is recommended to use a dependency manager.
If you still want to add TPPDF manually, please see issue [#97](https://github.com/techprimate/TPPDF/issues/97).