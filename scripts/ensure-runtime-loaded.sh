#!/bin/bash
set -euo pipefail

# Parse named arguments
OS_VERSION=""
PLATFORM=""

usage() {
    echo "Usage: $0 --os-version <os_version> --platform <platform>"
    echo "  OS version: Version to ensure is loaded (e.g., 26.1 for beta, 16.4 for older iOS)"
    echo "  Platform: Platform to ensure is loaded (e.g., iOS, tvOS, visionOS)"
    echo "  Example: $0 --os-version 26.1 --platform iOS"
    echo "  Example: $0 --os-version 16.4"
    exit 1
}

while [[ $# -gt 0 ]]; do
    case $1 in
        --os-version)
            OS_VERSION="$2"
            shift 2
            ;;
        --platform)
            PLATFORM="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1"
            usage
            ;;
    esac
done

if [ -z "$OS_VERSION" ]; then
    echo "Error: --os-version argument is required"
    usage
fi

if [ -z "$PLATFORM" ]; then
    echo "Error: --platform argument is required"
    usage
fi

check_runtime_loaded() {
    echo "Checking if runtime $PLATFORM ($OS_VERSION) is loaded..."
    RUNTIMES=$(xcrun simctl list runtimes -v)

    echo "Available runtimes:"
    echo "$RUNTIMES"

    if echo "$RUNTIMES" | grep -qE "$PLATFORM $OS_VERSION" && ! echo "$RUNTIMES" | grep -qE "$PLATFORM $OS_VERSION.*unavailable" ; then
        echo "Runtime $OS_VERSION is loaded"
        exit 0
    fi
    echo "Runtime $OS_VERSION is not loaded"
}

reload_runtime() {
    echo "Reloading runtime $PLATFORM ($OS_VERSION)..."

    echo "Unloading CoreSimulator services volumes"
    for dir in /Library/Developer/CoreSimulator/Volumes/*; do
        echo "Ejecting $dir"
        sudo diskutil unmount force "$dir" || true
    done

    echo "Killing CoreSimulator services to force reload..."
    sudo launchctl kill -9 system/com.apple.CoreSimulator.simdiskimaged || true
    sudo pkill -9 com.apple.CoreSimulator.CoreSimulatorService || true

    echo "Killed all CoreSimulator services"
}

wait_for_runtime() {
    echo "Wait for a runtime to be loaded"
    count=0
    MAX_ATTEMPTS=60 # 300 seconds (5 minutes) timeout
    while [ $count -lt $MAX_ATTEMPTS ]; do
        check_runtime_loaded
        echo "Waiting for runtime $OS_VERSION to be loaded... attempt $count"
        count=$((count + 1))
        sleep 5
    done
    echo "Exceeded maximum attempts ($MAX_ATTEMPTS) to check for runtime"
}

check_runtime_loaded
reload_runtime
wait_for_runtime

echo "Runtime $PLATFORM ($OS_VERSION) is not loaded after reload attempts"
exit 1
