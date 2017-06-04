//
//  PDFGenerator+DocumentInfo.swift
//  Pods
//
//  Created by Philip Niedertscheider on 05/06/2017.
//
//

extension PDFGenerator {
    
    func generateDocumentInfo() -> [AnyHashable : Any] {
        var documentInfo: [AnyHashable : Any] = [
            kCGPDFContextTitle as String: info.title,
            kCGPDFContextAuthor as String: info.author,
            kCGPDFContextSubject as String: info.subject,
            kCGPDFContextKeywords as String: info.keywords,
            kCGPDFContextAllowsPrinting as String: info.allowsPrinting,
            kCGPDFContextAllowsCopying as String: info.allowsCopying]
        
        var creator = ""
        if let bundleName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            creator += bundleName
            
            if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                creator += " v" + version
            }
        }
        if !creator.isEmpty {
            documentInfo[kCGPDFContextCreator as String] = creator
        }
        
        if let ownerPassword = info.ownerPassword {
            documentInfo[kCGPDFContextOwnerPassword as String] = ownerPassword
        }
        
        if let userPassword = info.userPassword {
            documentInfo[kCGPDFContextUserPassword as String] = userPassword
        }
        
        return documentInfo
    }
}
