//
//  PDFListObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

/**
 TODO: documentation
 */
internal class PDFListObject: PDFRenderObject {

    /**
     TODO: documentation
     */
    internal var list: PDFList

    /**
     TODO: documentation
     */
    internal init(list: PDFList) {
        self.list = list
    }

    /**
     TODO: documentation
     */
    override internal func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [PDFLocatedRenderObject] {
        var result: [PDFLocatedRenderObject] = []

        let originalLeftIndent = generator.layout.indentation.leftIn(container: container)

        for item in list.flatted() {
            let indent = item.level < list.levelIndentations.count ?
                list.levelIndentations[item.level] :
                list.levelIndentations.last ?? (pre: 0, past: 0)

            generator.layout.indentation.setLeft(indentation: originalLeftIndent + indent.pre, in: container)
            result += try createSymbolItem(generator: generator, container: container, symbol: item.symbol)

            generator.layout.indentation.setLeft(indentation: originalLeftIndent + indent.pre + indent.past, in: container)
            result += try createTextItem(generator: generator, container: container, text: item.text)

            generator.layout.indentation.setLeft(indentation: originalLeftIndent, in: container)
        }

        return result
    }

    /**
     TODO: Documentation
     */
    private func createSymbolItem(generator: PDFGenerator,
                                  container: PDFContainer,
                                  symbol: PDFListItemSymbol) throws -> [PDFLocatedRenderObject] {
        let symbol: String = symbol.stringValue
        let symbolText = PDFSimpleText(text: symbol)
        let symbolTextObject = PDFAttributedTextObject(simpleText: symbolText)
        let toAdd = try symbolTextObject.calculate(generator: generator, container: container)

        if toAdd.isEmpty {
            return []
        }
        let symbolTextElement = (toAdd.count > 1 && toAdd[0].1 is PDFPageBreakObject) ? toAdd[1].1 : toAdd[0].1
        let offset = PDFCalculations.calculateContentOffset(for: generator, of: symbolTextElement, in: container)
        generator.setContentOffset(in: container, to: offset)

        return toAdd
    }

    private func createTextItem(generator: PDFGenerator, container: PDFContainer, text: String) throws -> [PDFLocatedRenderObject] {
        let itemText = PDFSimpleText(text: text)
        let itemTextObject = PDFAttributedTextObject(simpleText: itemText)
        return try itemTextObject.calculate(generator: generator, container: container)
    }

    /**
     Creates a new `PDFListObject` with the same properties
     */
    override internal var copy: PDFRenderObject {
        PDFListObject(list: self.list.copy)
    }
}
