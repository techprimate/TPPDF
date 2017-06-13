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
        
        pdf.setPageNumbering(.footerCenter, style: PaginationStyle.CustomClosure({(index: Int, max: Int) -> String in
            return String(format: "%d/%d", index, max)
        }), from: 1, to: 4, hiddenPages: [4])
        
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
