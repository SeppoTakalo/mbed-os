include UNITTESTS/makefile_defines.txt

COMPONENT_NAME = UDPSocket

SRC_FILES = \
    UNITTESTS/unittest_main.cpp \

TEST_SRC_FILES = \
    UNITTESTS/features/netsocket/UDPSocket/test_UDPSocket.cpp \
    features/netsocket/UDPSocket.cpp \
    features/netsocket/SocketAddress.cpp \
    features/netsocket/InternetSocket.cpp \
    features/netsocket/NetworkStack.cpp \
    features/frameworks/nanostack-libservice/source/libip6string/ip6tos.c \
    features/frameworks/nanostack-libservice/source/libip6string/stoip6.c \
    features/frameworks/nanostack-libservice/source/libBits/common_functions.c \
    UNITTESTS/stubs/Mutex.cpp \
    UNITTESTS/stubs/mbed_assert.c \
    UNITTESTS/stubs/EventFlags.cpp \
    UNITTESTS/stubs/nsapi_dns.c \
    UNITTESTS/stubs/equeue.cpp


include UNITTESTS/MakefileWorker.mk
