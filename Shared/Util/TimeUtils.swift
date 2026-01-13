//
//  TimeUtils.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 18.12.2019.
//  Copyright © 2016-2025 techprimate GmbH. All rights reserved.
//

import Foundation

enum TimeUtils {
    /**
     Used for debugging execution time.
     Converts time interval in seconds to String.
     */
    static func stringFromTimeInterval(interval: TimeInterval) -> String {
        let ns = (interval * 10e8).truncatingRemainder(dividingBy: 10e5)
        let ms = (interval * 10e2).rounded(.towardZero)
        let seconds = interval.rounded(.towardZero)
        let minutes = (interval / 60).rounded(.towardZero)
        let hours = (interval / 3600).rounded(.towardZero)

        var result = [String]()
        if hours > 1 {
            result.append(String(format: "%.0f", hours) + "h")
        }
        if minutes > 1 {
            result.append(String(format: "%.0f", minutes) + "m")
        }
        if seconds > 1 {
            result.append(String(format: "%.0f", seconds) + "s")
        }
        if ms > 1 {
            result.append(String(format: "%.0f", ms) + "ms")
        }
        if ns > 0.001 {
            result.append(String(format: "%.3f", ns) + "ns")
        }
        return result.joined(separator: " ")
    }
}
