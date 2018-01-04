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

filter_coveragefile() {
    lcov -q -r $1 "/usr/*" -o $1 --config-file UNITTESTS/lcovrc
    lcov -q -r $1 "*/UNITTESTS/*" -o $1 --config-file UNITTESTS/lcovrc
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

    # Create baseline zero coverage
    mkdir -p coverage
#    lcov -q --capture --initial --directory objs --output-file coverage/coverage.base
#    filter_coveragefile coverage/coverage.base

    # Then run
    for test in ${tests[@]};do
        testname=$(dirname $test | sed -e 's/\//_/g' -e 's/UNITTESTS_//' )
        lcov -q -z -d objs
        make -f $test TEST_OUTPUT=unittests.tmp vtest
        # collect coverage
        lcov -q --capture --directory objs --output-file coverage/$testname.info -t $testname --config-file UNITTESTS/lcovrc
        filter_coveragefile coverage/$testname.info
        # Generate test info
        echo $testname | sed 's/\//_/' >> coverage/tests.txt
        sed 's/\(.\+\)/    \1<br>/' unittests.tmp >> coverage/tests.txt
        cat unittests.tmp >> unittests.txt
    done
}

generate_report() {
    # Generate html coverage report
    echo "Generating coverage file"
    gendesc coverage/tests.txt -o coverage/tests.desc
    genhtml -q -d coverage/tests.desc --config-file UNITTESTS/lcovrc --show-details --demangle-cpp --output-directory coverage coverage/*.info
}

print_usage() {
    echo
    echo "$0 [-h] build|run|clean [name]"
    echo "    -h: Print help and exit"
    echo "    build: Build unittest but don't run"
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
do_run=1
#
# Parse command line parameters
#
while [ ! -z $1 ]; do
    case "$1" in
        -h)
            print_usage
            exit
            ;;
        build)
            BUILD_CMD="all_no_tests"
            do_run=0
            ;;
        run)
            BUILD_CMD="all_no_tests"
            do_run=1
            ;;
        clean)
            BUILD_CMD="clean"
            do_run=0
            ;;
        *)
            tests=($(find_tests $1))
            ;;
    esac
    shift
done

clean_reports
build_tests
if [ $do_run -eq 0 ]; then
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
