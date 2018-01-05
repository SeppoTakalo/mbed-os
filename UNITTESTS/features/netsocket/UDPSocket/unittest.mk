include UNITTESTS/makefile_defines.txt

COMPONENT_NAME = UDPSocket

SRC_FILES = \
    UNITTESTS/unittest_main.cpp \

TEST_SRC_FILES = \
    UNITTESTS/features/netsocket/UDPSocket/test_UDPSocket.cpp \
    features/netsocket/UDPSocket.cpp \
    features/netsocket/SocketAddress.cpp \
    features/netsocket/Socket.cpp \
    UNITTESTS/stubs/Mutex.cpp \
    UNITTESTS/stubs/mbed_assert.c \
    UNITTESTS/stubs/EventFlags.cpp

include UNITTESTS/MakefileWorker.mk
