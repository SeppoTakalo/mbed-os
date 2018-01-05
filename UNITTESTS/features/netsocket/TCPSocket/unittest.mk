include UNITTESTS/makefile_defines.txt

COMPONENT_NAME = TCPSocket

SRC_FILES = \
    UNITTESTS/unittest_main.cpp \

TEST_SRC_FILES = \
    UNITTESTS/features/netsocket/TCPSocket/test_TCPSocket.cpp \
    features/netsocket/TCPSocket.cpp \
    features/netsocket/SocketAddress.cpp \
    features/netsocket/Socket.cpp \
    UNITTESTS/stubs/Mutex.cpp \
    UNITTESTS/stubs/mbed_assert.c \
    UNITTESTS/stubs/EventFlags.cpp

include UNITTESTS/MakefileWorker.mk
