dofile( "../solution.lua" )
configuration "*"

local premakePath
if os.is64bit() then
   premakePath = "../../tools/premake/premake64"
elseif os.isARM() then
   premakePath = "../../tools/premake/premakeARM"
else
   premakePath = "../../tools/premake/premake32"
end

dofile( "../extern/lua.lua" )
configuration( { "linux" } )
	prebuildcommands
	{
               -- if somebody finds out how to use #!/bin/sh on a single line to use pushd && popd ... that'd be nice.
                "cd ../../../extern/lua && " .. premakePath .. " embed && cd ../../tmp/projects/tools_gmake_linux",
	}

dofile( "../extern/premake.lua" )
configuration "linux or bsd"
    defines     
    { 
        "LUA_USE_POSIX", 
        "LUA_USE_DLOPEN",
    }
    
    links       
    { 
        "m" 
    }
    
    linkoptions 
    {
        "-rdynamic" 
    }

configuration "linux"
    links       
    { 
        "dl" 
    }
	prebuildcommands
	{
-- if somebody finds out how to use #!/bin/sh on a single line to use pushd && popd ... that'd be nice.
		"cd ../../../extern/premake && " .. premakePath .. "  embed && cd ../../tmp/projects/tools_gmake_linux"
	}

configuration "*"
