#!/bin/sh

# Go to root of Mbed OS
cd $(dirname $0)/..

# Clean up previous files
test -d objs && find objs -name "*.gcda"| xargs rm -f
rm -f coverage*.html
rm -f unittests.txt

# Find all tests
tests=($(find UNITTESTS -name unittest.mk))

echo "Building unittests"
for test in ${tests[@]};do
    make -s -f $test CPPUTEST_C_WARNINGFLAGS="" CPPUTEST_CXX_WARNINGFLAGS="" TEST_OUTPUT=unittests.txt all_no_tests
done

echo
echo "Running unittests"

# Then run
for test in ${tests[@]};do
    make -f $test TEST_OUTPUT=unittests.txt vtest
done


# Generate html coverage report
echo "Generating coverage file"
gcovr -d -r . -e UNITTESTS --html --html-detail -o coverage.html

echo "Done"
echo

grep "error: Failure" unittests.txt

echo
echo "Please see unittests.txt and coverage.html for results"
echo
