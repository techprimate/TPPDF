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
    
    override func calculate(generator: PDFGenerator, container: PDFContainer) throws {
//        let originalIndent = generator.indentation[container.normalize]!
//        
//        for item in list.flatted() {
//            let indent = (item.level < list.levelIndentations.count ?
//                list.levelIndentations[item.level] :
//                list.levelIndentations.last ?? (pre: 0, past: 0))
//            
//            indentation[container.normalize] = originalIndent + indent.pre
//            
//            let offset = getContentOffset(container)
//            
//            switch item.symbol {
//            case .dash, .dot:
//                //                try drawText(container, text: item.symbol.stringValue, spacing: 12, calculatingMetrics: calculatingMetrics)
//                break
//            case let .numbered(value):
//                //                try drawText(container, text: (value ?? "?") + ".", spacing: 12, calculatingMetrics: calculatingMetrics)
//                break
//            case let .custom(value):
//                //                try drawText(container, text: value, spacing: 12, calculatingMetrics: calculatingMetrics)
//                break
//            case .none, .inherit:
//                break
//            }
//            
//            setContentOffset(value: offset)
//            indentation[container.normalize] = originalIndent + indent.pre + indent.past
//            
//            //            try drawText(container, text: item.text, spacing: 12, calculatingMetrics: calculatingMetrics)
//            indentation[container.normalize] = originalIndent
//        }
    }
}
