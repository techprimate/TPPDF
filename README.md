# TPPDF

[![CI Status](http://img.shields.io/travis/Philip Niedertscheider/TPPDF.svg?style=flat)](https://travis-ci.org/Techprimate/TPPDF.svg?branch=master)
[![Version](https://img.shields.io/cocoapods/v/TPPDF.svg?style=flat)](http://cocoapods.org/pods/TPPDF)
[![License](https://img.shields.io/cocoapods/l/TPPDF.svg?style=flat)](http://cocoapods.org/pods/TPPDF)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg)](https://developer.apple.com/swift/)
[![Platform](https://img.shields.io/cocoapods/p/TPPDF.svg?style=flat)](http://cocoapods.org/pods/TPPDF)
[![Twitter](https://img.shields.io/badge/twitter-@Techprimate-blue.svg?style=flat)](http://twitter.com/techprimate)
[![Website](https://img.shields.io/badge/www-techprimate.com-blue.svg?style=flat)](http://www.techprimate.com)

TPPDF is a PDF builder for iOS, based on the [Builder](https://en.wikipedia.org/wiki/Builder_pattern) pattern using simple commands. 

## Features

- [x] Page header and footer
- [x] Dynamic content layout with page alignment
- [x] Support for tables and cell alignment
- [x] Attributed strings
- [x] Custom spacing
- [x] Image support
- [x] Horizontal line separators
- [ ] Tab insets
- You need more features? Checkout #Contribute

## Apps using TPPDF

If you are using TPPDF in your app and want to be listed here, simply create a pull request or let me know on twitter or via github. I am always curious who is using my projects :)

[Mama's Cookbook (future release)](https://itunes.apple.com/us/app/mamas-cookbook/id1019090528) - by Philip Niedertscheider

![Mama's Cookbook](apps/MCB.png)


## Requirements

+ iOS 8.0+
+ Xcode 7.3+

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/tppdf). (Tag 'TPPDF')
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/questions/tagged/tppdf).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate TPPDF into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
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

Not supported yet. Please check [Issue #2](https://github.com/Techprimate/TPPDF/issues/2)

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

---

## Usage

If you want to see a fully working example, please try the Cocoapod using `pod try TPPDF`.

TPPDF creates a PDF based on commands. When the generator starts to build the PDF file it calls one command after another, until no commands are left.

Currently the following commands exist:

- AddText
- AddAttributedText
- AddImage
- AddSpace
- AddLineSeparator
- AddTable

### Container

Every command is associated to a specific container. Three containers exist: Header, Content, Footer. Additionally every container has an alignment: Left, Center, Right.

When registering a command you provide the correct container - the default container is `ContentLeft`. When the PDFGenerator performs the commands, it applies the to the correct container. This way you can identify which area of the PDF gets changed.

A good example would be the following call:

```swift
let pdf = PDFGenerator(format: .A4)
pdf.addText(.FooterCenter, text: "Created using TPPDF for iOS.")
```

This command adds the text *"Created using TPPDF for iOS"* to the footer of all pages.

### Pageformat

You can set page sizes, header margin, footer margin, page margin, header spacing, footer spacing by hand, but you can also used the predefined **PageFormats**

| Format | Page Size (width, height) | Page Margin | Header Margin | Footer Margin | Header Space | Footer Space |
| --- | --- | --- | --- | --- | --- | --- |
| US Letter | 612, 762 | 36 | 30 | 30 | 15 | 15|
| A4 | 592, 842 | 60 | 30 | 30 | 15 | 15 |

### AddText(container, text, linespacing)

Draws a text in the given container. It creates a attributed string and sets the linespacing

**Example:**

```swift
pdf.addText(.ContentCenter, text: "Created using TPPDF for iOS.")
```

### AddAttributedText(container, attributedText)

Draws a NSAttributedString in the given container.

**Example:**

```swift
let title = NSMutableAttributedString(string: "Awesome attributed title!", attributes: [
	NSFontAttributeName : UIFont.systemFontOfSize(28.0),
	NSForegroundColorAttributeName : UIColor(red: 219.0 / 255.0, green: 100.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
])
pdf.addAttributedText(text: title)
```

### AddImage(image, size)

Draws an image in the given container. If the given size is not zero size, it will draw it using that size, proportionally scaling. The size of an image is limited by the page bounds.

**Example:**

```swift
pdf.addImage(image: UIImage(named: "Image.jpg")!)
```

### AddSpace(container, space)

Adds the given value to the content height, resulting in a space between the previous and the next command element.

**Example:**

```swift
pdf.addSpace(space: 12.0)
```

### AddLineSeparator(container, thickness, color)

Draws a horizontal line using the given line thickness and color in the given container.

**Example:**

```swift
pdf.addLineSeparator(thickness: 0.1, color: UIColor.lightGrayColor())
```

### AddTable(container, data, alignment, relativeColumnWidth, padding, margin, textColor, lineColor, lineWidth, drawCellBounds)

Draws a table in the given container.

The parameter data is a two-dimensional String array

```swift
let data: [[String]] = [
	["Rating",     "4.5 / 5",  "Prep\nTime:",   "14 Hours"      ],
	["Portions:",   "14",       "Cook\nTime:",   "16 Minutes",   ]
]
```

The parameter alignment is a two-dimensional array with `TableCellAlignment` values.

```swift
let alignments: [[TableCellAlignment]] = [
	[.Left, .Center, .Left, .Center],
	[.Left, .Center, .Left, .Center]
]
```

The parameter relativeColumnWidth is an array of CGFloat smaller or equal than 1.0
These are relative widths in percentage to the full page content width (= page width - 2 * page margin). It defines the width of each column.

```swift
let widths: [CGFloat] = [
	0.3, 0.2, 0.3, 0.2
]
```

The data array and the alignments array must contain the equal amount of items. The widths array must have the same amount as the data array columns has.

Additional parameters are cell margin and cell padding. Margin is the spacing between each cell or between the cell and the table bounds. Padding is the spacing between the content of the cell to the cell bounds.

This works the same way as HTML/CSS margin and padding works. Checkout w3schools.com [margin](http://www.w3schools.com/css/css_margin.asp) and [padding](http://www.w3schools.com/css/css_padding.asp)

Next to the text color, you can also set the line color and the line width, whose use are obvious by their name.

The parameter drawCellBounds is a Boolean parameter, deciding if the cell bounds are drawn. 
The cell bounds are not the row/column grid of the table, but the lines between cell margin and cell padding. [w3Schools.com explains it](http://www.w3schools.com/css/css_boxmodel.asp)

**Example:**

```swift
pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 5, margin: 5, textColor: UIColor.blackColor(), lineColor: UIColor.darkGrayColor(), lineWidth: 1.5, drawCellBounds: false)
```        


### SetIndentation(container, points)

If you need to indent your content you can simply call this method.

```swift
pdf.setIndentation(indent: 50.0)
```

Now add more commands which are indented.
If you need to reset the indentation simply call the function with `0.0` as parameter

```swift
pdf.setIndentation(indent: 0.0)
```

### SetOffset(container, points)

If you do not want to add a space between two elements, you can also set a absolut offset form the top border.

```swift
pdf.setOffset(offset: 250.0)
```

One possible use case are layered PDF files.
Simply call `pdf.setOffset(offset: 0.0)` and you can add content which is placed on top of the previously set content.

### Header & Footer

If you want to add a text to the header or footer you simply need to choose the correct container.

But there are some limitations:

- Only one line. If you want multiple lines, add multiple commands
- Currently only `AddText` and `AddAttributedText` are supported as header or footer command


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

## Credits

TPPDF is owned and created by Philip Niedertscheider. 

Special thanks goes to **Nutchaphon Rewik** for his project [SimplePDF](https://github.com/nRewik/SimplePDF) for the inspiration and code base, and to [TPPDF](https://github.com/nRewik/TPPDF) for their great [README.md](https://github.com/TPPDF/TPPDF/blob/master/README.md) which was used as a template to create this file.

## Author

Philip Niedertscheider, philip.niedertscheider@techprimate.com

## License

TPPDF is available under the MIT license. See the LICENSE file for more info.
