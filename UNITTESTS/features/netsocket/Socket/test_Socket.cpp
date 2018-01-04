#include "CppUTest/TestHarness.h"
#include "features/netsocket/Socket.h"

class stubSocket : public Socket {
protected:
	virtual nsapi_protocol_t get_proto() {return NSAPI_TCP;}
	virtual void event() {}
};

TEST_GROUP(Socket)
{
	Socket *socket;
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
