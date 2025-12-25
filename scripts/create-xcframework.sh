#!/bin/bash
set -e

# Store current working directory
pushd "$(pwd)" >/dev/null
# Change to script directory
cd "${0%/*}"

# -- Begin Script --

# Navigate to the project directory
cd ../

# 0. Prepare for commands

# Required for xcbeautify to report xcodebuild exit status
set -o pipefail

ARCHIVES_PATH="$(pwd)/archives"
OUTPUT_XCFRAMEWORK_PATH="$ARCHIVES_PATH/TPPDF.xcframework"

echo "Tool Versions:"
echo " - xcodebuild: $(xcodebuild -version)"
echo " - swift: $(swift --version)"

echo "Available SDKs:"
xcodebuild -showsdks

echo "Available Destinations:"
xcodebuild -showdestinations -project TPPDF.xcodeproj -scheme TPPDF

echo "Available Simulators:"
xcrun simctl list devices

echo "Selected SDK Info:"
echo " - Path: $(xcrun -show-sdk-path)"
echo " - Version: $(xcrun -show-sdk-version)"
echo " - Build Version: $(xcrun -show-sdk-build-version)"
echo " - Platform Path: $(xcrun -show-sdk-platform-path)"
echo " - Platform Version: $(xcrun -show-sdk-platform-version)"

# 1. Archive the Swift Package for each platform
echo "Building XCFramework for iOS"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=iOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-iOS.xcarchive" \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for iOS Simulator"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$ARCHIVES_PATH/TPPDF-iOS-Simulator.xcarchive" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for macOS"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=macOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-macOS.xcarchive" \
    -sdk macosx \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for Mac Catalyst"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=macOS,variant=Mac Catalyst" \
    -archivePath "$ARCHIVES_PATH/TPPDF-Mac-Catalyst.xcarchive" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for tvOS"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=tvOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-tvOS.xcarchive" \
    -sdk appletvos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for tvOS Simulator"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=tvOS Simulator" \
    -archivePath "$ARCHIVES_PATH/TPPDF-tvOS-Simulator.xcarchive" \
    -sdk appletvsimulator \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for watchOS"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=watchOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-watchOS.xcarchive" \
    -sdk watchos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for watchOS Simulator"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=watchOS Simulator" \
    -archivePath "$ARCHIVES_PATH/TPPDF-watchOS-Simulator.xcarchive" \
    -sdk watchsimulator \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for visionOS"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=visionOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-visionOS.xcarchive" \
    -sdk xros \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for visionOS Simulator"
xcodebuild archive \
    -scheme TPPDF \
    -destination "generic/platform=visionOS Simulator" \
    -archivePath "$ARCHIVES_PATH/TPPDF-visionOS-Simulator.xcarchive" \
    -sdk xrsimulator \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

# 2. Create XCFramework
if [ -d "$OUTPUT_XCFRAMEWORK_PATH" ]; then
    echo "Old XCFramework found, removing..."
    rm -r "$OUTPUT_XCFRAMEWORK_PATH"
fi

echo "Tree of archives:"
tree archives

xcodebuild -create-xcframework \
    -output "$OUTPUT_XCFRAMEWORK_PATH" \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-macOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-macOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-Mac-Catalyst.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-Mac-Catalyst.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-iOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-iOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-iOS-Simulator.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-iOS-Simulator.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-tvOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-tvOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-tvOS-Simulator.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-tvOS-Simulator.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-watchOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-watchOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-watchOS-Simulator.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-watchOS-Simulator.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-visionOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-visionOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework "$ARCHIVES_PATH"/TPPDF-visionOS-Simulator.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols "$ARCHIVES_PATH"/TPPDF-visionOS-Simulator.xcarchive/dSYMs/TPPDF.framework.dSYM

# 3. Create a ZIP and a SHA256 hash
echo "Creating ZIP archive"
ditto -c -k --keepParent "$OUTPUT_XCFRAMEWORK_PATH" "$ARCHIVES_PATH"/TPPDF.zip

echo "Creating SHA256 hash"
shasum -a 256 "$ARCHIVES_PATH"/TPPDF.zip >"$ARCHIVES_PATH"/TPPDF.sha256

# 4. Summary
echo "XCFramework created at $OUTPUT_XCFRAMEWORK_PATH"
echo "ZIP archive created at $ARCHIVES_PATH/TPPDF.zip"
echo "SHA256 hash created at $ARCHIVES_PATH/TPPDF.sha256"

# -- End Script --

# Return to original working directory
popd >/dev/null
