#include "CppUTest/TestHarness.h"
#include "dirname/template.h"

TEST_GROUP(template)
{
};

TEST(template, constructor)
{
    template t;
    CHECK(true);
}
