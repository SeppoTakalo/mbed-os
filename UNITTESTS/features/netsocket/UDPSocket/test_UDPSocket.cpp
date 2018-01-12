#include "CppUTest/TestHarness.h"
#include "features/netsocket/UDPSocket.h"
#include "NetworkStackstub.h"
#include "nsapi_dns_stubs.h"

/* I need a stub that allows my tests
 * to access protected members.
 * See cpputest's UtestMacros.h on how test class names
 * are generated */
class stubUDPSocket : public UDPSocket {
    friend class TEST_UDPSocket_get_proto_Test;
};

TEST_GROUP(UDPSocket)
{
    stubUDPSocket *socket;
    NetworkStackstub stack;
    void setup() {
        socket = new stubUDPSocket;
        stack.return_value = NSAPI_ERROR_OK;
        socket->open((NetworkStack*)&stack);
    }
    void teardown() {
        delete socket;
    }
};

TEST(UDPSocket, get_proto)
{
    CHECK(socket->get_proto() == NSAPI_UDP);
}

TEST(UDPSocket, sendto_addr_port)
{
    nsapi_stub_return_value = NSAPI_ERROR_PARAMETER;
    CHECK(socket->sendto("localhost", 0, 0, 0) == NSAPI_ERROR_DNS_FAILURE)
    nsapi_stub_return_value = NSAPI_ERROR_OK;
    stack.return_value = NSAPI_ERROR_OK;
    CHECK(socket->sendto("localhost", 0, 0, 0) == 0);
}

TEST(UDPSocket, sendto)
{
    SocketAddress addr("127.0.0.1", 1024);
    nsapi_stub_return_value = NSAPI_ERROR_OK;
    stack.return_value = NSAPI_ERROR_OK;

    socket->close();
    CHECK(socket->sendto(addr, 0, 0) == NSAPI_ERROR_NO_SOCKET);

    socket->open((NetworkStack*)&stack);
    stack.return_value = 100;
    CHECK(socket->sendto(addr, 0, 100) == 100);

    socket->set_timeout(0);
    stack.return_value = NSAPI_ERROR_WOULD_BLOCK;
    CHECK(socket->sendto(addr, 0, 100) == NSAPI_ERROR_WOULD_BLOCK);

    socket->set_timeout(-1);
    stack.return_value = NSAPI_ERROR_NO_CONNECTION;
    CHECK(socket->sendto(addr, 0, 100) == NSAPI_ERROR_NO_CONNECTION);
}
