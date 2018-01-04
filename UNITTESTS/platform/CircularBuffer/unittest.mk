include UNITTESTS/makefile_defines.txt

COMPONENT_NAME = CircularBuffer

SRC_FILES = \
    UNITTESTS/unittest_main.cpp \

TEST_SRC_FILES = \
    UNITTESTS/platform/CircularBuffer/test_CircularBuffer.cpp \

include UNITTESTS/MakefileWorker.mk
