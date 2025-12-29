# ============================================================================
# TPPDF MAKEFILE
# ============================================================================
# This Makefile provides automation for building, testing, and developing
# the TPPDF project. Run 'make help' to see all available commands.
# ============================================================================

.DEFAULT_GOAL := help

# ============================================================================
# CONFIGURATION
# ============================================================================

# Xcode scheme used to build TPPDF
XCODE_SCHEME = TPPDF

# iOS Simulator OS version (defaults to '26.2', can be overridden via IOS_SIMULATOR_OS=26.2)
IOS_SIMULATOR_OS ?= 26.2

# iOS Simulator device name (defaults to 'iPhone 17 Pro', can be overridden via IOS_DEVICE_NAME='iPhone 16 Pro')
IOS_DEVICE_NAME ?= iPhone 17 Pro

# tvOS Simulator OS version (defaults to '26.2', can be overridden via TVOS_SIMULATOR_OS=26.2)
TVOS_SIMULATOR_OS ?= 26.2

# tvOS Simulator device name (defaults to 'Apple TV 4K (3rd generation)', can be overridden via TVOS_DEVICE_NAME='Apple TV')
TVOS_DEVICE_NAME ?= Apple TV 4K (3rd generation)

# visionOS Simulator OS version (defaults to '26.2', can be overridden via VISION_OS_SIMULATOR_OS=26.2)
VISION_OS_SIMULATOR_OS ?= 26.2

# visionOS Simulator device name (defaults to 'Apple Vision Pro', can be overridden via VISION_OS_DEVICE_NAME='Apple Vision Pro')
VISION_OS_DEVICE_NAME ?= Apple Vision Pro

# watchOS Simulator OS version (defaults to '26.2', can be overridden via WATCHOS_SIMULATOR_OS=26.2)
WATCHOS_SIMULATOR_OS ?= 26.2

# watchOS Simulator device name (defaults to 'Apple Watch Series 11 (46mm)', can be overridden via WATCHOS_DEVICE_NAME='Apple Watch SE 3 (44mm)')
WATCHOS_DEVICE_NAME ?= Apple Watch Series 11 (46mm)

# ============================================================================
# SETUP
# ============================================================================

## Setup the project by installing dependencies, pre-commit hooks, rbenv, and bundler.
#
# Sets up a fresh machine for development by chaining the install tasks.
# Safe to re-run if you need to reinitialize dependencies or hooks.
.PHONY: setup
setup: install-dependencies install-pre-commit install-rbenv install-bundler

## Install the project dependencies using Homebrew.
#
# Installs all tools declared in the Brewfile.
.PHONY: install-dependencies
install-dependencies:
	brew bundle

## Install the pre-commit hooks.
#
# Installs repository git hooks to enforce formatting and checks before commits.
.PHONY: install-pre-commit
install-pre-commit:
	pre-commit install

## Install rbenv.
#
# Ensures the correct Ruby version is available for Bundler and Ruby-based tools.
.PHONY: install-rbenv
install-rbenv:
	rbenv install --skip-existing

## Install Bundler.
#
# Updates Bundler and installs all Ruby gems from the Gemfile.
.PHONY: install-bundler
install-bundler:
	rbenv exec gem update bundler
	rbenv exec bundle install

## Install dependencies for CI environment.
#
# Installs only the dependencies needed for continuous integration environments.
.PHONY: install-ci
install-ci:
	@$(MAKE) --no-print-directory install-dependencies

# ============================================================================
# BUILDING
# ============================================================================

## Build all targets for iOS, macOS, Mac Catalyst, tvOS, watchOS, and visionOS
#
# Convenience target that invokes all build targets.
# See build-ios, build-macos, build-maccatalyst, build-tvos, build-watchos, build-visionos for more details.
.PHONY: build
build: build-ios build-macos build-maccatalyst build-tvos build-watchos build-visionos

## Build framework target for latest iOS Simulator (iPhone 17 Pro)
#
# Builds the main framework for the latest iOS Simulator (iPhone 17 Pro).
# Outputs raw logs to raw-build-ios.log and pretty-prints with xcbeautify.
.PHONY: build-ios
build-ios:
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=iOS Simulator,OS=$(IOS_SIMULATOR_OS),name=$(IOS_DEVICE_NAME)' \
		build | tee raw-build-ios.log | xcbeautify --preserve-unbeautified

## Build framework target for latest macOS
#
# Builds the main framework for macOS.
# Outputs raw logs to raw-build-macos.log and pretty-prints with xcbeautify.
.PHONY: build-macos
build-macos:
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=macOS' \
		build | tee raw-build-macos.log | xcbeautify --preserve-unbeautified

## Build framework target for latest Mac Catalyst
#
# Builds the main framework for Mac Catalyst.
# Outputs raw logs to raw-build-maccatalyst.log and pretty-prints with xcbeautify.
.PHONY: build-maccatalyst
build-maccatalyst:
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=macOS,variant=Mac Catalyst' \
		build | tee raw-build-maccatalyst.log | xcbeautify --preserve-unbeautified

## Build framework target for latest tvOS Simulator
#
# Builds the main framework for the latest tvOS Simulator (Apple TV 4K 3rd generation).
# Outputs raw logs to raw-build-tvos.log and pretty-prints with xcbeautify.
.PHONY: build-tvos
build-tvos:
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=tvOS Simulator,OS=$(TVOS_SIMULATOR_OS),name=$(TVOS_DEVICE_NAME)' \
		build | tee raw-build-tvos.log | xcbeautify --preserve-unbeautified

## Build framework target for latest visionOS Simulator
#
# Builds the main framework for the latest visionOS Simulator (Apple Vision Pro).
# Outputs raw logs to raw-build-visionos.log and pretty-prints with xcbeautify.
.PHONY: build-visionos
build-visionos:
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=visionOS Simulator,OS=$(VISION_OS_SIMULATOR_OS),name=$(VISION_OS_DEVICE_NAME)' \
		build | tee raw-build-visionos.log | xcbeautify --preserve-unbeautified

## Build framework target for latest watchOS Simulator
#
# Builds the main framework for the latest watchOS Simulator (Apple Watch Series 11).
# Outputs raw logs to raw-build-watchos.log and pretty-prints with xcbeautify.
.PHONY: build-watchos
build-watchos:
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=watchOS Simulator,OS=$(WATCHOS_SIMULATOR_OS),name=$(WATCHOS_DEVICE_NAME)' \
		build | tee raw-build-watchos.log | xcbeautify --preserve-unbeautified

## Build XCFramework for all platforms
#
# Builds a universal XCFramework containing builds for iOS, macOS, Mac Catalyst, tvOS, watchOS, and visionOS.
# Uses the create-xcframework.sh script to perform the build.
.PHONY: build-xcframework
build-xcframework:
	./scripts/create-xcframework.sh

# ============================================================================
# TESTING
# ============================================================================

## Run all test suites for all platforms
#
# Runs all tests for TPPDF on iOS, macOS, Mac Catalyst, tvOS, watchOS, and visionOS.
# See test-ios, test-macos, test-maccatalyst, test-tvos, test-watchos, test-visionos for individual platform tests.
.PHONY: test
test: test-ios test-macos test-maccatalyst test-tvos test-watchos test-visionos

## Enable test targets by setting testing flag to true
#
# Modifies the Package.swift to set the testing flag to true, enabling test targets.
.PHONY: test-enable
test-enable:
	@echo "Setting testing flag to enable test targets..."
	@sed -i.bak 's|/\*TESTING_FLAG\*/false/\*TESTING_FLAG\*/|/\*TESTING_FLAG\*/true/\*TESTING_FLAG\*/|g' Package.swift
	@rm Package.swift.bak

## Disable test targets by setting testing flag to false
#
# Modifies the Package.swift to set the testing flag to false, disabling test targets.
.PHONY: test-disable
test-disable:
	@echo "Setting testing flag to disable test targets..."
	@sed -i.bak 's|/\*TESTING_FLAG\*/true/\*TESTING_FLAG\*/|/\*TESTING_FLAG\*/false/\*TESTING_FLAG\*/|g' Package.swift
	@rm Package.swift.bak

## Run unit tests for TPPDF on latest iOS Simulator
#
# Runs unit tests for the TPPDF scheme on the latest iOS Simulator (iPhone 17 Pro).
# Writes logs to raw-test-ios.log and formats output with xcbeautify.
.PHONY: test-ios
test-ios: build-ios test-enable
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=iOS Simulator,OS=$(IOS_SIMULATOR_OS),name=$(IOS_DEVICE_NAME)' \
		test | tee raw-test-ios.log | xcbeautify --preserve-unbeautified

## Run unit tests for TPPDF on macOS
#
# Runs unit tests for the TPPDF scheme on macOS.
# Writes logs to raw-test-macos.log and formats output with xcbeautify.
.PHONY: test-macos
test-macos: build-macos test-enable
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=macOS' \
		test | tee raw-test-macos.log | xcbeautify --preserve-unbeautified

## Run unit tests for TPPDF on Mac Catalyst
#
# Runs unit tests for the TPPDF scheme on Mac Catalyst.
# Writes logs to raw-test-maccatalyst.log and formats output with xcbeautify.
.PHONY: test-maccatalyst
test-maccatalyst: build-maccatalyst test-enable
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=macOS,variant=Mac Catalyst' \
		test | tee raw-test-maccatalyst.log | xcbeautify --preserve-unbeautified

## Run unit tests for TPPDF on latest tvOS Simulator
#
# Runs unit tests for the TPPDF scheme on the latest tvOS Simulator (Apple TV 4K 3rd generation).
# Writes logs to raw-test-tvos.log and formats output with xcbeautify.
.PHONY: test-tvos
test-tvos: build-tvos test-enable
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=tvOS Simulator,OS=$(TVOS_SIMULATOR_OS),name=$(TVOS_DEVICE_NAME)' \
		test | tee raw-test-tvos.log | xcbeautify --preserve-unbeautified

## Run unit tests for TPPDF on latest watchOS Simulator
#
# Runs unit tests for the TPPDF scheme on the latest watchOS Simulator (Apple Watch Series 11).
# Writes logs to raw-test-watchos.log and formats output with xcbeautify.
.PHONY: test-watchos
test-watchos: build-watchos test-enable
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=watchOS Simulator,OS=$(WATCHOS_SIMULATOR_OS),name=$(WATCHOS_DEVICE_NAME)' \
		test | tee raw-test-watchos.log | xcbeautify --preserve-unbeautified

## Run unit tests for TPPDF on latest visionOS Simulator
#
# Runs unit tests for the TPPDF scheme on the latest visionOS Simulator (Apple Vision Pro).
# Writes logs to raw-test-visionos.log and formats output with xcbeautify.
.PHONY: test-visionos
test-visionos: build-visionos test-enable
	set -o pipefail && NSUnbufferedIO=YES xcrun xcodebuild \
		-scheme $(XCODE_SCHEME) \
		-destination 'platform=visionOS Simulator,OS=$(VISION_OS_SIMULATOR_OS),name=$(VISION_OS_DEVICE_NAME)' \
		test | tee raw-test-visionos.log | xcbeautify --preserve-unbeautified

# ============================================================================
# FORMATTING
# ============================================================================

## Format Swift, Markdown, JSON and YAML files using project tools
#
# Runs all formatting tasks for all Swift, JSON, Markdown, and YAML files in the project.
.PHONY: format
format: format-swift format-json format-markdown format-yaml

## Format Swift sources and apply SwiftLint auto-fixes
#
# Runs SwiftLint to format and autofix Swift code.
.PHONY: format-swift
format-swift:
	swiftlint --config .swiftlint.yml --strict --fix

## Format all JSON files with dprint
#
# Runs dprint to format all JSON files.
.PHONY: format-json
format-json:
	dprint fmt "**/*.json"

## Format all Markdown files with dprint
#
# Runs dprint to format all Markdown files.
.PHONY: format-markdown
format-markdown:
	dprint fmt "**/*.md"

## Format all YAML files with dprint
#
# Runs dprint to format all YAML and YML files.
.PHONY: format-yaml
format-yaml:
	dprint fmt "**/*.{yaml,yml}"

## Run SwiftLint and dprint checks (no fixes)
#
# Runs SwiftLint and dprint checks without modifying files.
.PHONY: lint
lint:
	swiftlint --config .swiftlint.yml --strict --quiet
	dprint check "**/*.{md,json,yaml,yml}"

# ============================================================================
# DOCUMENTATION
# ============================================================================

## Generate documentation using Jazzy
#
# Generates documentation for the TPPDF project using Jazzy.
.PHONY: docs
docs:
	SDK_PATH=$$(xcrun --sdk iphonesimulator --show-sdk-path); \
	echo "SDK Path: $$SDK_PATH"; \
	SDK_VERSION=$$(xcrun --sdk iphonesimulator --show-sdk-version); \
	echo "SDK Version: $$SDK_VERSION"; \
	bundle exec jazzy --build-tool-arguments "--sdk,$$SDK_PATH,-Xswiftc,-sdk,-Xswiftc,$$SDK_PATH,-Xswiftc,-target,-Xswiftc,arm64-apple-ios$$SDK_VERSION-simulator"

# ============================================================================
# HELP
# ============================================================================

# Reusable awk script for detailed help output
define HELP_DETAIL_AWK
BEGIN { summary = ""; detailsCount = 0; printed = 0; lookingForDeps = 0 } \
/^## / { summary = substr($$0, 4); delete details; detailsCount = 0; next } \
/^#($$| )/ { \
	if (summary != "") { \
		line = $$0; \
		if (substr(line,1,2)=="# ") detailLine = substr(line,3); else detailLine = ""; \
		details[detailsCount++] = detailLine; \
	} \
	if (lookingForDeps && $$0 !~ /^#/) { lookingForDeps = 0 } \
	next \
} \
/^\.PHONY: / && summary != "" { \
	for (i = 2; i <= NF; i++) { \
		if ($$i == T) { \
			found = 1; \
			lookingForDeps = 1; \
			break \
		} \
	} \
	if (!found) { summary = ""; detailsCount = 0; delete details } \
	next \
} \
lookingForDeps && /^[A-Za-z0-9_.-]+[ \t]*:/ && $$0 !~ /^\.PHONY:/ && $$0 !~ /^\t/ && index($$0,"=")==0 { \
	raw = $$0; \
	split(raw, parts, ":"); \
	tn = parts[1]; \
	if (tn == T) { \
		depStr = substr(raw, index(raw, ":")+1); \
		gsub(/^[ \t]+|[ \t]+$$/, "", depStr); \
		firstDep = depStr; \
		split(depStr, depParts, /[ \t]+/); \
		if (length(depParts[1]) > 0) firstDep = depParts[1]; \
		lookingForDeps = 0; \
	} \
	next \
} \
found && !lookingForDeps { \
	printf "%s\n\n", summary; \
	for (j = 0; j < detailsCount; j++) { \
		if (length(details[j]) > 0) printf "%s\n", details[j]; else print ""; \
	} \
	print ""; \
	printf "Usage:\n"; \
	if (length(firstDep) > 0) { \
		printf "  make %s\n", firstDep; \
	} else { \
		printf "  make %s\n", T; \
	} \
	printed = 1; \
	found = 0; summary = ""; detailsCount = 0; delete details; firstDep = ""; \
	next \
} \
END { if (!printed) { printf "No detailed help found for target: %s\n", T } }
endef

## Show this help message with all available commands
#
# Displays a formatted list of all available make targets with descriptions.
# Commands are organized by topic for easy navigation.
.PHONY: help
help:
	@if [ -n "$(name)" ]; then \
		$(MAKE) --no-print-directory help-target name="$(name)"; \
	else \
		echo "=============================================="; \
		echo "🚀 TPPDF DEVELOPMENT COMMANDS"; \
		echo "=============================================="; \
		echo ""; \
		awk 'BEGIN { summary = ""; n = 0; maxlen = 0 } \
		/^## / { summary = substr($$0, 4); delete details; detailsCount = 0; next } \
		/^\.PHONY: / && summary != "" { \
			for (i = 2; i <= NF; i++) { \
				targets[n] = $$i; \
				summaries[n] = summary; \
				if (length($$i) > maxlen) maxlen = length($$i); \
				n++; \
			} \
			summary = ""; next \
		} \
		END { \
			for (i = 0; i < n; i++) { \
				printf "\033[36m%-*s\033[0m %s\n", maxlen, targets[i], summaries[i]; \
			} \
		}' $(MAKEFILE_LIST); \
		echo ""; \
		echo "💡 Use 'make <command>' to run any command above."; \
		echo "📖 For detailed help on a command, run: make help-<command>  (e.g., make help-build-ios)"; \
		echo "📖 Or: make help name=<command>      (e.g., make help name=build-ios)"; \
		echo ""; \
	fi

.PHONY: help-% help-target
help-%:
	@target="$*"; \
	awk -v T="$$target" '$(HELP_DETAIL_AWK)' $(MAKEFILE_LIST)

help-target:
	@[ -n "$(name)" ] || { echo "Usage: make help name=<target>"; exit 1; }; \
	awk -v T="$(name)" '$(HELP_DETAIL_AWK)' $(MAKEFILE_LIST)
