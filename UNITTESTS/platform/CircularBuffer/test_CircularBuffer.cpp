#include "CppUTest/TestHarness.h"
#include "platform/CircularBuffer.h"

TEST_GROUP(CircularBuffer)
{
};

TEST(CircularBuffer, constructor)
{
    mbed::CircularBuffer<int, 10> buf;
    CHECK(true);
}

