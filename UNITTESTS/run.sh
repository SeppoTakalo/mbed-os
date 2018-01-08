#!/bin/sh

# Go to root of Mbed OS
cd $(dirname $0)/..

tests=()
BUILD_CMD="all_no_tests"


clean_reports() {
    # Clean up previous files
    lcov -q -z -d .
    rm -rf coverage
    rm -f unittests.txt
}

find_tests() {
    if [ ! -z $1 ]; then
        find UNITTESTS -name unittest.mk | grep $1
    else
        find UNITTESTS -name unittest.mk
    fi
}

build_tests() {
    echo "Building unittests"
    for test in ${tests[@]};do
        make -s -f $test CPPUTEST_C_WARNINGFLAGS="" CPPUTEST_CXX_WARNINGFLAGS="" $BUILD_CMD || exit $?
    done
}

run_tests() {
    echo
    echo "Running unittests"

    # Then run
    for test in ${tests[@]};do
        make -f $test TEST_OUTPUT=unittests.txt vtest
    done
}

generate_report() {
    # Generate html coverage report
    echo "Generating coverage file"
    mkdir -p coverage
    lcov -q --capture --directory . --output-file coverage/coverage.info
    lcov -q -r coverage/coverage.info "/usr/*" -o coverage/coverage.info
    lcov -q -r coverage/coverage.info "*/UNITTESTS/*" -o coverage/coverage.info
    genhtml -q coverage/coverage.info --output-directory coverage
}

print_usage() {
    echo
    echo "$0 [-h] run|clean [name]"
    echo "    -h: Print help and exit"
    echo "    run: Build & run unittests"
    echo "    clean: Clean up the builds without running"
    echo "    name: Expression to match against test directories"
    echo
    echo "Examples:"
    echo "to run all tests: $0 run"
    echo "to run tests matching Socket: $0 run Socket"
    echo "to exactly match path: $0 run features/netsocket/TCPSocket"
}

if [ -z $1 ]; then
    print_usage
    exit
fi

tests=($(find_tests))

#
# Parse command line parameters
#
while [ ! -z $1 ]; do
    case "$1" in
        -h)
            print_usage
            exit
            ;;
        run)
            BUILD_CMD="all_no_tests"
            ;;
        clean)
            BUILD_CMD="clean"
            ;;
        *)
            tests=($(find_tests $1))
            ;;
    esac
    shift
done

clean_reports
build_tests
if [ $BUILD_CMD == "clean" ]; then
    exit
fi
run_tests
generate_report

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
