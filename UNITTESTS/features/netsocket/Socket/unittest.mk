include UNITTESTS/makefile_defines.txt

COMPONENT_NAME = Socket

SRC_FILES = \
    UNITTESTS/unittest_main.cpp \
    UNITTESTS/stubs/Mutex.cpp \
    UNITTESTS/stubs/mbed_assert.c \
    UNITTESTS/stubs/nsapi_dns.c

TEST_SRC_FILES = \
    UNITTESTS/features/netsocket/Socket/test_Socket.cpp \
    features/netsocket/Socket.cpp \
    features/netsocket/SocketAddress.cpp \
    features/netsocket/NetworkStack.cpp

include UNITTESTS/MakefileWorker.mk
