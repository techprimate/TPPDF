import Quick
import Nimble
@testable import TPPDF

class PDFTableObjectSpec: QuickSpec {

    override func spec() {
        describe("PDFTableObject") {
            describe("calculations") {
                context("unmerged cells on multiple pages without splicing and no table headers on every page") {
                    let container = PDFContainer.contentLeft

                    let rows = 50
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

                    var result: [PDFLocatedRenderObject]!

                    beforeEach {
                        let generator = PDFGenerator(document: .init(format: .a4))
                        let tableObject = PDFTableObject(table: table)

                        expect {
                            result = try tableObject.calculate(generator: generator, container: container)
                        }.toNot(throwError())
                    }

                    it("should return all cells and necessary page breaks") {
                        expect(result).to(haveCount(count))

                        for (i, cell) in result.enumerated() {
                            let row = i / columns
                            let column = i % columns
                            expect(cell.0) == container
                            guard let renderObject = cell.1 as? PDFSlicedObject else {
                                fail()
                                return
                            }
                        }
                    }
                }
            }
        }
    }
}

