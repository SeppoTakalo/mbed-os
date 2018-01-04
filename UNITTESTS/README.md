# Unit testing Mbed OS

This document describes the methods of running and writing unit tests for Mbed OS.

## Different levels of testing

Traditional software testing often described as a pyramid:

```
^ Testing level
|
|       /\
|      /  \       System testing
|     /----\
|    /      \     Integration testing
|   /--------\
|  /          \   Unit testing
| /------------\
|
*-------------------> Amount of tests

```

Integration and system testing are performed in an environment with full Mbed OS included in the build.

Unit testing takes place in a build environment where specific C++ classes or modules are
separated from the build into an isolated test binary. All accesss outside is stubbed to
remove dependency of any specific hardware or software combination.

For example, when testing an imaginary `myClass.cpp`, the test environment would look like this:

```
+-----------+
| Unit test | ....................
+-----------+                    .
  |      | input                 . #include
  |      v                       .
 c|   +--------------+           v
 o|   | myClass.cpp  | ....> /---------\
 n|   +--------------+       | headers |
 t|   | + int func() |       \---------/
 r|   | # int var    |
 o|   +--------------+
 l|      |
  v      v
+-----------+
| Stubs     |
+-----------+
```

This allows each class to be quickly tested in a build machine using native compilers. Added benefit is the ability to use tools like [GCOV](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html), [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) and [Valgrind](http://valgrind.org/) to capture test coverage and memory usage.

## Required tools

* A POSIX compatible development machine.
* GNU toolchains installed.
* LCOV installed.
* [Cpputest](http://cpputest.github.io/) installed.

### Installing dependencies on Debian/Ubuntu

```
sudo apt-get install build-essential cpputest lcov
```

### Installing dependencies on Mac OS X

**Prerequisites:**

* [Homebrew](https://brew.sh/) installed.
* X Code command line tools installed. (`xcode-select --install`)

```
brew install cpputest lcov
```

## Running unit tests

From the root folder of the Mbed OS, call `./UNITTESTS/run.sh run`.

This generates output similar to this:

```
mbed-os$ ./UNITTESTS/run.sh run
Building unittests

...clip: removed compilation messages ...

Running unittests
Running NetworkInterface_tests
TEST(NetworkInterface, get_mac_address) - 0 ms
TEST(NetworkInterface, constructor) - 0 ms

OK (2 tests, 2 ran, 2 checks, 0 ignored, 0 filtered out, 0 ms)

Running Socket_tests
...clip: removed test messages ...


OK (1 tests, 1 ran, 1 checks, 0 ignored, 0 filtered out, 0 ms)

Generating coverage file
Done

Please see unittests.txt and coverage/index.html for results


PASS

```

There are two clear steps. The first step builds the test, the second runs all the tests.

The output of the test run is visible on the screen but it is also captured in the `unittests.txt` file.

For the code coverage, you can view the `coverage/index.html` in an HTML browser.

### Parameters to run.sh

To fine tune the steps, you can use the following parameters for the `run.sh`:

```
./UNITTESTS/run.sh [-h] run|clean [name]
    -h: Print help and exit
    run: Build & run unittests
    clean: Clean up the builds without running
    name: Expression to match against test directories
```

|Parameter|Meaning|
|---------|-------|
| `-h`    | Output the help message. |
| `run`   | Build and run all tests. Optionally filtered by `name`. |
| `clean` | Clean the previous build output. |
| `name`  | Regular expression pattern to match against test paths. Can be used to filter by class name or partial path. |

**Examples:**

* To run all tests: `./UNITTESTS/run.sh run`
* To run tests matching word *Socket* : `./UNITTESTS/run.sh run Socket`
* To exactly match the path: `./UNITTESTS/run.sh run features/netsocket/TCPSocket`

## The structure of unit tests

The structure of the unit tests directory looks like this:

```
UNITTESTS
  ├── run.sh                                 Root level helper scripts
  ├── MakefileWorker.mk
  ├── README.md
  ├── unittest_main.cpp                      Common main file used in all tests
  │
  ├── features
  │   └── netsocket                          Directory tree that mirrors Mbed OS root
  │       ├── NetworkInterface               Name of the class to be tested
  │       │   ├── test_NetworkInterface.cpp
  │       │   └── unittest.mk                Makefile for unit test
  │       └── Socket
  │
  ├── stubs                                  Stubs used in tests.
  └── template                               Templates for quickly generating unittest tree
```

There are couple of root level helper files that should not need to be modified by the developers. Each unittest has an identical directory tree as seen in the Mbed OS root folder. This is not a mandatory requirement but helps to maintain tests. Each class to be tested have their own `unittest.mk` which is found by `run.sh`.

The `[name]` parameter can be used to match the path that leads to `unittest.mk`. The `run.sh` script uses the GREP tool to match the full path of `unittest.mk` file, starting from the root of Mbed OS.

For example, to match the tests for the NetworkInterface class, you can use the following expressions:

|`[name]` pattern|matches|
|-------|-------|
|`features/netsocket/NetworkInterface`| Only the Networkinterface class. |
|`features/netsocket` | Everything under netsocket, including NetworkInterface. |
|`netsocket/NetworkInterface` | All paths that have sequence `netsocket/NetworkInterface` in them.|
|`NetworkInterface` | All paths that have the word NetworkInterface. |

## Creating a unit test

To create a unit test example for `rtos/Semaphore.cpp`, follow these steps:

1. To generate the templates for the build, call `./UNITTESTS/generate.sh rtos/Semaphore.cpp` or create the following directories/files manually. (For this example, do the steps manually.)
    1. Create the diretory tree `UNITTESTS/rtos/Semaphore`.
    2. Create `UNITTESTS/rtos/Semaphore/unittest.mk` with the following content:

        ```
        include UNITTESTS/makefile_defines.txt
    
        COMPONENT_NAME = Semaphore
    
        SRC_FILES = \
            UNITTESTS/unittest_main.cpp \
            rtos/Semaphore.cpp
    
        TEST_SRC_FILES = \
            UNITTESTS/rtos/Semaphore/test_Semaphore.cpp
    
        include UNITTESTS/MakefileWorker.mk
        ```

        <span class="notes">**Note:** All paths are relative to Mbed OS root.</span>

    3. Create a file `UNITTESTS/rtos/Semaphore/test_Semaphore.cpp`.

        ```
        #include "CppUTest/TestHarness.h"
        #include "rtos/Semaphore.h"


        TEST_GROUP(Semaphore)
        {
            rtos::Semaphore *sem;

            void setup() {
                sem = new rtos::Semaphore;
            }

            void teardown() {
                delete sem;
            }
        };

        TEST(Semaphore, constructor)
        {
            CHECK(sem);
        }
        ```

    And this would be enough files to get it building. But not enough to actually pass the build. You should get following build failures:

    ```
    compiling test_Semaphore.cpp
    Linking Semaphore_tests
    Undefined symbols for architecture x86_64:
      "_mbed_assert_internal", referenced from:
          rtos::Semaphore::constructor(int, unsigned short) in Semaphore.o
      "_osSemaphoreAcquire", referenced from:
          rtos::Semaphore::wait(unsigned int) in Semaphore.o
      "_osSemaphoreDelete", referenced from:
          rtos::Semaphore::~Semaphore() in Semaphore.o
      "_osSemaphoreGetCount", referenced from:
          rtos::Semaphore::wait(unsigned int) in Semaphore.o
      "_osSemaphoreNew", referenced from:
          rtos::Semaphore::constructor(int, unsigned short) in Semaphore.o
      "_osSemaphoreRelease", referenced from:
          rtos::Semaphore::release() in Semaphore.o
    ld: symbol(s) not found for architecture x86_64
    ```

2. The first missing call is what the `MBED_ASSERT()` uses internally. This stub is already provided so modify the `unittest.mk` to have the following:

    ```
    TEST_SRC_FILES = \
        UNITTESTS/rtos/Semaphore/test_Semaphore.cpp \
        rtos/Semaphore.cpp \
        UNITTESTS/stubs/mbed_assert.c
    ```

    Other missing calls are actual calls to CMSIS-RTOS2 API. But because we don't have any operating system here, we need to provide stubs for them.

3. Study the [cmsis_os2.h](https://www.keil.com/pack/doc/CMSIS/RTOS2/html/cmsis__os2_8h.html) and add following stubs into your source file, just before TEST_GROUP:

    ```
    static osStatus_t retval = osOK;
    static uint32_t count = 0;

    // Test stubs
    osStatus_t osSemaphoreAcquire (osSemaphoreId_t semaphore_id, uint32_t timeout) { return retval; }
    osStatus_t osSemaphoreDelete (osSemaphoreId_t semaphore_id)                    { return retval; }
    osStatus_t osSemaphoreRelease (osSemaphoreId_t semaphore_id)                   { return retval; }
    uint32_t osSemaphoreGetCount (osSemaphoreId_t semaphore_id)                    { return count; }
    osSemaphoreId_t osSemaphoreNew (uint32_t max_count, uint32_t initial_count, const osSemaphoreAttr_t *attr)
    {
        return (void*)&count; // Just a dymmy reference
    }
    ```

    Now our unittest builds and is able to test that constructor of the Semaphore works.

    The stubs used in unittests are not supposed to do any real work. They are stricly supposed to return something that can be controlled from unittest. Depending on the case, you need to decide whether these stubs are going to be used from other tests. If that is the case, you might want to place them somewhere in the `UNITTESTS/stubs` directory.

4. As an example of controlling the stubs, add this testcase to end of your `test_Semaphore.cpp` to actually test the `Semaphore::wait()` function call.

    ```
    TEST(Semaphore, wait)
    {
        retval = osOK;
        count = 1;
        CHECK(sem->wait() == 2);

        retval = osErrorTimeout;
        CHECK(sem->wait() == 0);

        retval = osErrorParameter;
        CHECK(sem->wait() == -1);
    }
    ```

    This should cover all cases that `Semaphore::wait()` returns. Please study the actual function that is tested from https://github.com/ARMmbed/mbed-os/blob/master/rtos/Semaphore.cpp#L46-L58.

5. Run the tests and study the `coverage/index.html` file to see what was tested.
