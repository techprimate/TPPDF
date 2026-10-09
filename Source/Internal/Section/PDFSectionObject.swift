//
//  PDFSectionObject.swift
//  TPPDF
//
//  Created by Marco Betschart on 05.05.2018.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
    import UIKit
#else
    import AppKit
#endif

class PDFSectionObject: PDFRenderObject {
    struct PDFSectionColumnMetadata {
        let minX: CGFloat
        let width: CGFloat
        let backgroundColor: Color?
    }

    var section: PDFSection

    init(section: PDFSection) {
        self.section = section
    }

    /// nodoc
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        // Save state of layout
        let originalIndent = generator.layout.indentation.content
        let originalContentOffset = generator.getContentOffset(in: container)

        var leftColumnGuide: CGFloat = originalIndent.left
        var objectsPerColumn: [Int: [PDFLocatedRenderObject]] = [:]

        let availableWidth = PDFCalculations.calculateAvailableFrameWidth(for: generator, in: container)
        let contentWidth = availableWidth - max(0, CGFloat(section.columns.count - 1)) * section.columnMargin

        var columnMetadata = [PDFSectionColumnMetadata]()
        for (columnIndex, column) in section.columns.enumerated() {
            let columnWidth = column.width * contentWidth
            let rightColumnGuide = leftColumnGuide + columnWidth

            for container in [PDFContainer.contentLeft, .contentCenter, .contentRight] {
                generator.setContentOffset(in: container, to: originalContentOffset)
                generator.layout.indentation.setLeft(indentation: leftColumnGuide, in: container)
                generator.layout.indentation.setRight(indentation: availableWidth - rightColumnGuide + originalIndent.right, in: container)
            }

            objectsPerColumn[columnIndex] = try PDFSectionColumnObject(column: column)
                .calculate(generator: generator, container: container)

            columnMetadata.append(.init(
                minX: generator.layout.margin.left + leftColumnGuide,
                width: columnWidth,
                backgroundColor: column.backgroundColor
            ))

            leftColumnGuide = rightColumnGuide + section.columnMargin
        }
        result += calulatePageBreakPositions(objectsPerColumn, metadata: columnMetadata, container: container)
        generator.layout.indentation.content = originalIndent

        var contentMinY: CGFloat?
        var contentMaxY: CGFloat?

        for (_, currentObject) in result.reversed() {
            if currentObject is PDFPageBreakObject {
                break
            }
            if currentObject.frame.origin.y == CGFloat.infinity {
                continue
            }

            if contentMaxY == nil {
                contentMaxY = currentObject.frame.maxY
            } else if let maxY = contentMaxY, maxY < currentObject.frame.maxY {
                contentMaxY = currentObject.frame.maxY
            }

            if contentMinY == nil {
                contentMinY = currentObject.frame.minY
            } else if let minY = contentMaxY, minY > currentObject.frame.minY {
                contentMinY = currentObject.frame.minY
            }
        }
        let containsBreak = result.contains(where: { $0.1 is PDFPageBreakObject })
        generator.setContentOffset(in: container, to: (contentMaxY ?? 0) - (contentMinY ?? 0) + (containsBreak ? 0 : originalContentOffset))

        return result
    }

    /**
     * The `PDFDocument` render engine calculates each object, which returns a list of calculated objects.
     * As an example if you add a text object, it will be calculated and return one text object which will then be rendered.
     *
     * **BUT** if the text is too long to fit the space, then it will be split up into two text objects with a `PDFPageBreakObject` in-between.
     *
     * During the render process whenever a page break object is found, it will create a new pdf page and continue there.
     * In order to render multi columns correctly, we need to merge the page breaks of all columns and make sure
     * the page break occurs at the right time:
     *
     * ```
     * All objects of column 1 before the first pagebreak
     * All objects of column 2 before the first pagebreak
     * All objects of column 3 before the first pagebreak
     * Pagebreak
     * All objects of column 1 after the first pagebreak up to the next pagebreak
     * All objects of column 2 after the first pagebreak up to the next pagebreak
     * All objects of column 3 after the first pagebreak up to the next pagebreak
     * Pagebreak
     * ...
     * ```
     */
    func calulatePageBreakPositions(
        _ objectsPerColumn: [Int: [PDFLocatedRenderObject]],
        metadata: [PDFSectionColumnMetadata],
        container: PDFContainer
    ) -> [PDFLocatedRenderObject] {
        // Object indices are not aligned vertically across columns. Group by page
        // before drawing backgrounds so later slices cannot cover earlier text.
        let pagesPerColumn = objectsPerColumn.mapValues { objects in
            var pages: [[PDFLocatedRenderObject]] = [[]]
            for object in objects {
                if object.1 is PDFPageBreakObject {
                    pages.append([])
                } else {
                    pages[pages.count - 1].append(object)
                }
            }
            return pages
        }
        let pageCount = pagesPerColumn.values.map(\.count).max() ?? 0
        let columnIndices = objectsPerColumn.keys.sorted()
        var result: [PDFLocatedRenderObject] = []

        for pageIndex in 0..<pageCount {
            if pageIndex > 0 {
                result.append((.contentLeft, PDFPageBreakObject()))
            }

            var pageObjects: [Int: [PDFLocatedRenderObject]] = [:]
            for columnIndex in columnIndices {
                if let pages = pagesPerColumn[columnIndex], pageIndex < pages.count {
                    pageObjects[columnIndex] = pages[pageIndex]
                }
            }
            let frames = pageObjects.values.flatMap { $0 }
                .map(\.1.frame)
                .filter { !$0.isNull }

            if let minY = frames.map(\.minY).min(),
               let maxY = frames.map(\.maxY).max() {
                for columnIndex in columnIndices {
                    guard let objects = pageObjects[columnIndex], !objects.isEmpty,
                          let backgroundColor = metadata[columnIndex].backgroundColor else { continue }
                    let column = metadata[columnIndex]
                    let frame = CGRect(x: column.minX, y: minY, width: column.width, height: maxY - minY)
                    let rect = PDFRectangleObject(lineStyle: .none, frame: frame, fillColor: backgroundColor)
                    result.append((container, rect))
                }
            }
            for columnIndex in columnIndices {
                result += pageObjects[columnIndex] ?? []
            }
        }

        return result
    }

    /// nodoc
    override var copy: PDFRenderObject {
        PDFSectionObject(section: section.copy)
    }
}
