#include "gtest/gtest.h"

/*
 * Purpose of this test is just to be empty baseline
 * that does nothing, but includes all source files
 * in the build.
 * Do not add any tests here
 */

class EmptyBaseline : public testing::Test {
    virtual void SetUp()
    {
    }

    virtual void TearDown()
    {
    }
};

TEST_F(EmptyBaseline, constructor)
{
    EXPECT_TRUE(true);
}
