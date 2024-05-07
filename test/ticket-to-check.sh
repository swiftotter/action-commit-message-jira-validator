#!/bin/bash

declare -A messages_and_expected_results=(
    ["ABC-123 ticket number at the beginning"]="ABC-123"
    ["ticket number ABC-123 in between"]="ABC-123"
    ["ticket number at the end ABC-123"]="ABC-123"
    ["0AB-222 ticket number with digits in project code"]="0AB-222"
    ["ABC-DEF ticket number with no digits"]=""
    ["no ticket number"]=""
    ["ticket number in the second line
    ABC-123"]=""
)

process_message() {
    local message="$1"
    echo $(echo "$message" | sed -n '1p' | tr '[a-z]' '[A-Z]' | sed -nE 's/.*(^|\W)([A-Z0-9]+-[0-9]+).*$/\2/p')
}

for message in "${!messages_and_expected_results[@]}"; do
    expected="${messages_and_expected_results[$message]}"
    actual=$(process_message "$message")

    if [[ "$actual" == "$expected" ]]; then
        echo "✅ '$message'"
    else
        echo "❌ '$message' - Expected: $expected, Actual: $actual"
    fi
done
