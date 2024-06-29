<p align="center">
	<img src="https://raw.githubusercontent.com/techprimate/tppdf/main/resources/header.png" alt="TPPDF">
</p>

<p align="center">
	<b>
	TPPDF is a fast PDF builder for iOS & macOS using simple commands to create advanced documents!
	</b>
</p>

<div align="center">
  <a href="https://swiftpackageindex.com/techprimate/TPPDF">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftechprimate%2FTPPDF%2Fbadge%3Ftype%3Dswift-versions" alt="Supported Swift Versions">
  </a>
  <a href="https://swiftpackageindex.com/techprimate/TPPDF">
    <img src="https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Ftechprimate%2FTPPDF%2Fbadge%3Ftype%3Dplatforms" alt="Supported Platforms">
  </a>
	<img src="https://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat-square" alt="License"/>
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
  • <a href="#getting-started">Getting Started</a>
  • <a href="#communication">Communication</a>
  • <a href="https://github.com/techprimate/TPPDF/blob/main/Documentation/Usage.md"><strong>Usage</strong></a>
  • <a href="https://github.com/techprimate/TPPDF/blob/main/Documentation/Installation.md">Installation</a>
  • <a href="#credits">Credits</a>
  • <a href="https://github.com/techprimate/TPPDF/blob/master/LICENSE">License</a>
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

## Getting Started

Building a PDF document is very easy:

First, you create a document with a paperformat...

```swift
let document = PDFDocument(format: .a4)
```

...then you add your information to a container...

```swift
document.add(.contentCenter, text: "Create PDF documents easily.")
```

...then you render the document...

```swift
let generator = PDFGenerator(document: document)
let url  = try generator.generateURL(filename: "Example.pdf")
```

**...done!**

If you need more details, checkout [Usage](https://github.com/techprimate/TPPDF/blob/main/Documentation/Usage.md).

## Communication

**Attention:**

TPPDF is an Open Source side-project of [techprimate](https://techprimate.com/).
As we are currently working on multiple other projects, we only have limited time for fixing bugs and enhancing TPPDF.

That's why any issue reporting and especially **Pull Requests** are very welcome!

If you need professional support for your company, you can reach out to [@philprimes](https://twitter.com/philprimes) on Twitter or on our website [techprimate.com](https://techprimate.com/contact)!
This is mainly for custom or high-priority requests, therefore we won't publish a consulting pricing for now.

For everything else, please see [Communication](#communication) and [this message](https://github.com/techprimate/TPPDF/issues/250). Thank you!

- If you **need help**, open an [issue](https://github.com/techprimate/TPPDF/issues/new?template=bug_report.md).
- If you **found a bug**, open an [issue](https://github.com/techprimate/TPPDF/issues/new?template=bug_report.md).
- If you **have a feature request**, open an [issue](https://github.com/techprimate/TPPDF/issues/new?template=feature_request.md).
- If you **want to contribute**, submit a [pull request](https://github.com/techprimate/TPPDF/compare).

## Example

Take a look at the [Getting Started Guide](https://github.com/techprimate/TPPDF/blob/main/Documentation/Usage.md#getting-started) or checkout the Examples (using of one of the following):

- Clone the repository and open the `Examples.xcworkspace`
- Run the `Example macOS (SPM)` or `Example macOS (iOS)`

## Apps using TPPDF

If you are using TPPDF in your app and want to be listed here, simply create a pull request or let us know on Twitter or via GitHub. We are always curious to see, who is using our project :)

<table>
  <tr>
    <td align="center">
      <a href="https://itunes.apple.com/app/id1495886665">
        <img src="https://raw.githubusercontent.com/techprimate/TPPDF/main/resources/apps/BurnoutCoach.png" alt="Burnout Coach"/>
      </a>
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/app/id1464880768">
        <img src="https://raw.githubusercontent.com/techprimate/TPPDF/main/resources/apps/ChatHistory.png" alt="ChatHistory"/>
      </a>
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/app/id1464880768">
        <img src="https://raw.githubusercontent.com/techprimate/tppdf/main/resources/apps/Hikingbook.png" alt="Hikingbook"/>
      </a>
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/us/app/bug-journal/id1232077952">
        <img src="https://raw.githubusercontent.com/techprimate/tppdf/main/resources/apps/Bug_Journal.png" alt="Bug Journal"/>
      </a>
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/de/app/energy-tracker/id1193010972">
        <img src="https://raw.githubusercontent.com/techprimate/tppdf/main/resources/apps/EnergyTracker.jpg" alt="EnergyTracker"/>
      </a>
    </td>
  	<td align="center">
      <a href="https://apps.apple.com/us/app/lyrcs/id1599888045">
        <img src="https://raw.githubusercontent.com/techprimate/tppdf/main/resources/apps/Lyrcs.svg" alt="Lyrcs" height=120 />
      </a>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://itunes.apple.com/app/id1464880768">Burnout Coach</strong></a><br>
      by Stéphane Mégy
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/app/id1464880768">ChatHistory</a><br>
      by techprimate
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/app/id1067838748">Hikingbook</a><br>
      by Zheng-Xiang Ke
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/us/app/bug-journal/id1232077952">Bug Journal</a><br>
      by David Johnson
    </td>
    <td align="center">
      <a href="https://itunes.apple.com/de/app/energy-tracker/id1193010972">EnergyTracker</a><br>
      by Stefan Nebel
    </td>
    <td align="center">
      <a href="https://apps.apple.com/us/app/lyrcs/id1599888045">Lyrcs</a><br>
      by ptrkstr
    </td>
  </tr>
</table>

## Credits

TPPDF is created and maintained by Philip Niedertscheider, co-founder of [techprimate](https://www.github.com/techprimate).

<p align="center">
	<a href="https://www.techprimate.com">
		<img src="https://img.shields.io/badge/www-techprimate.com-lightgrey.svg?style=flat-square" alt="techprimate.com">
	</a>
	<a href="http://twitter.com/techprimate">
	    <img src="https://img.shields.io/badge/twitter-@techprimate-blue.svg?style=flat-square" alt="twitter">
	</a>
</p>

### Contributors

Please consider backing this project by using the following **GitHub Sponsor** button.

We want to thank all [contributors](https://github.com/techprimate/TPPDF/graphs/contributors) for their effort!
