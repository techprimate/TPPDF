#!/usr/bin/env bash
# Check that testing dependencies are not accidentally committed

has_error=0

for file in "$@"; do
    if [[ "$file" == "Package.swift" ]]; then
        if grep -q 'isTestingEnabled = /\*TESTING_FLAG\*/true/\*TESTING_FLAG\*/' "$file"; then
            echo "ERROR: Package.swift has testing enabled."
            echo "Please set isTestingEnabled to false before committing."
            has_error=1
        fi
    fi

    if [[ "$file" == "Package.resolved" ]]; then
        echo "ERROR: Package.resolved should not be committed."
        echo "Please unstage this file with: git reset HEAD Package.resolved"
        has_error=1
    fi
done

exit $has_error
