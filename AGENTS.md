# Bug fixes and pull requests

- Investigate the issue and reproduce the bug before changing production code. Keep each fix focused.
- For a new PR, branch from freshly fetched `origin/main`. Stack only when the fix genuinely depends on an unmerged PR, and explain the dependency.
- Keep independent fixes in separate PRs. Do not carry unrelated commits or generated test artifacts into a PR.
- Commit, push, and open a PR only when requested. Create draft PRs by default.
- Describe the verified scope accurately. Use `Refs #…` rather than closing an issue when only one reported variant has been verified.

# Testing and verification

- Write new tests using Swift Testing (`import Testing`, `@Test`, and `#expect`) rather than XCTest or Quick/Nimble.
- Watch the regression fail before implementing the fix, then verify it passes. Cover relevant boundaries and unchanged behavior.
- For PDF rendering or pagination bugs, add generated-PDF integration coverage when practical, not just layout assertions.
- Use the Makefile. Run focused tests first, then `make test-macos`, `make lint`, and `git diff --check` before reporting completion.
- Test targets temporarily enable the flag in `Package.swift`. If initially disabled, restore it with `make test-disable` after testing.
- Report which platforms were tested and any remaining failures or diagnostics. Do not imply all-platform verification from macOS alone.
