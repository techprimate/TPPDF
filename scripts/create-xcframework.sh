#!/bin/bash
set -e

# Store current working directory
pushd $(pwd) >/dev/null
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

# 1. Archive the Swift Package for each platform
echo "Building XCFramework for iOS"
xcodebuild archive \
    -project TPPDF.xcodeproj \
    -scheme TPPDF \
    -destination "generic/platform=iOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-iOS.xcarchive" \
    -sdk iphoneos \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for iOS Simulator"
xcodebuild archive \
    -project TPPDF.xcodeproj \
    -scheme TPPDF \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$ARCHIVES_PATH/TPPDF-iOS-Simulator.xcarchive" \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

# echo "Building XCFramework for macOS"
xcodebuild archive \
    -project TPPDF.xcodeproj \
    -scheme TPPDF \
    -destination "generic/platform=macOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-macOS.xcarchive" \
    -sdk macosx \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for visionOS"
xcodebuild archive \
    -project TPPDF.xcodeproj \
    -scheme TPPDF \
    -destination "generic/platform=visionOS" \
    -archivePath "$ARCHIVES_PATH/TPPDF-visionOS.xcarchive" \
    -sdk xros \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

echo "Building XCFramework for visionOS Simulator"
xcodebuild archive \
    -project TPPDF.xcodeproj \
    -scheme TPPDF \
    -destination "generic/platform=visionOS Simulator" \
    -archivePath "$ARCHIVES_PATH/TPPDF-visionOS-Simulator.xcarchive" \
    -sdk xros \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcbeautify

# 2. Create XCFramework
if [ -d $OUTPUT_XCFRAMEWORK_PATH ]; then
    echo "Old XCFramework found, removing..."
    rm -r $OUTPUT_XCFRAMEWORK_PATH
fi

xcodebuild -create-xcframework \
    -output $OUTPUT_XCFRAMEWORK_PATH \
    \
    -framework $ARCHIVES_PATH/TPPDF-macOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols $ARCHIVES_PATH/TPPDF-macOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework $ARCHIVES_PATH/TPPDF-iOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols $ARCHIVES_PATH/TPPDF-iOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework $ARCHIVES_PATH/TPPDF-iOSSimulator.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols $ARCHIVES_PATH/TPPDF-iOS-Simulator.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework $ARCHIVES_PATH/TPPDF-visionOS.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols $ARCHIVES_PATH/TPPDF-visionOS.xcarchive/dSYMs/TPPDF.framework.dSYM \
    \
    -framework $ARCHIVES_PATH/TPPDF-visionOS-Simulator.xcarchive/Products/Library/Frameworks/TPPDF.framework \
    -debug-symbols $ARCHIVES_PATH/TPPDF-visionOS-Simulator.xcarchive/dSYMs/TPPDF.framework.dSYM

# 3. Create a ZIP and a SHA256 hash
echo "Creating ZIP archive"
ditto -c -k --keepParent $OUTPUT_XCFRAMEWORK_PATH $ARCHIVES_PATH/TPPDF.zip
sha256sum $ARCHIVES_PATH/TPPDF.zip >$ARCHIVES_PATH/TPPDF.sha256

# -- End Script --

# Return to original working directory
popd >/dev/null
