import Danger
import Foundation

let danger = Danger()

// Changelog entries are required for changes to library files.
let allSourceFiles = danger.git.modifiedFiles + danger.git.createdFiles
let sourceChanges = allSourceFiles.contains { $0.hasPrefix("Source") }

// Make it more obvious that a PR is a work in progress and shouldn't be merged yet
if danger.github.pullRequest.title.contains("WIP") || danger.github.pullRequest.title.contains("Draft") {
    warn("PR is classed as Work in Progress")
}

// Warn when there is a big PR
if (danger.github.pullRequest.additions ?? 0) > 500 {
    warn("Big PR, try to keep changes smaller if you can")
}

// Warning message for not updated package manifest(s)
let manifests = [
    "Package.swift",
    "Package.resolved",
]
let updatedManifests = manifests.filter { manifest in danger.git.modifiedFiles.contains { $0.name == manifest } }
if !updatedManifests.isEmpty, updatedManifests.count != manifests.count {
    let notUpdatedManifests = manifests.filter { !updatedManifests.contains($0) }
    let updatedArticle = updatedManifests.count == 1 ? "The " : ""
    let updatedVerb = updatedManifests.count == 1 ? "was" : "were"
    let notUpdatedArticle = notUpdatedManifests.count == 1 ? "the " : ""

    warn("\(updatedArticle)\(updatedManifests.joined(separator: ", ")) \(updatedVerb) updated, " +
        "but there were no changes in \(notUpdatedArticle)\(notUpdatedManifests.joined(separator: ", ")).\n" +
        "Did you forget to update them?")
}

// Warn when library files has been updated but not tests.
let testsUpdated = allSourceFiles.contains { $0.hasPrefix("Tests/") }
if sourceChanges, !testsUpdated {
    warn("The library files were changed, but the tests remained unmodified. Consider updating or adding to the tests to match the library changes.")
}

// Run SwiftLint only on files in included paths (Source/ and Tests/)
let includedPaths = ["Source", "Tests"]
let changedSwiftFiles = (danger.git.modifiedFiles + danger.git.createdFiles)
    .filter { file in
        file.fileType == .swift && includedPaths.contains { file.hasPrefix($0) }
    }

if !changedSwiftFiles.isEmpty {
    SwiftLint.lint(inline: false, configFile: ".swiftlint.yml")
}
