//
//  ExampleLaunchTests.swift
//  TPPDF
//
//  Created by Philip Niedertscheider on 12.10.2026.
//  Copyright © 2016-2026 techprimate GmbH. All rights reserved.
//

import XCTest

final class ExampleLaunchTests: XCTestCase {
    @MainActor
    func testAppLaunchesWithoutErrors() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        defer { app.terminate() }

        XCTAssertTrue(app.navigationBars["Examples"].waitForExistence(timeout: 10))
        XCTAssertEqual(app.state, .runningForeground)
        XCTAssertFalse(app.alerts.firstMatch.exists)
        XCTAssertFalse(app.staticTexts.matching(
            NSPredicate(format: "label BEGINSWITH %@", "Generation failed:")
        ).firstMatch.exists)
    }
}
