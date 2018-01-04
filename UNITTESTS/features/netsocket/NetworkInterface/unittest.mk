include UNITTESTS/makefile_defines.txt

COMPONENT_NAME = NetworkInterface

SRC_FILES = \
    features/netsocket/NetworkInterface.cpp

TEST_SRC_FILES = \
	UNITTESTS/unittest_main.cpp \
    UNITTESTS/features/netsocket/NetworkInterface/test_NetworkInterface.cpp \

include UNITTESTS/MakefileWorker.mk
