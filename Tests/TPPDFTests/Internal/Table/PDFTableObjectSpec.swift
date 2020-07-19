import Quick
import Nimble
@testable import TPPDF

class PDFTableObjectSpec: QuickSpec {

    override func spec() {
        describe("PDFTableObject") {
            describe("calculations") {
                context("unmerged cells on multiple pages without splicing and no table headers on every page") {
                    let table = PDFTable(rows: 50, columns: 4)
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

                    it("should return correct frames") {
                        let generator = PDFGenerator(document: .init(format: .a4))
                        let tableObject = PDFTableObject(table: table)

                        var result: [PDFLocatedRenderObject]!
                        expect {
                            result = try tableObject.calculate(generator: generator, container: .contentLeft)
                        }.toNot(throwError())

                        //expect(result).to(haveCount(1))
                    }
                }
            }
        }
    }
}

