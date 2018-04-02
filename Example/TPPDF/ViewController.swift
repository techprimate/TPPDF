//
//  ViewController.swift
//  PDFGenerator
//
//  Created by Philip Niedertscheider on 11/08/16.
//  Copyright © 2016 Techprimate. All rights reserved.
//

import UIKit
import TPPDF

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generatePDF()
    }
    
    func generatePDF() {
        let pdf = PDFGenerator(format: .a4)
		
		pdf.addTextInline(.contentLeft, text: "This is left aligned inline text.\n\nUse line breaks to separate multiple items.", textMaxWidth: 100)
		if let image = UIImage(named: "Image") {
			pdf.addImageInline(.contentRight, image: image, size: CGSize(width: 100, height: 100))
		}
		pdf.addTextInline(.contentCenter, text: "this is centered inline text", textMaxWidth: 100)
		
		pdf.addSpace(space: 50)
		
		pdf.addTextInline(.contentLeft, text: "left text\nfree float")
		
		let inlineTableData: [[String]] = [
			["Company",                     "Contact"],
			["Alfreds Futterkiste",         "Maria Anders"],
			["Berglunds snabbköp",          "Christina Berglund"],
			["Centro comercialMoctezuma",   "Francisco Chang"]
		]
		let inlineTableAlignment: [[TableCellAlignment]] = [
			[.left, .left],
			[.left, .left],
			[.left, .left],
			[.left, .left]
		]
		
		let inlineTableWidth: [CGFloat] = [0.20, 0.20]
		
		let inlineTableStyle = TableStyleDefaults.simple
		pdf.addTableInline(.contentRight, data: inlineTableData, alignment: inlineTableAlignment, relativeColumnWidth: inlineTableWidth, padding: 8, margin: 0, style: inlineTableStyle)
		pdf.addSpace(space: 50)
        
        let tableData: [[String]] = [
            ["",    "Company",                     "Contact",              "Country"],
            ["1",    "Alfreds Futterkiste",         "Maria Anders",         "Germany"],
            ["2",    "Berglunds snabbköp",          "Christina Berglund",   "Sweden"],
            ["3",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["4",    "Ernst Handel",                "Roland Mendel",        "Austria"],
            ["5",    "Island Trading",              "Helen Bennett",        "UK"],
            ["6",    "Königlich Essen",             "Philip Cramer",        "Germany"],
            ["7",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["8",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["9",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["10",    "Ernst Handel",                "Roland Mendel",        "Austria"],
            ["11",    "Island Trading",              "Helen Bennett",        "UK"],
            ["12",    "Königlich Essen",             "Philip Cramer",        "Germany"],
            ["13",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["14",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["15",    "Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["16",    "Ernst Handel",                "Roland Mendel",        "Austria"],
            ["17",    "Island Trading",              "Helen Bennett",        "UK"],
            ["18",    "Königlich Essen",             "Philip Cramer",        "Germany"],
            ["19",    "Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["20",    "Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["21",    "Company",                     "Contact",              "Country"]
        ]
        let tableAlignment: [[TableCellAlignment]] = [
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left],
            [.center, .left, .center, .left]
        ]
        let tableWidth: [CGFloat] = [
            0.08, 0.4, 0.251, 0.251
        ]
        
        let tableStyle = TableStyleDefaults.simple
        tableStyle.setCellStyle(row: 2, column: 3, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        tableStyle.setCellStyle(row: 20, column: 1, style: TableCellStyle(fillColor: .yellow, textColor: .blue, font: UIFont.boldSystemFont(ofSize: 18)))
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 8, margin: 0, style: tableStyle)
        
        let url = pdf.generatePDFfile("Pasta with tomato sauce")
        (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
    }
}
