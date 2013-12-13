dofile( "../solution.lua" )
configuration "*"

dofile( "lua.lua" )
dofile( "premake.lua" )
configuration "macosx"
    defines     { "LUA_USE_MACOSX" }
    links       { "CoreServices.framework" }
    
configuration { "macosx", "gmake" }
    buildoptions { "-mmacosx-version-min=10.4" }
    linkoptions  { "-mmacosx-version-min=10.4" }

configuration "*"
