#include "CppUTest/TestHarness.h"
#include "features/netsocket/UDPSocket.h"

TEST_GROUP(UDPSocket)
{
};

TEST(UDPSocket, constructor)
{
    UDPSocket t;
    CHECK(true);
}
