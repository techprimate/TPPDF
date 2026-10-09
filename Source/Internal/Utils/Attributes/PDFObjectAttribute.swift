//
//  PDFObjectAttribute.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 19.12.2019.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import Foundation

/**
 List of attributes an object can obtain
 */
public enum PDFObjectAttribute: Hashable {
    /**
     Adds a clickable link with a redirection to the given URL
     */
    case link(url: URL)
}
