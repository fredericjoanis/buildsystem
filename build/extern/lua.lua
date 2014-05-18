WARNING_AS_ERROR = false
lambdaPremake = true
version = "0.0.1"
usingProjectName = "lua"
dofile("../project.lua")
kind "ConsoleApp"


files
{
    "../../tmp/lua/scripts.c",
}

includedirs
{
    "../../extern/lua/host/lua-5.1.4",
}
	
configuration "*"
