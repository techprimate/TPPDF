<p align="center">
	<img src="https://raw.githubusercontent.com/techprimate/tppdf/master/resources/header.png" alt="TPPDF">
</p>

<p align="center">
	<b>
	TPPDF is a fast PDF builder for iOS & macOS using simple commands to create advanced documents!
	</b>
</p>

<div align="center">
	<img src="https://img.shields.io/badge/language-Swift-orange.svg?style=flat-square" alt="Swift"/>
	<img src="https://img.shields.io/badge/platforms-iOS|macOS-lightgrey.svg?style=flat-square" alt="iOS|macOS"/>
	<img src="https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square" alt="License"/>
</div>

<div align="center">
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
</div>

<div align="center">
	<img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat-square" alt="Swift Package Manager"/>
	<img src="https://img.shields.io/cocoapods/v/TPPDF.svg?style=flat-square" alt="Cocoapods"/>
	<img src="https://img.shields.io/badge/Carthage-compatible-blue.svg?style=flat-square" alt="Carthage"/>
</div>

<p align="center">
    <sub>Created and maintained by <a href="https://github.com/philprime">Philip Niedertscheider</a> and all the amazing <a href="https://github.com/techprimate/TPPDF/graphs/contributors">contributors</a>.</sub>
</p>

<p align="center">
  <a href="#features">Features</a>
  • <a href="#communication">Communication</a>
  • <a href="#getting-started">Getting Started</a>
  • <a href="https://github.com/techprimate/TPPDF/blob/master/Documentation/Usage.md"><strong>Usage</strong></a>
  • <a href="https://github.com/techprimate/TPPDF/blob/master/Documentation/Installation.md">Installation</a>
  • <a href="#credits">Credits</a>
  • <a href="#license">License</a>
</p>

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
- [x] Swift Package Manager Support
- [x] Tables with cell merging & automatic page breaking
- [x] Hyperlinks in text
- [x] Native progress tracking using `Foundation.Progress`
- [ ] [Documentation](https://techprimate.github.io/TPPDF)

## Getting Started

Building a PDF document is very easy:

First, you create a document with a paperformat...

```swift
let document = PDFDocument(format: .a4)
```

...then you add your information to a container...

```swift
document.addText(.contentCenter, text: "Create PDF documents easily.")
```

...then you render the document...
 
```swift 
let generator = PDFGenerator(document: document)
let url  = try generator.generateURL(document: document, filename: "Example.pdf")
```

**...done!**

If you need more details, checkout [Usage](https://github.com/techprimate/TPPDF/blob/master/Documentation/Usage.md).

## Communication

**Attention:**

TPPDF is an Open Source side-project of [techprimate](https://techprimate.com/).
As we are currently working on multiple other projects, we only have limited time for fixing bugs and enhancing TPPDF.

That's why any issue reporting and especially **Pull Requests** are very welcome!

If you need professional support for your company, you can reach out to [@philprimes](https://twitter.com/philprimes) on Twitter or on our website [techprimate.com](https://techprimate.com/contact)!
This is mainly for custom or high-priority requests, therefore we won't publish a consulting pricing for now.

For everything else, please see [Communication](#communication) and [this message](https://github.com/techprimate/TPPDF/issues/250). Thank you!

- ~~If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/tppdf). (Tag 'TPPDF')~~ Just open up another issue, it might lead to better documentation.
- If you **found a bug**, open an [issue](https://github.com/techprimate/TPPDF/issues/new?template=bug_report.md).
- If you **have a feature request**, open an [issue](https://github.com/techprimate/TPPDF/issues/new?template=feature_request.md).
- If you **want to contribute**, submit a [pull request](https://github.com/techprimate/TPPDF/compare).

## Example

Take a look at the [Getting Started Guide](https://github.com/techprimate/TPPDF/blob/master/Documentation/Usage.md) or checkout the Examples (using of one of the following):

- Clone the repository and look at the Example folders
- Run `pod try TPPDF`

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
