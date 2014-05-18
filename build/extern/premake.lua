WARNING_AS_ERROR = false
version = "0.0.1"
usingProjectName = "premake"
lambdaPremake = true
dofile("../project.lua")
kind "ConsoleApp"
language "C"

files
{
    "../../extern/lua/**",
    "../../tmp/premake/scripts.c",
}

flags 
{
    "No64BitChecks",
    "StaticRuntime" 
}

includedirs
{
    "../../extern/lua/host",
    "../../extern/lua/host/lua-5.1.4",
}

excludes
{
    "../../extern/lua/host/premake.c",
}
	
configuration "*"
