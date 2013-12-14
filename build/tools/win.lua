dofile( "../solution.lua" )
configuration "*"
    buildoptions
    {
        "/MP"
    }

dofile( "../extern/lua.lua" )
configuration( { "windows" } )
	prebuildcommands
	{
		"pushd ..\\..\\..\\extern\\lua & ..\\..\\tools\\premake\\premake.exe embed & popd"
	}
    
dofile( "../extern/premake.lua" )
configuration "vs*"
	defines     
    { 
        "_CRT_SECURE_NO_WARNINGS" 
    }

configuration "vs2005"
    defines
    {
        "_CRT_SECURE_NO_DEPRECATE" 
    }

configuration "windows"
    links 
    {
        "ole32" 
    }
    prebuildcommands
	{
		"pushd ..\\..\\..\\extern\\premake & ..\\..\\tools\\premake\\premake.exe embed & popd"
	}


configuration "*"
