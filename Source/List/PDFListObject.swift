//
//  PDFListObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//

class PDFListObject: PDFObject {

    var list: PDFList

    init(list: PDFList) {
        self.list = list
    }

    override func calculate(generator: PDFGenerator, container: PDFContainer) throws -> [(PDFContainer, PDFObject)] {
        var result: [(PDFContainer, PDFObject)] = []

        let originalLeftIndent = generator.layout.indentation.leftIn(container: container)

        for item in list.flatted() {
            let indent = item.level < list.levelIndentations.count ?
                list.levelIndentations[item.level] :
                list.levelIndentations.last ?? (pre: 0, past: 0)
            generator.layout.indentation.setLeft(indentation: originalLeftIndent + indent.pre, in: container)

            let symbol: String = item.symbol.stringValue

            let symbolText = PDFSimpleText(text: symbol)
            let symbolTextObject = PDFAttributedTextObject(simpleText: symbolText)
            let toAdd = try symbolTextObject.calculate(generator: generator, container: container)

            if toAdd.count > 0 {
                let symbolTextElement = (toAdd.count > 1 && toAdd[0].1 is PDFPageBreakObject) ? toAdd[1].1 : toAdd[0].1
                generator.setContentOffset(in: container, to: PDFCalculations
                    .calculateContentOffset(for: generator, of: symbolTextElement, in: container))

                result += toAdd
            }

            generator.layout.indentation.setLeft(indentation: originalLeftIndent + indent.pre + indent.past, in: container)

            let itemText = PDFSimpleText(text: item.text)
            let itemTextObject = PDFAttributedTextObject(simpleText: itemText)
            result += try itemTextObject.calculate(generator: generator, container: container)

            generator.layout.indentation.setLeft(indentation: originalLeftIndent, in: container)
        }

        return result
    }

    override var copy: PDFObject {
        return PDFListObject(list: self.list.copy)
    }
}
