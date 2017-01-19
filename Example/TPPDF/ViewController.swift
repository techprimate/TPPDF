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
        let pdf = PDFGenerator(format: .a4, paginationContainer: .footerRight)
        
        let tableData: [[String]] = [
            ["Company",                     "Contact",              "Country"],
            ["Alfreds Futterkiste",         "Maria Anders",         "Germany"],
            ["Berglunds snabbköp",          "Christina Berglund",   "Sweden"],
            ["Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["Ernst Handel",                "Roland Mendel",        "Austria"],
            ["Island Trading",              "Helen Bennett",        "UK"],
            ["Königlich Essen",             "Philip Cramer",        "Germany"],
            ["Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["Ernst Handel",                "Roland Mendel",        "Austria"],
            ["Island Trading",              "Helen Bennett",        "UK"],
            ["Königlich Essen",             "Philip Cramer",        "Germany"],
            ["Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["Centro comercialMoctezuma",   "Francisco Chang",      "Mexico"],
            ["Ernst Handel",                "Roland Mendel",        "Austria"],
            ["Island Trading",              "Helen Bennett",        "UK"],
            ["Königlich Essen",             "Philip Cramer",        "Germany"],
            ["Laughing Bacchus",            "Yoshi Tannamuri",      "Canada"],
            ["Magazzini Alimentari",        "Giovanni Rovelli",     "Italy"],
            ["Company",                     "Contact",              "Country"]
        ]
        let tableAlignment: [[TableCellAlignment]] = [
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left],
            [.left, .center, .left]
        ]
        let tableWidth: [CGFloat] = [
            0.4, 0.3, 0.3
        ]
        let tableStyle = TableStyleDefaults.simple
        
        pdf.addTable(data: tableData, alignment: tableAlignment, relativeColumnWidth: tableWidth, padding: 10, margin: 0, style: tableStyle)
        
        let url = pdf.generatePDFfile("Pasta with tomato sauce")
        (self.view as? UIWebView)?.loadRequest(URLRequest(url: url))
    }
}
