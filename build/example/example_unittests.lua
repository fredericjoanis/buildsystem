version = "0.0.4"
dofile("../project.lua")

kind "ConsoleApp"

files
{
    "../../extern/gtest/src/gtest-all.cc",
    "../../extern/gtest/src/gtest_main.cc",
}

includedirs
{
    "../../extern/gtest/include",
    "../../extern/gtest",
    "../../src/example_lib",
}

links
{
    "example_lib",
}