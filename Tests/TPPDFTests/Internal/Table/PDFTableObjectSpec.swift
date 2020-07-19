import CoreGraphics
import Quick
import Nimble
@testable import TPPDF

class PDFTableObjectSpec: QuickSpec {

    override func spec() {
        describe("PDFTableObject") {
            describe("calculation result frames") {
                context("unmerged cells on multiple pages without splicing and no table headers on every page") {
                    let container = PDFContainer.contentLeft

                    let rows = 40
                    let columns = 4
                    let count = rows * columns
                    let table = PDFTable(rows: rows, columns: columns)
                    table.widths = [0.1, 0.3, 0.3, 0.3]
                    table.margin = 10
                    table.padding = 10
                    table.showHeadersOnEveryPage = false
                    table.shouldSplitCellsOnPageBeak = false
                    table.style.columnHeaderCount = 3

                    for row in 0..<table.size.rows {
                        table[row, 0].content = "\(row)".asTableContent
                        for column in 1..<table.size.columns {
                            table[row, column].content = "\(row),\(column)".asTableContent
                        }
                    }

                    let generator = PDFGenerator(document: .init(format: .a4))
                    let tableObject = PDFTableObject(table: table)
                    let result = try! tableObject.calculate(generator: generator, container: container)

                    it("should return correct cell count including necessary page breaks") {
                        expect(result).to(haveCount(count + 3))
                    }

                    // Page breaks should be at 52, 101, 150

                    it("should have a page break between first and second page") {
                        let breakObject = PDFPageBreakObject()
                        breakObject.stayOnSamePage = true
                        expect(result[52].1 as? PDFPageBreakObject) == breakObject
                    }

                    it("should have a page break between second and third page") {
                        let breakObject = PDFPageBreakObject()
                        breakObject.stayOnSamePage = true
                        expect(result[101].1 as? PDFPageBreakObject) == breakObject
                    }

                    it("should have a page break between third and fourth page") {
                        let breakObject = PDFPageBreakObject()
                        breakObject.stayOnSamePage = true
                        expect(result[150].1 as? PDFPageBreakObject) == breakObject
                    }

                    let frames_0_10: [[CGRect]] = (0..<11)
                        .map ({ row -> [CGRect] in
                            (0..<4).map { col -> CGRect in
                                CGRect(x: [70, 117.5, 260, 402.5][col],
                                       y: 85 + CGFloat(row) * 47,
                                       width: [27.5, 122.5, 122.5, 122.5][col],
                                       height: row >= 10 ? 50 : 37)
                            }
                        })
                    let frames_11_13: [[CGRect]] = (11..<13)
                        .map ({ row -> [CGRect] in
                            (0..<4).map { col -> CGRect in
                                CGRect(x: [70, 117.5, 260, 402.5][col],
                                       y: 615 + CGFloat(row - 11) * 60,
                                       width: [27.5, 122.5, 122.5, 122.5][col],
                                       height: row >= 10 ? 50 : 37)
                            }
                        })
                    let frames_13_25: [[CGRect]] = (13..<25)
                        .map ({ row -> [CGRect] in
                            (0..<4).map { col -> CGRect in
                                CGRect(x: [70, 117.5, 260, 402.5][col],
                                       y: 60 + CGFloat(row - 13) * 60,
                                       width: [27.5, 122.5, 122.5, 122.5][col],
                                       height: row >= 10 ? 50 : 37)
                            }
                        })
                    let frames_25_37: [[CGRect]] = (25..<37)
                        .map ({ row -> [CGRect] in
                            (0..<4).map { col -> CGRect in
                                CGRect(x: [70, 117.5, 260, 402.5][col],
                                       y: 60 + CGFloat(row - 25) * 60,
                                       width: [27.5, 122.5, 122.5, 122.5][col],
                                       height: row >= 10 ? 50 : 37)
                            }
                        })
                    let frames_37_40: [[CGRect]] = (37..<40)
                        .map ({ row -> [CGRect] in
                            (0..<4).map { col -> CGRect in
                                CGRect(x: [70, 117.5, 260, 402.5][col],
                                       y: 60 + CGFloat(row - 37) * 60,
                                       width: [27.5, 122.5, 122.5, 122.5][col],
                                       height: row >= 10 ? 50 : 37)
                            }
                        })

                    // test cells on first page
                    for row in 0..<13 {
                        for column in 0..<4 {
                            context("cell \(row) \(column)") {
                                let locatedCell = result[row * columns + column]

                                it("should be in the correct container") {
                                    expect(locatedCell.0) == container
                                }

                                it("should have correct frame") {
                                    let expectedFrames = frames_0_10 + frames_11_13
                                    expect(locatedCell.1.frame) == expectedFrames[row][column]
                                }
                            }
                        }
                    }

                    // test cells on second page
                    for row in 13..<25 {
                        for column in 0..<4 {
                            context("cell \(row) \(column)") {
                                let locatedCell = result[1 + (row * columns + column)]

                                it("should be in the correct container") {
                                    expect(locatedCell.0) == container
                                }

                                it("should have correct frame") {
                                    expect(locatedCell.1.frame) == frames_13_25[row - 13][column]
                                }
                            }
                        }
                    }

                    // test cells on third page
                    for row in 25..<37 {
                        for column in 0..<4 {
                            context("cell \(row) \(column)") {
                                let locatedCell = result[2 + (row * columns + column)]

                                it("should be in the correct container") {
                                    expect(locatedCell.0) == container
                                }

                                it("should have correct frame") {
                                    expect(locatedCell.1.frame) == frames_25_37[row - 25][column]
                                }
                            }
                        }
                    }

                    // test cells on fourth page
                    for row in 37..<40 {
                        for column in 0..<4 {
                            context("cell \(row) \(column)") {
                                let locatedCell = result[3 + row * columns + column]

                                it("should be in the correct container") {
                                    expect(locatedCell.0) == container
                                }

                                it("should have correct frame") {
                                    expect(locatedCell.1.frame) == frames_37_40[row - 37][column]
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
