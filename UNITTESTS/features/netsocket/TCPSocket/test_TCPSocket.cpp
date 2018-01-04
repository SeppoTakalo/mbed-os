#include "CppUTest/TestHarness.h"
#include "features/netsocket/TCPSocket.h"
#include "NetworkStackstub.h"
#include "nsapi_dns_stubs.h"

/* I need a stub that allows my tests
 * to access protected members.
 * See cpputest's UtestMacros.h on how test class names
 * are generated */
class stubTCPSocket : public TCPSocket {
    friend class TEST_TCPSocket_get_proto_Test;
};


TEST_GROUP(TCPSocket)
{
    stubTCPSocket *socket;
    NetworkStackstub stack;
    void setup() {
        socket = new stubTCPSocket;
        stack.return_value = NSAPI_ERROR_OK;
        socket->open((NetworkStack*)&stack);
    }
    void teardown() {
        delete socket;
    }
};

TEST(TCPSocket, get_proto)
{
    CHECK(socket->get_proto() == NSAPI_TCP);
}

TEST(TCPSocket, connect)
{
    SocketAddress addr;

    socket->close();

    CHECK(socket->connect(addr) == NSAPI_ERROR_NO_SOCKET);

    socket->open((NetworkStack*)&stack);

    socket->set_timeout(0);
    stack.return_value = NSAPI_ERROR_IN_PROGRESS;
    CHECK(socket->connect(addr) == NSAPI_ERROR_IN_PROGRESS);

    socket->set_timeout(-1);
    stack.return_value = NSAPI_ERROR_OK;
    CHECK(socket->connect(addr) == NSAPI_ERROR_OK);
}

TEST(TCPSocket, connect_addr)
{
    socket->open((NetworkStack*)&stack);
    nsapi_stub_return_value = NSAPI_ERROR_DNS_FAILURE;

    CHECK(socket->connect("addr", 1) == NSAPI_ERROR_DNS_FAILURE);

    nsapi_stub_return_value = NSAPI_ERROR_OK;
    stack.return_value = NSAPI_ERROR_OK;
    CHECK(socket->connect("addr", 1) == NSAPI_ERROR_OK);
}

TEST(TCPSocket, send)
{
    socket->close();
    CHECK(socket->send(NULL, 0) == NSAPI_ERROR_NO_SOCKET);

    socket->open((NetworkStack*)&stack);
    stack.return_value = 100;
    CHECK(socket->send("", 100) == 100);
}

TEST(TCPSocket, recv)
{
    int x;
    socket->close();
    CHECK(socket->recv(NULL, 0) == NSAPI_ERROR_NO_SOCKET);

    socket->open((NetworkStack*)&stack);
    stack.return_value = sizeof x;

    CHECK(socket->recv(&x, sizeof x) == sizeof x);
}