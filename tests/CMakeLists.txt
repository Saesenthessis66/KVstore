add_executable(simple_test simple_test.cpp)
target_link_libraries(simple_test PRIVATE GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(simple_test)