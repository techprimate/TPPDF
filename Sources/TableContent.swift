//
//  TableContent.swift
//  Pods
//
//  Created by Philip Niedertscheider on 13/06/2017.
//
//

import Foundation
import UIKit

open class TableContent {
    
    enum ContentType {
        case string
        case image
    }
    
    var type: ContentType
    var content: Any?
    
    public init(content: Any) {
        if content is String {
            self.type = ContentType.string
        } else if content is UIImage {
            self.type = ContentType.image
        } else {
            fatalError("Not implemented!")
        }
        self.content = content
    }
    
    var isString: Bool {
        return type == .string
    }
    
    var isImage: Bool {
        return type == .image
    }
    
    var stringValue: String? {
        return type == .string ? content as? String : nil
    }
    
    var imageValue: UIImage? {
        return type == .image ? content as? UIImage : nil
    }
}
