include UNITTESTS/makefile_defines.txt

COMPONENT_NAME = NetworkInterface

SRC_FILES = \
    UNITTESTS/unittest_main.cpp \


TEST_SRC_FILES = \
    UNITTESTS/features/netsocket/NetworkInterface/test_NetworkInterface.cpp \
    features/netsocket/NetworkInterface.cpp \
    UNITTESTS/stubs/equeue.cpp \

include UNITTESTS/MakefileWorker.mk
