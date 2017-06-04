# TPPDF

[![CI Status](http://img.shields.io/travis/Techprimate/TPPDF.svg?style=flat-square)](https://travis-ci.org/Techprimate/TPPDF.svg?branch=master)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat-square)](https://developer.apple.com/swift/)
[![Cocoapods](https://img.shields.io/cocoapods/v/TPPDF.svg?style=flat-square)](https://img.shields.io/cocoapods/v/Alamofire.svg)
[![Carthage](https://img.shields.io/badge/Carthage-compatible-blue.svg?style=flat-square)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/TPPDF.svg?style=flat-square)](http://cocoapods.org/pods/TPPDF)
[![License](https://img.shields.io/cocoapods/l/TPPDF.svg?style=flat-square)](http://cocoapods.org/pods/TPPDF)
[![Documentation](https://img.shields.io/cocoapods/metrics/doc-percent/TPPDF.svg?style=flat-square)]()
[![Downloads](https://img.shields.io/cocoapods/dt/TPPDF.svg?style=flat-square)](http://cocoapods.org/pods/TPPDF)

[![Website](https://img.shields.io/badge/www-techprimate.com-blue.svg?style=flat-square)](http://www.techprimate.com)
[![Twitter](https://img.shields.io/badge/twitter-@Techprimate-blue.svg?style=flat-square)](http://twitter.com/techprimate)
[![Facebook](https://img.shields.io/badge/facebook-@Techprimate-blue.svg?style=flat-square)](http://facebook.com/techprimate)

TPPDF is a PDF builder for iOS, based on the [Builder](https://en.wikipedia.org/wiki/Builder_pattern) pattern using simple commands. 

- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Example](#example)
- [Usage](#usage)
- [Credits](#credits)
- [Contributors](#contributors)
- [License](#license)


## Features

- :white_check_mark: Page header and footer
- :white_check_mark: Dynamic content layout with page alignment
- :white_check_mark: Support for tables and cell alignment
- :white_check_mark: Attributed strings
- :white_check_mark: Custom spacing
- :white_check_mark: Image support
- :white_check_mark: Horizontal line separators
- :white_check_mark: Custom indentation
- :white_check_mark: Custom top offset (good for layered rendering)
- :white_check_mark: Pagination
- :white_check_mark: Image caption
- :white_check_mark: Compress images
- :white_check_mark: Custom image size fit
- :white_check_mark: Image in the header and footer
- :white_check_mark: Horizontal line separators in the header and footer
- :white_check_mark: Generate PDF files directly to handle large PDF files ([Details](http://stackoverflow.com/questions/14691264/how-can-i-lower-memory-climb-when-generating-large-pdfs))
- :white_check_mark: PDF metadata
- :white_check_mark: Custom table styling
- You need more features? Checkout #Contribute

## Requirements

| Language  | Branch | Pod version | Xcode version | iOS version |
| --------- | ------ | ----------- | ------------- | ----------- |
| Swift 3.0 | [master](https://github.com/techprimate/TPPDF/tree/master) | >= 0.2.x | Xcode 8 or greater| iOS 8.0+ |
| Swift 2.3 | [swift-2.3](https://github.com/techprimate/TPPDF/tree/swift-2.3) | 0.1.5 | Xcode 8, Xcode 7.3.x | iOS 8.0+ |
| Swift 2.2 | [swift-2.2](https://github.com/techprimate/TPPDF/tree/swift-2.3) | 0.1.4 | Xcode 7.3.x | iOS 8.0+ |

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/tppdf). (Tag 'TPPDF')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/tppdf).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate TPPDF into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
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
github "Techprimate/TPPDF" ~> 0.4
```

Run `carthage update` to build the framework and drag the built `Alamofire.framework` into your Xcode project

### Swift Package Manager

Swift Package Manager is not supported, as it is currently built for MacOS and Linux and therefore can't require the framework `UIKit`

### Manually

If you prefer not to use either of the aforementioned dependency managers, you can integrate TPPDF into your project manually.

#### Embedded Framework

- Open up Terminal, `cd` into your top-level project directory, and run the following command "if" your project is not initialized as a git repository:

```bash
$ git init
```

- Add TPPDF as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following command:

```bash
$ git submodule add https://github.com/Techprimate/TPPDF.git
```

- Open the new `TPPDF` folder, and drag the `TPPDF.xcodeproj` into the Project Navigator of your application's Xcode project.

    > It should appear nested underneath your application's blue project icon. Whether it is above or below all the other Xcode groups does not matter.

- Select the `TPPDF.xcodeproj` in the Project Navigator and verify the deployment target matches that of your application target.
- Next, select your application project in the Project Navigator (blue project icon) to navigate to the target configuration window and select the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "General" panel.
- Click on the `+` button under the "Embedded Binaries" section.
- You will see two different `TPPDF.xcodeproj` folders each with two different versions of the `TPPDF.framework` nested inside a `Products` folder.

    > It does not matter which `Products` folder you choose from, but it does matter whether you choose the top or bottom `TPPDF.framework`. 
    
- Select the top `TPPDF.framework` for iOS and the bottom one for OS X.

    > You can verify which one you selected by inspecting the build log for your project. The build target for `TPPDF` will be listed as either `TPPDF iOS` or `TPPDF OSX`.

- And that's it!

> The `TPPDF.framework` is automagically added as a target dependency, linked framework and embedded framework in a copy files build phase which is all you need to build on the simulator and a device.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

If you want to see a fully working example, please try the Cocoapod using `pod try TPPDF`.

TPPDF creates a PDF based on commands. When the generator starts to build the PDF file it calls one command after another, until no commands are left.

### Container

Every command is associated to a specific container. Three containers exist: Header, Content, Footer. Additionally every container has an alignment: Left, Center, Right.

When registering a command you provide the correct container - the default container is `ContentLeft`. When the PDFGenerator performs the commands, it applies the to the correct container. This way you can identify which area of the PDF gets changed.

A good example would be the following call:

```swift
let pdf = PDFGenerator(format: .a4)
pdf.addText(.footerCenter, text: "Created using TPPDF for iOS.")
```

This command adds the text *"Created using TPPDF for iOS"* to the footer of all pages.

### Pageformats

The following values can be set to format the page:

- `size`
- `margin`
- `headerMargin`
- `footerMargin`
- `headerSpace`
- `footerSpace`

All values are in dots and are rendered using 72 DPI (dots per inch), as this is the default screen DPI.

You can also used the predefined formats. For details please refer to the source file [PageFormat.swift](https://github.com/Techprimate/TPPDF/blob/master/Source/PageFormat.swift)

If you need your page in landscape format, use the `landscapeSize` variable.

### Header & Footer

If you want to add a text to the header or footer you simply need to choose the correct container.

If you want to render an image in one of these containers, it will use the square size `headerImageHeight`.

But there are some limitations:

- Only one line. If you want multiple lines, add multiple commands

### Pagination

To enable pagination, set a `Container` on the variable `paginationContainer`.

### Image Quality

To reduce the amount of data and the resulting file size, you can reduce the image quality by setting a value between 0 and 1 on the variable `imageQuality`.

### PDF Info

Configure PDF metadata, including `title`, `author`, `subject`, `keywords`, `owner password`, `user password`, `allows printing`, and `allows copying`.

### Commands

The following commands are the ones available to you for creating your document. Most of these take a container as a parameter, defaulting to page content with left alignment. For the sake of readability, there is only a container in the example of `addText(...)`.

#### Lines

- `addLineSeparator(container, style)`

Draws a horizontal line using the given line style in the given container.

```swift
pdf.addLineSeparator(thickness: 0.1, style: LineStyle(type: .dashed, color: UIColor.green, width: 1.0))
```

#### Text

- `addText(container, text, lineSpacing)`

Draws a text in the given container. It creates a attributed string and sets the linespacing.

```swift
pdf.addText(.ContentCenter, text: "Created using TPPDF for iOS.", lineSpacing: 5)
```

- `addAttributedText(container, attributedText)`

Draws a NSAttributedString in the given container.

```swift
let title = NSMutableAttributedString(string: "Awesome attributed title!", attributes: [
	NSFontAttributeName : UIFont.systemFontOfSize(28.0),
	NSForegroundColorAttributeName : UIColor(red: 219.0 / 255.0, green: 100.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
])
pdf.addAttributedText(text: title)
```

- `setFont(container, font)`

Sets the font of a container. This font will be used in the next commands in the given container, if there is not a different font specified.

```swift
pdf.setFont(UIFont.systemFont(ofSize: 20.0))
```

- `resetFont(container)`

This resets the font to the default font, which is `UIFont.systemFont(ofSize: UIFont.systemFontSize)`

```swift
pdf.resetFont(.contentLeft)
```

#### Image

- `addImage(container, image, size, caption, sizeFit)`

Draws an image in the given container. If the given size is not zero size, it will draw it using that size, proportionally scaling. The size of an image is scaled according to sizeFit. If the height of an image and its caption is beyond the page bounds, then a new page is created. The caption is an attributed string and can be styled (refer to `addAttributedText(...)` for an example).

```swift
pdf.addImage(image: UIImage(named: "Image.jpg")!)
```

- `addImagesInRow(container, images, captions, spacing)`

Draws images with captions in the row using the given spacing in the given container.

```swift
pdf.addImagesInRow(images: [UIImage(named: "image.jpg")!, UIImage(named: "PortraitImage.jpg")!], captions: [NSAttributedString(string: "Caption 1"), NSAttributedString(string: "Caption 2")])
```

#### Table

- `addTable(container, data, alignment, relativeColumnWidth, padding, margin, style)`

Draws a table in the given container.

The parameter data is a two-dimensional String array

```swift
let data: [[String]] = [
	["Rating",     "4.5 / 5",  "Prep\nTime:",   "14 Hours"    ],
	["Portions:",   "14",       "Cook\nTime:",   "16 Minutes" ]
]
```

The parameter alignment is a two-dimensional array with `TableCellAlignment` values.

```swift
let alignments: [[TableCellAlignment]] = [
	[.Left, .Center, .Left, .Center],
	[.Left, .Center, .Left, .Center]
]
```

The parameter `relativeColumnWidth` is an array of CGFloat smaller or equal than 1.0
These are relative widths in percentage to the full page content width (= page width - 2 * page margin). It defines the width of each column.

```swift
let widths: [CGFloat] = [
	0.3, 0.2, 0.3, 0.2
]
```

The data array and the alignments array must contain the equal amount of items. The widths array must have the same amount as the data array columns has.

Additional parameters are cell margin and cell padding. Margin is the spacing between each cell or between the cell and the table bounds. Padding is the spacing between the content of the cell to the cell bounds.

This works the same way as HTML/CSS margin and padding works. Checkout w3schools.com [margin](http://www.w3schools.com/css/css_margin.asp) and [padding](http://www.w3schools.com/css/css_padding.asp)

Table styling is done with a `TableStyle` object. `TableStyleDefaults` contain a couple of predefined table styles, which can be modified.
A table style consists out of five different styles, for the row header, column header, footer, content and for alternating rows. It is also possible to set custom cell styling using the method `setCellStyle(row, column, style)`.

Cell styling includes background fill color, text color, font and the line style for each border.

Line styling includes line color, line width and line type, which can be either non, full, dashed or dotted.

```swift
let tableStyle = TableStyleDefaults.simple

tableStyle.setCellStyle(row: 2, column: 3, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
tableStyle.setCellStyle(row: 20, column: 1, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))

pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
```

#### Container

- `addSpace(container, space)`

Adds the given value to the content height, resulting in a space between the previous and the next command element.

```swift
pdf.addSpace(space: 12.0)
```

- `setIndentation(container, points)`

If you need to indent your content you can simply call this method.


```swift
pdf.setIndentation(indent: 50.0)
```

Now add more commands which are indented.
If you need to reset the indentation simply call the function with `0.0` as parameter


```swift
pdf.setIndentation(indent: 0.0)
```

- `setAbsoluteOffset(container, points)`

If you do not want to add a space between two elements, you can also set a absolut offset form the top border.

One possible use case are layered PDF files.
Simply call `pdf.setOffset(offset: 0.0)` and you can add content which is placed on top of the previously set content.

```swift
pdf.setOffset(offset: 250.0)
```

- `createNewPage()`

Create a new page.

```swift
pdf.createNewPage()
```

## Contribute

You need more commands?
Just fork the project, implement the following and create a pull request!

To implement a new command you need to edit the following places. As an example we implement the command `SetFont`:

- Add `SetFont` to the enum `Command` in [Command.swift](https://github.com/Techprimate/TPPDF/blob/master/TPPDF/Classes/Command.swift)

```swift
enum Command {
...
case SetFont(font: UIFont)
}
```

- Add `SetFont` to the switch statement in the method `renderCommand` in [PDFGenerator.swift](https://github.com/Techprimate/TPPDF/blob/master/TPPDF/Classes/PDFGenerator.swift). In this case you do not need to create another `draw...` method but in other cases you might have to create a new private drawing method, handling different containers.

```swift
switch command {
	...
   case let .SetFont(font):
  		self.font = font // Currently there is one font variable used for draw calls. If you change it, all future commands will use the new font.
  		break
   }
}
```

- Add a public method `setFont` which adds a command to the command chain. 

```swift
public func setFont(container: Container = Container.ContentLeft, font: UIFont = UIFont.systemFontOfSize(14)) {
	commands += [(container, .SetFont(font: font))]
}
```

**If you add default values, then you need to do it in this method!**

### Aspects to consider!!

The previous example does not handle different `Containers`. The correct way of doing this, would be three instance variables of type `UIFont`. One for the header, one for the content and one for the footer.
Then, when calling the command, it changes the correct font variable, depending on the Container provided.

## Apps using TPPDF

If you are using TPPDF in your app and want to be listed here, simply create a pull request or let me know on twitter or via github. I am always curious who is using my projects :)

[Hikingbook](https://itunes.apple.com/app/id1067838748) - by Zheng-Xiang Ke

![Hikingbook](apps/Hikingbook.png)

[Bug Journal](https://itunes.apple.com/us/app/bug-journal/id1232077952) - by David Johnson

![Bug Journal](apps/Bug Journal.jpg)

[Mama's Cookbook (future release)](https://itunes.apple.com/us/app/mamas-cookbook/id1019090528) - by Philip Niedertscheider

![Mama's Cookbook](apps/MCB.png)


## Credits

TPPDF is created by Philip Niedertscheider.

Special thanks goes to **Nutchaphon Rewik** for his project [SimplePDF](https://github.com/nRewik/SimplePDF) for the inspiration and code base.

## Contributors

- Philip Niedertscheider, [techprimate](https://www.github.com/techprimate)
- Zheng-Xiang Ke, [kf99916](https://www.github.com/kf99916)

## License

TPPDF is available under the MIT license. See the LICENSE file for more info.
