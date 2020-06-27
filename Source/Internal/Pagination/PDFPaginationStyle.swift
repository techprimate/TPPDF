//
//  PDFPaginationStyle.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 13/06/2017.
//

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/**
  Use predefined pagination styles or create a custom one, using `.CustomNumberFormat` or `.CustomClosure`.

  Enums using a template String as parameter will replace the first instance of `%@` with the index and the second one with the total amount of pages.
 */
public enum PDFPaginationStyle {

    /**
     Default format, concats current page and total pages with a dash.

     e.g. Converts page 1 of 3 to **"1 - 3"**
     */
    case `default`

    /**
      Returns pagination in roman numerals.

      - parameter template: Template `String`, instances of `%@` will be replaced.
     */
    case roman(template: String)

    /**
     Formats pagination numbers using the `formatter` and formatting the string using the given `template`.

     - parameter template: Template string where `$@` is replaced
     - parameter formatter: Number formatter
     */
    case customNumberFormat(template: String, formatter: NumberFormatter)

    /**
     Formats the pagination using the provided closure
     */
    case customClosure(PDFPaginationClosure)

    /**
     Creates formatted pagination string.

     - parameter page: `Int` - Current page
     - parameter total: `Int` - Total amount of pages.

     - returns: Formatted `String`
     */
    public func format(page: Int, total: Int) -> String {
        switch self {
        case .default:
            return String(format: "%@ - %@", String(page), String(total))
        case .roman(let template):
            let romanIndex = page.romanNumerals
            let romanMax = total.romanNumerals

            return String(format: template, romanIndex, romanMax)
        case .customNumberFormat(let template, let formatter):
            let indexString = formatter.string(from: page as NSNumber)!
            let maxString = formatter.string(from: total as NSNumber)!

            return String(format: template, indexString, maxString)
        case .customClosure(let closure):
            return closure(page, total)
        }
    }
}
