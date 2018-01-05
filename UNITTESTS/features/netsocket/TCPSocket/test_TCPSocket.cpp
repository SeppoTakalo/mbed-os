#include "CppUTest/TestHarness.h"
#include "features/netsocket/TCPSocket.h"

TEST_GROUP(TCPSocket)
{
};

TEST(TCPSocket, constructor)
{
    TCPSocket t;
    CHECK(true);
}
