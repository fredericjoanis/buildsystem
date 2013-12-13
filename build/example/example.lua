version = "0.0.1"
dofile("../project.lua")

kind "ConsoleApp"

includedirs
{
    -- List of include directory needed
    "../../src/example_lib",
}

links
{
    "example_lib",
}
