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
        generatePDF()
    }
    
    func generatePDF() {
        /* Execution Metrics */
        var startTime = Date()
        /* Execution Metrics */
        
        let pdf = PDFGenerator(format: .a4)
        
        // Set document meta data
        pdf.info.title = "TPPDF Example"
        pdf.info.subject = "Building a PDF easily"
        
        // Set spacing of header and footer
        pdf.headerSpace = 50
        pdf.footerSpace = 25
        
        // Add custom pagination, starting at page 1 and excluding page 3
        pdf.setPageNumbering(.footerRight, style: PaginationStyle.CustomClosure({ (page, total) -> String in
            return "\(page) / \(total)"
        }), from: 1, to: 10, hiddenPages: [3])
        
        // Add an image and scale it down. Image will not be drawn scaled, instead it will be scaled down and compressed to save file size.
        pdf.addImage(.contentCenter, image: UIImage(named: "Icon.png")!, size: CGSize(width: 150, height: 150))
        // Add some spacing below image
        pdf.addSpace(space: 15.0)
        
        // Create and add an title as an attributed string for more customization possibilities
        let title = NSMutableAttributedString(string: "TPPDF", attributes: [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 50.0),
            NSParagraphStyleAttributeName: {
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }(),
            NSForegroundColorAttributeName: UIColor(colorLiteralRed: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0)
            ])
        pdf.addAttributedText(.contentCenter, text: title)
        
        // Set document font and document color. This will be used for simple text until it is reset.
        pdf.setFont(font: UIFont.systemFont(ofSize: 18.0))
        pdf.setTextColor(color: UIColor.lightGray)
        pdf.addText(.contentCenter, text: "Create PDF documents easily.")
        
        // Reset font and text color
        pdf.resetFont()
        pdf.resetTextColor()
        
        // Create a list with level indentations
        let list = List(indentations: [(pre: 0.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])
        
        list.addItems([
            ListItem(symbol: .numbered(value: nil))
                .addItems([
                    ListItem(content: "Introduction")
                        .addItems([
                            ListItem(symbol: .numbered(value: nil))
                                .addItems([
                                    ListItem(content: "Text"),
                                    ListItem(content: "Attributed Text"),
                                    ])
                            ])
                    ])
            ])
        
        pdf.addList(list: list)
        
        // Set Font for headline
        
        pdf.setFont(font: UIFont.systemFont(ofSize: 20.0))
        
        // Add headline with extra spacing
        
        pdf.addSpace(space: 30)
        pdf.addText(text: "1. Introduction")
        pdf.addSpace(space: 10)
        
        // Set font for text
        
        pdf.setFont(font: UIFont.systemFont(ofSize: 13.0))
        
        // Add long simple text. This will automatically word wrap if content width is not enough.
        
        pdf.addText(text: "Generating a PDF file using TPPDF feels like a breeze. You can easily setup a document using many convenient commands, and the framework will calculate and render the PDF file at top speed. A small document with 2 pages can be generated in less than 100 milliseconds. A larger document with more complex content, like tables, is still computed in less than a second.")
        pdf.addSpace(space: 10)
        pdf.addText(text: "TPPDF includes many different features:")
        
        pdf.addSpace(space: 10)
        
        // Simple bullet point list
        
        let featureList = List(indentations: [(pre: 0.0, past: 20.0), (pre: 20.0, past: 20.0), (pre: 40.0, past: 20.0)])
        
        featureList.addItem(ListItem(symbol: .dot).addItems([
            ListItem(content: "Simple text drawing"),
            ListItem(content: "Advanced text drawing using AttributedString"),
            ListItem(content: "Multi-layer rendering by simply setting the offset"),
            ListItem(content: "Fully calculated content sizing"),
            ListItem(content: "Automatic page wrapping"),
            ListItem(content: "Customizable pagination"),
            ListItem(content: "Fully editable header and footer"),
            ListItem(content: "Simple image positioning and rendering"),
            ListItem(content: "Image captions")
            ]))
        pdf.addList(list: featureList)
        
        // Insert page break
        
        pdf.createNewPage()
        
        // Create a line separator
        
        pdf.addSpace(space: 10)
        pdf.addLineSeparator(style: LineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        pdf.addSpace(space: 10)
        
        // Create an image collage with captions
        
        let images = [
            [
                UIImage(named: "Image-1.jpg")!,
                UIImage(named: "Image-2.jpg")!
            ],
            [
                UIImage(named: "Image-3.jpg")!,
                UIImage(named: "Image-4.jpg")!
            ]
        ]
        
        // Create attributes for captions
        
        let captionAttributes = [
            NSFontAttributeName: UIFont.italicSystemFont(ofSize: 15.0),
            NSParagraphStyleAttributeName: {
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                return style
            }(),
            NSForegroundColorAttributeName: UIColor(colorLiteralRed: 0.171875, green: 0.2421875, blue: 0.3125, alpha: 1.0),
            
            ]
        
        // Add first row of images
        
        pdf.addImagesInRow(images: images[0], captions: [
            NSAttributedString(string: "Waterfall", attributes: captionAttributes),
            NSAttributedString(string: "Forrest", attributes: captionAttributes)
            ], spacing: 10)
        
        // Add spacing between image rows
        
        pdf.addSpace(space: 10)
        
        // Add second row of images
        
        pdf.addImagesInRow(images: images[1], captions: [
            NSAttributedString(string: "Fireworks", attributes: captionAttributes),
            NSAttributedString(string: "Field", attributes: captionAttributes)
            ], spacing: 10)
        
        // Finish image collage with another line separator
        
        pdf.addSpace(space: 10)
        pdf.addLineSeparator(style: LineStyle(type: .full, color: UIColor.darkGray, width: 0.5))
        pdf.addSpace(space: 10)
        
        // Create a table
        
        let table = Table()
        
        // Tables can contain Strings, Numbers, Images or nil, in case you need an empty cell. If you add a unknown content type, an error will be thrown and the rendering will stop.
        
        do {
            try table.setData(data: [
                [nil, "Name", "Image", "Description"],
                [1, "Waterfall", UIImage(named: "Image-1.jpg")!, "Water flowing down stones."],
                [2, "Forrest", UIImage(named: "Image-2.jpg")!, "Sunlight shining through the leafs."],
                [3, "Fireworks", UIImage(named: "Image-3.jpg")!, "Fireworks exploding into 100.000 stars"],
                [4, "Fields", UIImage(named: "Image-4.jpg")!, "Crops growing big and providing food."],
                [nil, nil, nil, "Many beautiful places"]
                ])
        } catch TPPDFError.tableContentInvalid(let value) {
            // In case invalid input is provided, this error will be thrown.
            
            print("This type of object is not supported as table content: " + String(describing: (type(of: value))))
        } catch {
            // Generall error handling in case something goes wrong.
            
            print("Error while creating table: " + error.localizedDescription)
        }
        
        // Now set the alignment of each cell.
        
        table.alignments = [
            [.center, .center, .center, .left],
            [.center, .center, .center, .left],
            [.center, .center, .center, .left],
            [.center, .center, .center, .left],
            [.center, .center, .center, .left],
            [.left, .left, .left, .left]
        ]
        
        // The widths of each column is proportional to the total width, set by a value between 0.0 and 1.0, representing percentage.
        
        table.widths = [
            0.1, 0.25, 0.35, 0.3
        ]
        
        // To speed up table styling, use a default and change it
        
        let style = TableStyleDefaults.simple
        
        // Style each cell individually
        
        style.setCellStyle(row: 1, column: 1, style: TableCellStyle(fillColor: UIColor.yellow))
        
        // Change standardized styles
        table.style.footerStyle = TableCellStyle(
            fillColor: UIColor(colorLiteralRed: 0.171875,
                               green: 0.2421875,
                               blue: 0.3125,
                               alpha: 1.0),
            textColor: UIColor.white,
            font: UIFont.systemFont(ofSize: 10),
            borderLeft: LineStyle(),
            borderTop: LineStyle(),
            borderRight: LineStyle(),
            borderBottom: LineStyle())
        
        // Simply set the amount of footer and header rows
        
        table.style.columnHeaderCount = 1
        table.style.footerCount = 1
        
        // Set table padding and margin
        
        table.padding = 4
        table.margin = 0
        
        // In case of a linebreak during rendering we want to have table headers on each page.
        
        table.showHeadersOnEveryPage = true
        
        pdf.addTable(table: table)
        
        
        
        /* Execution Metrics */
        print("Preparation: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* Execution Metrics */
        
        do {
            let url = try pdf.generatePDFfile("Pasta with tomato sauce")
            
            (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
        } catch {
            print("Error while generating PDF: " + error.localizedDescription)
        }
        
        /* Execution Metrics */
        print("Generation: " + stringFromTimeInterval(interval: Date().timeIntervalSince(startTime)))
        startTime = Date()
        /* Execution Metrics */
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
        if (hours > 1) {
            result.append(String(format: "%.0f", hours) + "h")
        }
        if (minutes > 1) {
            result.append(String(format: "%.0f", minutes) + "m")
        }
        if (seconds > 1) {
            result.append(String(format: "%.0f", seconds) + "s")
        }
        if (ms > 1) {
            result.append(String(format: "%.0f", ms) + "ms")
        }
        if (ns > 0.001) {
            result.append(String(format: "%.3f", ns) + "ns")
        }
        return result.joined(separator: " ")
    }
}
