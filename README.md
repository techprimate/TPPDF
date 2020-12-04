<p align="center">
	<img src="https://raw.githubusercontent.com/techprimate/tppdf/master/resources/header.png" alt="TPPDF">
</p>

<p align="center">
	<a href="https://github.com/Carthage/Carthage">
		<img src="https://img.shields.io/badge/language-Swift-orange.svg?style=flat-square" alt="Swift"/>
	</a>
	<img src="https://img.shields.io/cocoapods/v/TPPDF.svg?style=flat-square" alt="Cocoapods"/>
	<img src="https://img.shields.io/badge/Carthage-compatible-blue.svg?style=flat-square" alt="Carthage"/>
	<a href="http://cocoapods.org/pods/TPPDF">
		<img src="https://img.shields.io/cocoapods/p/TPPDF.svg?style=flat-square" alt="iOS"/>
	</a>
	<a href="http://cocoapods.org/pods/TPPDF">
		<img src="https://img.shields.io/cocoapods/l/TPPDF.svg?style=flat-square" alt="License"/>
	</a>
</p>

<p align="center">
	<a href="https://travis-ci.org/techprimate/TPPDF">
		<img src="https://travis-ci.org/techprimate/TPPDF.svg?branch=master&style=flat-square" alt="Travis">
	</a>
        <a href="https://www.codacy.com/gh/techprimate/TPPDF/dashboard">
            <img src="https://app.codacy.com/project/badge/Grade/1af1a59fe93f49ae942732e4d526067a"/>
	</a>
	<a href="https://codebeat.co/projects/github-com-techprimate-tppdf-master">
		<img src="https://codebeat.co/badges/ea2a8d79-a50c-43ea-a05a-2ac57baf84de" alt="codebeat">
	</a>
	<a href="https://codecov.io/gh/techprimate/TPPDF">
		<img src="https://img.shields.io/codecov/c/github/techprimate/TPPDF.svg?style=flat-square" alt="codecov">
	</a>
</p>

<p align="center">
	<b>
	TPPDF is a fast PDF builder for iOS using simple commands to create advanced documents!
	</b>
</p>

<p align="center">
    <sub>Created and maintained by <a href="https://github.com/philprime">Philip Niedertscheider</a> and all the amazing <a href="https://github.com/techprimate/TPPDF/graphs/contributors">contributors</a>.</sub>
</p>

<p align="center">
    <a href="#whats-new">What's new?</a>
  • <a href="#features">Features</a>
  • <a href="#communication">Communication</a>
  • <a href="#example">Example</a>
  • <a href="https://github.com/techprimate/TPPDF/blob/master/Documentation/Usage.md"><strong>Usage</strong></a>
  • <a href="#installation">Installation</a>
  • <a href="#credits">Credits</a>
  • <a href="#license">License</a>
</p>

**Attention:**

TPPDF is an Open Source side-project of [techprimate](https://techprimate.com/).
As we are currently working on multiple other projects, we only have limited time for fixing bugs and enhancing TPPDF.

That's why any issue reporting and especially **Pull Requests** are very welcome!

If you need professional support for your company, you can reach out to [@philprimes](https://twitter.com/philprimes) on Twitter or on our website [techprimate.com](https://techprimate.com/contact)!
This is mainly for custom or high-priority requests, therefore we won't publish a consulting pricing for now.

For everything else, please see [Communication](#communication) and [this message](https://github.com/techprimate/TPPDF/issues/250). Thank you!

## What's new?

TPPDF 2.0 brings a lot of new features and small tweaks. Here are some of the biggest ones:

- [x] Swift Package Manager Support
- [x] Table with cell merging
- [x] Table cell content wraps on page breaks
- [x] Hyperlinks in attributed strings
- [x] Native progress tracking using `Foundation.Progress`
- [x] Instance-based generators, so you can generate multiple documents at the same time

## Features

- [x] Page header and footer
- [x] Dynamic content layout with page alignment
- [x] Support for tables and cell alignment
- [x] Attributed strings
- [x] Custom spacing
- [x] Image support
- [x] Horizontal line separators
- [x] Custom indentation
- [x] Custom top offset (good for layered rendering)
- [x] Pagination
- [x] Image caption
- [x] Compress images
- [x] Custom image size fit
- [x] Images in the header and footer
- [x] Horizontal line separators in the header and footer
- [x] Generate PDF files directly to handle large PDF files ([Details](http://stackoverflow.com/questions/14691264/how-can-i-lower-memory-climb-when-generating-large-pdfs))
- [x] PDF metadata
- [x] Custom table styling
- [x] Multi-column sections
- [ ] [Documentation](https://techprimate.github.io/TPPDF)

## Communication

- ~~If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/tppdf). (Tag 'TPPDF')~~ Just open up another issue, it might lead to better documentation.
- If you **found a bug**, open an [issue](https://github.com/techprimate/TPPDF/issues/new?template=bug_report.md).
- If you **have a feature request**, open an [issue](https://github.com/techprimate/TPPDF/issues/new?template=feature_request.md).
- If you **want to contribute**, submit a [pull request](https://github.com/techprimate/TPPDF/compare).

## Example

To run the example project, run `pod try TPPDF`

## Installation

### Requirements

As of TPPDF 2.0 and Swift 5.2, we do not actively support older Swift versions anymore. If you still need an older Swift version, see the following table for their respective branches. Bleed development version can be found on the `develop` branch.

| Language  | Branch                                                           | Pod version | Xcode version         | iOS version |
| --------- | ---------------------------------------------------------------- | ----------- | --------------------- | ----------- |
| Swift 4.2 | [swift-4.2](https://github.com/techprimate/TPPDF/tree/swift-4.2) | >= 1.3.x    | Xcode 10.0+           | iOS 8.3+    |
| Swift 4.1 | [swift-4.1](https://github.com/techprimate/TPPDF/tree/swift-4.1) | >= 1.0.x    | Xcode 9.3             | iOS 8.3+    |
| Swift 3.0 | [swift-3.0](https://github.com/techprimate/TPPDF/tree/swift-3.0) | >= 0.2.x    | Xcode 8               | iOS 8.0+    |
| Swift 2.3 | [swift-2.3](https://github.com/techprimate/TPPDF/tree/swift-2.3) | 0.1.5       | Xcode 8, Xcode 7.3.x  | iOS 8.0+    |
| Swift 2.2 | [swift-2.2](https://github.com/techprimate/TPPDF/tree/swift-2.3) | 0.1.4       | Xcode 7.3.x           | iOS 8.0+    |


### CocoaPods

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

### Carthage

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

### Swift Package Manager

Swift Package Manager is now supported for iOS. macOS support is a requested feature and work-in-progress. 

Linux support is not available, as `UIKit` is not available on linux.

Once you have your Swift package set up, adding TPPDF as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/techprimate/TPPDF", .upToNextMajor(from: "2.0.0"))
]
```

### Manual Installation

As Xcode project configurations are getting pretty complex, it is recommended to use a dependency manager.
If you still want to add TPPDF manually, please see issue [#97](https://github.com/techprimate/TPPDF/issues/97).

## Apps using TPPDF

If you are using TPPDF in your app and want to be listed here, simply create a pull request or let me know on twitter or via github. I am always curious who is using my projects :)

[ChatHistory](https://itunes.apple.com/app/id1464880768) - by techprimate

<img src="https://raw.githubusercontent.com/techprimate/TPPDF/master/resources/apps/ChatHistory.png" alt="ChatHistory"/>

[Hikingbook](https://itunes.apple.com/app/id1067838748) - by Zheng-Xiang Ke

<img src="https://raw.githubusercontent.com/techprimate/tppdf/master/resources/apps/Hikingbook.png" alt="Hikingbook"/>

[Bug Journal](https://itunes.apple.com/us/app/bug-journal/id1232077952) - by David Johnson

<img src="https://raw.githubusercontent.com/techprimate/tppdf/master/resources/apps/Bug_Journal.png" alt="Bug Journal"/>

[Energy Tracker](https://itunes.apple.com/de/app/energy-tracker/id1193010972) - by Stefan Nebel

<img src="https://raw.githubusercontent.com/techprimate/tppdf/master/resources/apps/EnergyTracker.jpg" alt="Energy Tracker"/>

## Credits

TPPDF is created and maintained by Philip Niedertscheider, founder of [techprimate](https://www.github.com/techprimate).

<p align="center">
	<a href="https://www.techprimate.com">
		<img src="https://img.shields.io/badge/www-techprimate.com-lightgrey.svg?style=flat-square" alt="techprimate.com">
	</a>
	<a href="http://twitter.com/techprimate">
	    <img src="https://img.shields.io/badge/twitter-@techprimate-blue.svg?style=flat-square" alt="twitter">
	</a>
	<a href="https://instagram.com/techprimate">
		<img src="https://img.shields.io/badge/instagram-@techprimate-c13584.svg?style=flat-square" alt="facebook">
	</a>
	<a href="https://facebook.com/techprimate">
		<img src="https://img.shields.io/badge/facebook-@techprimate-blue.svg?style=flat-square" alt="facebook">
	</a>
</p>


### Contributors

Please consider backing this project by using the following **GitHub Sponsor** button.

We want to thank all [contributors](https://github.com/techprimate/TPPDF/graphs/contributors) for their effort!

## License

TPPDF is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
