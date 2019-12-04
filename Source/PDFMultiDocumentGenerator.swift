//
//  PDFMultiDocumentGenerator.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04.12.2019
//

public class PDFMultiDocumentGenerator {

    private var documents: [PDFDocument]

    public let progress = Progress()
    public var debug = false

    public init(documents: [PDFDocument] = []) {
        self.documents = documents
    }

    public func add(document: PDFDocument) {
        self.documents.append(document)
    }

    public func generateURL(filename: String, info: PDFInfo = PDFInfo()) throws -> URL {
        let url = FileManager.generateTemporaryOutputURL(for: filename)
        try generate(into: url, info: info)
        return url
    }

    public func generate(into target: URL, info: PDFInfo = PDFInfo()) throws {
        assert(!documents.isEmpty, "At least one document is required!")
        UIGraphicsBeginPDFContextToFile(target.path, documents.first?.layout.bounds ?? .zero, info.generate())
        try processDocuments()
        UIGraphicsEndPDFContext()
    }

    public func generateData(info: PDFInfo = PDFInfo()) throws -> Data {
        assert(!documents.isEmpty, "At least one document is required!")
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, documents.first?.layout.bounds ?? .zero, info.generate())
        try processDocuments()
        UIGraphicsEndPDFContext()
        return data as Data
    }

    internal func processDocuments() throws {
        let objCounts = documents.map { $0.objects.count }

        for (idx, document) in documents.enumerated() {
            let generator = PDFGenerator(document: document)
            progress.addChild(generator.progress, withPendingUnitCount: Int64(objCounts[idx]))
            generator.debug = debug
            try generator.generatePDFContext()
        }
    }
}
