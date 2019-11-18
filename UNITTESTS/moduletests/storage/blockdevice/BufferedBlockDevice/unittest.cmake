
####################
# UNIT TESTS
####################

set(unittest-includes ${unittest-includes}
  .
  ..
)

set(unittest-sources
  ../features/storage/blockdevice/BufferedBlockDevice.cpp
  ../features/storage/blockdevice/HeapBlockDevice.cpp
  stubs/mbed_atomic_stub.c
  stubs/mbed_assert_stub.c
)

set(unittest-test-sources
  moduletests/storage/blockdevice/BufferedBlockDevice/moduletest.cpp
)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DMBED_ASSERT_THROW_ERROR")
