#include "CppUTest/TestHarness.h"
#include "features/netsocket/Socket.h"
#include "NetworkStackstub.h"

class stubSocket : public Socket {
public:
	virtual void event() {
		if (_callback) {
			_callback.call();
		}
	}
protected:
	virtual nsapi_protocol_t get_proto() {return NSAPI_TCP;}
};

static bool callback_is_called;
static void my_callback() {
	callback_is_called = true;
}

TEST_GROUP(Socket)
{
	stubSocket *socket;
	NetworkStackstub stack;
	void setup() {
		socket = new stubSocket;
	}
	void teardown() {
		delete socket;
	}
};

TEST(Socket, constructor)
{
    CHECK(socket);
}

TEST(Socket, open_null_stack)
{
	CHECK(socket->open(NULL) == NSAPI_ERROR_PARAMETER)
}

TEST(Socket, open_error)
{
	stack.return_value = NSAPI_ERROR_PARAMETER;
	CHECK(socket->open((NetworkStack*)&stack) == NSAPI_ERROR_PARAMETER);
}

TEST(Socket, open)
{
	stack.return_value = NSAPI_ERROR_OK;
	CHECK(socket->open((NetworkStack*)&stack) == NSAPI_ERROR_OK);
}

TEST(Socket, open_twice)
{
	stack.return_value = NSAPI_ERROR_OK;
	CHECK(socket->open((NetworkStack*)&stack) == NSAPI_ERROR_OK);
	CHECK(socket->open((NetworkStack*)&stack) == NSAPI_ERROR_PARAMETER);
}

TEST(Socket, close)
{
	stack.return_value = NSAPI_ERROR_OK;
	socket->open((NetworkStack*)&stack);
	CHECK(socket->close() == NSAPI_ERROR_OK);
}

TEST(Socket, modify_multicast_group)
{
	SocketAddress a("localhost", 1024);
	stack.return_value = NSAPI_ERROR_OK;
	socket->open((NetworkStack*)&stack);
	CHECK(socket->join_multicast_group(a) == NSAPI_ERROR_UNSUPPORTED);
	CHECK(socket->leave_multicast_group(a) == NSAPI_ERROR_UNSUPPORTED);
}

TEST(Socket, bind)
{
	socket->close();
	CHECK(socket->bind(1024) == NSAPI_ERROR_NO_SOCKET);
	socket->open((NetworkStack*)&stack);
	stack.return_value = NSAPI_ERROR_OK;
	CHECK(socket->bind(1024) == NSAPI_ERROR_OK);
	CHECK(socket->bind("localhost", 1024) == NSAPI_ERROR_OK);
}

TEST(Socket, set_blocking)
{
	socket->set_blocking(false);
	socket->set_blocking(true);
}

TEST(Socket, getsockopt)
{
	socket->close();
	CHECK(socket->getsockopt(0, 0, 0, 0) == NSAPI_ERROR_NO_SOCKET);
	socket->open((NetworkStack*)&stack);
	stack.return_value = NSAPI_ERROR_OK;
	CHECK(socket->getsockopt(0, 0, 0, 0) == NSAPI_ERROR_UNSUPPORTED);
}

TEST(Socket, setsockopt_no_stack)
{
	socket->close();
	CHECK(socket->setsockopt(0,0,0,0) == NSAPI_ERROR_NO_SOCKET);
}

TEST(Socket, sigio)
{
	callback_is_called = false;
	// I'm calling sigio() through the DEPRECATED method, just to get coverage for both.
	// Not sure if this is wise at all, we should not aim for 100%
	socket->attach(mbed::callback(my_callback));
	socket->event();
	CHECK(callback_is_called);
}
