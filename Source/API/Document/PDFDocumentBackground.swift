//
//  PDFDocumentBackground.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 25.08.2021.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

/// Document background configuration
public struct PDFDocumentBackground {
    /**
     * Color used to fill the background on every page.
     *
     * Defaults to `nil`, which results in a transparent background
     */
    public var color: Color?
}
