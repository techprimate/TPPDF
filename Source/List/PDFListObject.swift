//
//  PDFListObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12/08/2017.
//
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
            let indent = (item.level < list.levelIndentations.count ?
                list.levelIndentations[item.level] :
                list.levelIndentations.last ?? (pre: 0, past: 0))
            generator.layout.indentation.setLeft(indentation: originalLeftIndent + indent.pre, in: container)

            let offset = generator.getContentOffset(in: container)

            let symbol: String = {
                switch item.symbol {
                case .dash, .dot:
                    return item.symbol.stringValue
                case let .numbered(value):
                    return (value ?? "?") + "."
                case let .custom(value):
                    return value
                case .none, .inherit:
                    return ""
                }
            }()

            let symbolText = PDFSimpleText(text: symbol)
            let symbolTextObject = PDFAttributedTextObject(simpleText: symbolText)
            result += try symbolTextObject.calculate(generator: generator, container: container)

            generator.setContentOffset(in: container, to: offset)

            generator.layout.indentation.setLeft(indentation: originalLeftIndent + indent.pre + indent.past, in: container)

            let itemText = PDFSimpleText(text: item.text)
            let itemTextObject = PDFAttributedTextObject(simpleText: itemText)
            result += try itemTextObject.calculate(generator: generator, container: container)

            generator.layout.indentation.setLeft(indentation: originalLeftIndent, in: container)
        }

        return result
    }
}
