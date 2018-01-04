#!/bin/sh

# Go to root of Mbed OS
cd $(dirname $0)/..

# Clean up previous files
lcov -q -z -d .
rm -rf coverage
rm -f unittests.txt

# Find all tests
tests=($(find UNITTESTS -name unittest.mk))

echo "Building unittests"
for test in ${tests[@]};do
    make -s -f $test CPPUTEST_C_WARNINGFLAGS="" CPPUTEST_CXX_WARNINGFLAGS="" all_no_tests || exit $?
done

echo
echo "Running unittests"

# Then run
for test in ${tests[@]};do
    make -f $test TEST_OUTPUT=unittests.txt vtest
done


# Generate html coverage report
echo "Generating coverage file"
mkdir -p coverage
lcov -q --capture --directory . --output-file coverage/coverage.info
lcov -q -r coverage/coverage.info "/usr/*" -o coverage/coverage.info
lcov -q -r coverage/coverage.info "*/UNITTESTS/*" -o coverage/coverage.info
genhtml -q coverage/coverage.info --output-directory coverage

echo "Done"
echo

grep "error: Failure" unittests.txt
RET=$?

echo "Please see unittests.txt and coverage/index.html for results"
echo

if [ $RET -eq 0 ]; then
	echo "Test failed"
	exit 1
else
	echo
	echo PASS
fi
