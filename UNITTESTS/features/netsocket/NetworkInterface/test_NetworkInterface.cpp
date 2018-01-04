#include "CppUTest/TestHarness.h"
#include "features/netsocket/NetworkInterface.h"

class stubNetworkInterface : public NetworkInterface
{
    virtual nsapi_error_t connect()     {return NSAPI_ERROR_OK;};
    virtual nsapi_error_t disconnect()  {return NSAPI_ERROR_OK;};
    virtual NetworkStack *get_stack()   {return nullptr;};
};

TEST_GROUP(NetworkInterface)
{
    NetworkInterface *iface;
    void setup() {
        iface = new stubNetworkInterface();
    }
    void teardown() {
        delete iface;
    }
};

TEST(NetworkInterface, constructor)
{
    CHECK(iface);
}

TEST(NetworkInterface, get_mac_address)
{
    CHECK(iface->get_mac_address() == 0);
}
