#include <boost/test/unit_test.hpp>

BOOST_AUTO_TEST_CASE(test_macro_overview)
{
    namespace tt = boost::test_tools;
    int a = 1;
    int b = 2;
    BOOST_CHECK(a != b - 1);
    BOOST_CHECK(a + 1 < b);
    BOOST_CHECK(b - 1 > a, a << " < " << b - 1 << " does not hold");
    BOOST_CHECK(a == b, tt::bitwise());
    BOOST_CHECK(a + 0.1 == b - 0.8, tt::tolerance(0.01));
}
