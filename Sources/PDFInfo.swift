//
//  PDFInfo.swift
//  TPPDF
//
//  Created by Zheng-Xiang Ke on 2016/12/15.
//
//

public class PDFInfo {
    
    public var title = "Title"
    public var author = "Author"
    public var subject = "Subject"
    public var keywords = ["tppdf", "pdf", "generator"]
    
    public var ownerPassword: String?
    public var userPassword: String?
    public var allowsPrinting = true
    public var allowsCopying = true
    
    public init() {}
    
    func generate() -> [AnyHashable : Any] {
        var documentInfo: [AnyHashable : Any] = [
            kCGPDFContextTitle as String: title,
            kCGPDFContextAuthor as String: author,
            kCGPDFContextSubject as String: subject,
            kCGPDFContextKeywords as String: keywords,
            kCGPDFContextAllowsPrinting as String: allowsPrinting,
            kCGPDFContextAllowsCopying as String: allowsCopying]
        
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
        
        if let ownerPassword = ownerPassword {
            documentInfo[kCGPDFContextOwnerPassword as String] = ownerPassword
        }
        
        if let userPassword = userPassword {
            documentInfo[kCGPDFContextUserPassword as String] = userPassword
        }
        
        return documentInfo
    }
    
}
