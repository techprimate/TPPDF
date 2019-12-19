//
//  ViewController.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 11/08/16.
//

import UIKit
import TPPDF

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        generateTestPDF()
        generateExamplePDF()
    }

    func generateTestPDF() {
        let document1 = PDFDocument(format: .a4)
        for i in 0..<100 {
            document1.add(text: "DOC 1 - \(i)")
        }

        let document2 = PDFDocument(format: .a5)
        for i in 0..<100 {
            document2.add(text: "DOC 2 - \(i)")
        }

        do {
            let startTime = CFAbsoluteTimeGetCurrent() * 1000
            // Generate PDF file and save it in a temporary file. This returns the file URL to the temporary file
            let url = try PDFGenerator.generateURL(documents: [document1, document2], filename: "Example.pdf", progress: { (docIndex: Int, progressValue: CGFloat, totalProgressValue: CGFloat) in
                print("doc:", docIndex, "progress:", progressValue, "total:", totalProgressValue)
            })
            let endTime = CFAbsoluteTimeGetCurrent() * 1000
            print("Duration: \(floor(endTime - startTime)) ms")

            // Load PDF into a webview from the temporary file
            (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
        } catch {
            print("Error while generating PDF: " + error.localizedDescription)
        }
    }
    
    func generateExamplePDF() {
        /* ---- Execution Metrics ---- */
        var startTime = CFAbsoluteTimeGetCurrent()
        /* ---- Execution Metrics ---- */
        
        let document = PDFDocument(format: .a4)
        
        // Set document meta data
        document.info.title = "TPPDF Example"
        document.info.subject = "Building a PDF easily"
        document.info.ownerPassword = "Password123"
        
        // Set spacing of header and footer
        document.layout.space.header = 5
        document.layout.space.footer = 5

        // Add custom pagination, starting at page 1 and excluding page 3
        document.pagination = PDFPagination(container: .footerRight, style: PDFPaginationStyle.customClosure { (page, total) -> String in
            return "\(page) / \(total)"
            }, range: (1, 20), hiddenPages: [3, 7], textAttributes: [
                .font: UIFont.boldSystemFont(ofSize: 15.0),
                .foregroundColor: UIColor.green
            ])

        // Define doccument wide styles
        let titleStyle = document.add(style: PDFTextStyle(name: "Title",
                                                          font: UIFont.boldSystemFont(ofSize: 50.0),
                                                          color: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)))
        let headingStyle1 = document.add(style: PDFTextStyle(name: "Heading 1",
                                                             font: UIFont.systemFont(ofSize: 15),
                                                             color: UIColor.black))
        let headingStyle2 = document.add(style: PDFTextStyle(name: "Heading 2",
                                                             font: UIFont.systemFont(ofSize: 20),
                                                             color: UIColor.red))

        // Add an image and scale it down. Image will not be drawn scaled, instead it will be scaled down and compressed to save file size.
        // Also you can define a quality in percent between 0.0 and 1.0 which is the JPEG compression quality. This is applied if the option `compress` is set.
        // Use `none` for better and crisp quality of image. You don't need to set the image quality if you set this option.
        // let logoImage = PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 150, height: 150), quality: 0.9, options: [.resize, .compress])
        let logoImage = PDFImage(image: UIImage(named: "Icon.png")!,
                                 size: CGSize(width: 150, height: 150),
                                 options: [.rounded],
                                 cornerRadius: 25)
        document.add(.contentCenter, image: logoImage)

        // Add a string using the title style
        document.add(.contentCenter, textObject: PDFSimpleText(text: "TPPDF", style: titleStyle))

        // Add some spacing below title
        document.add(space: 15.0)

        // Create and add a subtitle as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "Create PDF documents easily", attributes: [
            .font: UIFont.systemFont(ofSize: 18.0),
            .foregroundColor: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
            ])
        document.add(.contentCenter, attributedText: title)

        // Add some spacing below subtitle
        document.add(space: 10.0)

        // Create a automatic table of content based on used styles
        document.add(text: "Table of Contents")
        document.add(space: 5.0)

        // Add a table of content, the content will be calculated based on the usages of the styles
        document.add(tableOfContent: PDFTableOfContent(styles: [
            headingStyle1,
            headingStyle2,
            ], symbol: .none))

        // Add headline with extra spacing
        document.add(space: 10)
        document.add(textObject: PDFSimpleText(text: "1. Introduction", style: headingStyle1))
        document.add(space: 10)

        // Set font for text
        document.set(font: UIFont.systemFont(ofSize: 13.0))

        // Add long simple text. This will automatically word wrap if content width is not enough.
        document.add(text: "Generating a PDF file using TPPDF feels like a breeze. You can easily setup a document using many convenient commands, and the framework will calculate and render the PDF file at top speed. A small document with 2 pages can be generated in less than 100 milliseconds. A larger document with more complex content, like tables, is still computed in less than a second.")
        document.add(space: 10)

        document.add(text: "TPPDF includes many different features:")
        document.add(space: 10)

        // Simple bullet point list
        
        let featureList = PDFList(indentations: [
            (pre: 10.0, past: 20.0),
            (pre: 20.0, past: 20.0),
            (pre: 40.0, past: 20.0)
        ])
        
        featureList.addItem(PDFListItem(symbol: .dot)
            .addItems([
                PDFListItem(content: "Simple text drawing"),
                PDFListItem(content: "Advanced text drawing using AttributedString"),
                PDFListItem(content: "Multi-layer rendering by simply setting the offset"),
                PDFListItem(content: "Fully calculated content sizing"),
                PDFListItem(content: "Automatic page wrapping"),
                PDFListItem(content: "Customizable pagination"),
                PDFListItem(content: "Fully editable header and footer"),
                PDFListItem(content: "Simple image positioning and rendering"),
                PDFListItem(content: "Image captions")
                ]))
        document.add(list: featureList)

        // Create a line separator

        document.add(space: 10)
        document.addLineSeparator(style: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5))

        // Insert page break

        document.add(space: 10)
        document.add(textObject: PDFSimpleText(text: "2. Images", style: headingStyle1))
        document.add(space: 10)

        // Create attributes for captions
        let captionAttributes: [NSAttributedString.Key: AnyObject] = [
            .font: UIFont.italicSystemFont(ofSize: 15.0),
            .paragraphStyle: { () -> NSMutableParagraphStyle in
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }(),
            .foregroundColor: UIColor(red: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0),
        ]

        // Create an image collage with captions

        let images = [
            [
                PDFImage(image: UIImage(named: "Image-1.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "In this picture you can see a beautiful waterfall!",
                                                                             attributes: captionAttributes))),
                PDFImage(image: UIImage(named: "Image-2.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Forrest",
                                                                             attributes: captionAttributes))),
                PDFImage(image: UIImage(named: "Image-3.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Fireworks",
                                                                             attributes: captionAttributes)))
                ],
            [
                PDFImage(image: UIImage(named: "Image-3.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Fireworks",
                                                                             attributes: captionAttributes))),
                PDFImage(image: UIImage(named: "Image-4.jpg")!,
                         caption: PDFAttributedText(text: NSAttributedString(string: "Field",
                                                                             attributes: captionAttributes))),
                ]
        ]

        // Add first row of images

        document.add(imagesInRow: images[0], spacing: 10)

        // Add spacing between image rows

        document.add(space: 10)

        // Add second row of images

        document.add(imagesInRow: images[1], spacing: 10)
        
        // Add many rows of images to test break a page
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)
        document.add(imagesInRow: images[1], spacing: 10)

        // Finish image collage with another line separator

        document.add(space: 10)
        document.addLineSeparator(style: PDFLineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        document.add(space: 10)


        document.add(space: 10)
        document.add(textObject: PDFSimpleText(text: "3. Tables", style: headingStyle1))
        document.add(space: 10)

        // Create a table
        let table = PDFTable()

        // Tables can contain Strings, Numbers, Images or nil, in case you need an empty cell. If you add a unknown content type, an error will be thrown and the rendering will stop.

        do {
            try table.generateCells(
                data:
                [
                    [nil, "Name", "Image", "Description"],
                    [1, "Waterfall", UIImage(named: "Image-1.jpg")!, "Water flowing down stones."],
                    [2, "Forrest", UIImage(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
                    [3, "Fireworks", UIImage(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
                    [4, "Fields", UIImage(named: "Image-4.jpg")!, "Crops growing big and providing food."],
                    [1, "Waterfall", UIImage(named: "Image-1.jpg")!, "Water flowing down stones."],
                    [2, "Forrest", UIImage(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
                    [3, "Fireworks", UIImage(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
                    [4, "Fields", UIImage(named: "Image-4.jpg")!, "Crops growing big and providing food."],
                    [nil, nil, nil, "Many beautiful places"]
                ],
                alignments:
                [
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                    [.center, .left, .center, .right],
                ])
        } catch PDFError.tableContentInvalid(let value) {
            // In case invalid input is provided, this error will be thrown.

            print("This type of object is not supported as table content: " + String(describing: (type(of: value))))
        } catch {
            // General error handling in case something goes wrong.

            print("Error while creating table: " + error.localizedDescription)
        }

        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.

        table.widths = [
            0.1, 0.25, 0.35, 0.3
        ]

        // To speed up table styling, use a default and change it

        let style = PDFTableStyleDefaults.simple

        // Change standardized styles
        style.footerStyle = PDFTableCellStyle(
            colors: (
                fill: UIColor(red: 0.171875,
                              green: 0.2421875,
                              blue: 0.3125,
                              alpha: 1.0),
                text: UIColor.white
            ),
            borders: PDFTableCellBorders(left: PDFLineStyle(type: .full),
                      top: PDFLineStyle(type: .full),
                      right: PDFLineStyle(type: .full),
                      bottom: PDFLineStyle(type: .full)),

            font: UIFont.systemFont(ofSize: 10)
        )

        // Simply set the amount of footer and header rows

        style.columnHeaderCount = 1
        style.footerCount = 1

        table.style = style

        do {
            // Style each cell individually
            try table.setCellStyle(row: 1, column: 1, style: PDFTableCellStyle(colors: (fill: UIColor.yellow, text: UIColor.black)))
        } catch PDFError.tableIndexOutOfBounds(let index, let length){
            // In case the index is out of bounds

            print("Requested cell is out of bounds! \(index) / \(length)")
        } catch {
            // General error handling in case something goes wrong.

            print("Error while setting cell style: " + error.localizedDescription)
        }

        // Set table padding and margin

        table.padding = 5.0
        table.margin = 10.0

        // In case of a linebreak during rendering we want to have table headers on each page.

        table.showHeadersOnEveryPage = true

        document.add(table: table)

        // Add more text after the table
        document.add(text: "Just adding more text here...")
		
		// Add multi column section
		let section = PDFSection(columnWidths: [0.33, 0.34, 0.33])
		section.columns[0].add(.left, text: "left")
		section.columns[0].add(.center, text: "center")
		section.columns[0].add(.right, text: "right")
		section.columns[0].add(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.")
		section.columns[0].add(.center, image: PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 40, height: 40), quality: 0.9))
		section.columns[0].add(text: "At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
		section.columns[1].add(.left, text: "left")
		section.columns[1].add(.center, text: "center")
		section.columns[1].add(.right, text: "right")
		section.columns[1].add(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
		section.columns[1].add(.center, text: "center")
		section.columns[1].add(.center, image: PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 40, height: 40), quality: 0.9))
		section.columns[2].add(.center, image: PDFImage(image: UIImage(named: "Icon.png")!, size: CGSize(width: 40, height: 40), quality: 0.9))
		section.columns[2].add(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
		section.columns[2].add(.left, text: "left")
		section.columns[2].add(.center, text: "center")
		section.columns[2].add(.right, text: "right")
		section.columns[2].add(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.")
        document.add(section: section)

        // Add a floating multisection

        document.enable(columns: 3, widths: [0.3, 0.5, 0.2], spacings: [10, 10])
        document.add(text: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.")
        document.disableColumns(addPageBreak: false)

        // Add a group

        document.add(textObject: PDFSimpleText(text: "4. Groups", style: headingStyle1))
        
        let size = CGSize(width: 100, height: 100)

        let path = PDFBezierPath(ref: CGRect(origin: .zero, size: size))
        path.move(to: PDFBezierPathVertex(position: CGPoint(x: size.width / 2, y: 0), anchor: .topCenter))
        path.addLine(to: PDFBezierPathVertex(position: CGPoint(x: size.width, y: size.height / 2),
                                             anchor: .middleRight))
        path.addLine(to: PDFBezierPathVertex(position: CGPoint(x: size.width / 2, y: size.height),
                                             anchor: .bottomCenter))
        path.addLine(to: PDFBezierPathVertex(position: CGPoint(x: 0, y: size.height / 2),
                                             anchor: .middleLeft))
        path.close()

        let shape = PDFDynamicGeometryShape(path: path, fillColor: .orange, stroke: .none)

        let group = PDFGroup(allowsBreaks: false,
                             backgroundColor: .green,
                             backgroundShape: shape,
                             padding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 180))
        for i in 0..<10 {
            group.set(font: UIFont.systemFont(ofSize: 18))
            group.set(indentation: 30 * CGFloat(i % 5), left: true)
            group.set(indentation: 30 * CGFloat(i % 3), left: false)
            group.add(text: "Text \(i)-\(i)-\(i)-\(i)-\(i)")
        }
        document.add(group: group)

        // Add text to footer

        document.add(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 1"))
        document.add(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 2"))
        document.add(.footerLeft, textObject: PDFSimpleText(text: "Footer Left 3"))

        document.add(.footerRight, textObject: PDFSimpleText(text: "Footer Right 1"))
        document.add(.footerRight, textObject: PDFSimpleText(text: "Footer Right 2"))
        document.add(.footerRight, textObject: PDFSimpleText(text: "Footer Right 3"))

        // Add text to header

        document.add(.headerLeft, textObject: PDFSimpleText(text: "Header Left 1"))
        document.add(.headerLeft, textObject: PDFSimpleText(text: "Header Left 2"))
        document.add(.headerLeft, textObject: PDFSimpleText(text: "Header Left 3"))

        document.add(.headerRight, textObject: PDFSimpleText(text: "Header Right 1"))
        document.add(.headerRight, textObject: PDFSimpleText(text: "Header Right 2"))
        document.add(.headerRight, textObject: PDFSimpleText(text: "Header Right 3"))

        // Create a second document and combine them

        let secondDocument = PDFDocument(format: .a6)
        secondDocument.add(text: "This is a brand new document with a different format!")

        /* ---- Execution Metrics ---- */
        print("Preparation took: " + stringFromTimeInterval(interval: CFAbsoluteTimeGetCurrent() - startTime))
        startTime = CFAbsoluteTimeGetCurrent()
        /* ---- Execution Metrics ---- */
        
        // Convert document to JSON String for debugging
//        let _ = document.toJSON(options: JSONSerialization.WritingOptions.prettyPrinted) ?? "nil"
//        print(json)

        do {
            // Generate PDF file and save it in a temporary file. This returns the file URL to the temporary file
            let url = try PDFGenerator.generateURL(documents: [document, secondDocument],
                                                   filename: "Example.pdf",
                                                   progress: { (docIndex: Int, progressValue: CGFloat, totalProgressValue: CGFloat) in
                                                    print("doc:", docIndex, "progress:", progressValue, "total:", totalProgressValue)
            })

            // Load PDF into a webview from the temporary file
            (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
        } catch {
            print("Error while generating PDF: " + error.localizedDescription)
        }
        
        /* ---- Execution Metrics ---- */
        print("Generation took: " + stringFromTimeInterval(interval: CFAbsoluteTimeGetCurrent() - startTime))
        /* ---- Execution Metrics ---- */
    }
    
    /**
     Used for debugging execution time.
     Converts time interval in seconds to String.
     */
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let ns = (interval * 10e8).truncatingRemainder(dividingBy: 10e5)
        let ms = (interval * 10e2).rounded(.towardZero)
        let seconds = interval.rounded(.towardZero)
        let minutes = (interval / 60).rounded(.towardZero)
        let hours = (interval / 3600).rounded(.towardZero)
        
        var result = [String]()
        if hours > 1 {
            result.append(String(format: "%.0f", hours) + "h")
        }
        if minutes > 1 {
            result.append(String(format: "%.0f", minutes) + "m")
        }
        if seconds > 1 {
            result.append(String(format: "%.0f", seconds) + "s")
        }
        if ms > 1 {
            result.append(String(format: "%.0f", ms) + "ms")
        }
        if ns > 0.001 {
            result.append(String(format: "%.3f", ns) + "ns")
        }
        return result.joined(separator: " ")
    }
}
