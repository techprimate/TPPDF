//
//  PDFTaggableObject.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 04.12.20.
//  Copyright © 2020 Philip Niedertscheider. All rights reserved.
//

/// Object can be identified using the `tag` property
public protocol PDFTaggableObject {

    /// An integer that you can use to identify document objects in your application.
    ///
    /// The default value is 0. You can set the value of this tag and use that value to identify the object later.
    var tag: Int { get set }

}
