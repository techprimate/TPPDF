//
//  PDFGenerator+Pagination.swift
//  Pods
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation

extension PDFGenerator {
    
    open func setPageNumbering(_ container: Container = Container.footerRight, style: PaginationStyle = PaginationStyle.Default, from fromPage: Int = 0, to toPage: Int = Int.max, hiddenPages: [Int] = []) {
        self.paginationContainer = container
        self.paginationStyle = style
        self.paginationStart = fromPage
        self.paginationEnd = toPage
        self.paginationExcludes = hiddenPages
    }
}
