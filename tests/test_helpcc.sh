#!/bin/bash

# Test script for Help Command Center

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Test counter
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run a test
run_test() {
    local test_name=$1
    local test_command=$2
    local expected_output=$3

    echo "Running test: $test_name"
    
    # Run the test command and capture output
    local output=$($test_command)
    
    # Check if output matches expected
    if [[ "$output" == *"$expected_output"* ]]; then
        echo -e "${GREEN}✓ Test passed${NC}"
        ((TESTS_PASSED++))
    else
        echo -e "${RED}✗ Test failed${NC}"
        echo "Expected: $expected_output"
        echo "Got: $output"
        ((TESTS_FAILED++))
    fi
}

# Test basic functionality
run_test "Basic help command" "./helpcc_tui.sh --help" "Usage:"

# Test search functionality
run_test "Search command" "./helpcc_tui.sh --search test" "Search results"

# Print summary
echo -e "\nTest Summary:"
echo -e "${GREEN}Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Failed: $TESTS_FAILED${NC}"

# Exit with appropriate status
if [ $TESTS_FAILED -eq 0 ]; then
    exit 0
else
    exit 1
fi 