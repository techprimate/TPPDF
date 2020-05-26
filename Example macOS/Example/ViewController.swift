//
//  ViewController.swift
//  Example
//
//  Created by Philip Niedertscheider on 19.05.20.
//  Copyright © 2020 techprimate GmbH & Co. KG. All rights reserved.
//

import Cocoa
import TPPDF

class ViewController: NSViewController {

    var generator: PDFGenerator!
    var observer: NSObjectProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()

        let document = PDFDocument(format: .a4)

        document.add(space: 100)
        let singleCellTable = PDFTable(rows: 1, columns: 1)
        singleCellTable[0,0].content = (0...100).map(String.init)
            .joined(separator: "\n")
            .asTableContent
        document.add(table: singleCellTable)

        generator = PDFGenerator(document: document)
        generator.debug = true

        observer = generator.progress.observe(\.completedUnitCount) { (p, _) in
            print(p.localizedDescription ?? "")
        }
        DispatchQueue.global(qos: .background).async {
            do {
                let url = URL(fileURLWithPath: "/var/folders/1t/26yb_fdn1qn3b70mxpwgvs480000gn/T/com.techprimate.tppdf.example/output.pdf")
                print("URL: ", url)
                try self.generator.generate(to: url)
            } catch {
                print("Error while generating PDF: " + error.localizedDescription)
            }
        }

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

