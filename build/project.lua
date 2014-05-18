-- debug.getinfo(4).source is the filename of the file who called dofile()
projectName = path.getbasename(debug.getinfo(4).source)
if version == nil then
	version = "0.0.0"
end


local srcPath = "../src/" .. projectName
local isExtern = false

if not os.isdir(srcPath) and os.isdir("../extern/" .. projectName) == true then
	if usingProjectName == nil then
	    usingProjectName = "extern"
	end
    srcPath = "../extern/" .. projectName
    isExtern = true
end

if usingProjectName == nil then
	usingProjectName = projectName
end

if useBlob == nil then
    useBlob = true
end

 -- A project defines one build target
   project( usingProjectName )
        language "C++"
        
        if isExtern == true then
            kind "StaticLib"
        end
        
        local tmpdir = "../tmp/" .. usingProjectName .. "_" .. _ACTION .. "_" .. currentOS .. "/" .. version
        objdir( tmpdir )
        
        files
        {
            srcPath .. "/**",
        }
        
        if lambdaPremake ~= true then
            if os.is("windows") then
                excludefilesfrombuild
                {
                    "../**linux*",
                    "../**mac*",
                    "../**_android*",
                    "../**_ios*",
                }
            elseif os.is("linux") then
                excludefilesfrombuild
                {
                    "../**/*_win*",
                    "../**/*_mac*",
                    "../**/*_android*",
                    "../**/*_ios*",
                }
            end
        end
        
        includedirs
        {
            srcPath,
            "../src",
            "../extern",
        }

        -- FJ: Should create the NoDefaultFlag flag.
        flags 
        {
            "Symbols",
            "NoMinimalRebuild",
        }
        
        if isExtern == false then
            flags 
            {
                "ExtraWarnings",
            }
        end
		
		if WARNING_AS_ERROR ~= false then
			flags
			{
			    "FatalWarnings",
			}
		end
		
		local postbuildFile = path.getabsolute(srcPath .. "/postbuild.lua")
		local lua = path.getabsolute("../tools/lua/lua")
		if os.is("windows") then
			lua = lua .. ".exe"
        elseif os.is("linux") then
            if os.is64bit() then
               lua = lua .. "64"
            elseif os.isARM() then
               lua = lua .. "ARM"
            else
               lua = lua .. "32"
            end
		end

		local postBuild = false
		if os.isfile(postbuildFile) then
			postBuild = true
		end
		
    if lambdaPremake ~= true then
        configuration "debug or release"
            blobdir( tmpdir )
            
            blobfiles
            {
                srcPath .. "/**.c",
                srcPath .. "/**.cc",
                srcPath .. "/**.cpp",
            }
    end
        
	configuration "linux"
        buildoptions
        {
            "-std=c++0x",
        }
	
	
    configuration "debug"
		outputDebug = "../output/debug/" .. usingProjectName .. "_" .. _ACTION .. "_" .. currentOS .. "/" .. version
        targetdir( outputDebug )
        debugdir( outputDebug )
         defines 
         {
            "DEBUG",
			"_CRT_SECURE_NO_WARNINGS",
         }

        flags 
        {
            "Symbols",
        }
		
		if postBuild then
			postbuildcommands
			{
				lua .. " --file=" .. "\"" .. postbuildFile .. "\" \"" .. path.getabsolute(outputDebug) .. "\""
			}
		end
        
    configuration { "windows", "release" }
        buildoptions
			{
                -- More info in PDB in release. See http://randomascii.wordpress.com/2013/09/11/debugging-optimized-codenew-in-visual-studio-2012/
				"/d2Zi+",
			}
 
    configuration "release"
		outputRelease = "../output/release/" .. usingProjectName .. "_" .. _ACTION .. "_" .. currentOS .. "/" .. version
        targetdir ( outputRelease )
        debugdir( outputRelease )
        
        defines
        {
           "NDEBUG",
		   "_CRT_SECURE_NO_WARNINGS",

        }
         
        flags 
        {
           "OptimizeSpeed",
        }
		
		if postBuild then
			postbuildcommands
			{
				lua .. " --file=" .. "\"" .. postbuildFile .. "\" \"" .. path.getabsolute(outputRelease) .. "\""
			}
		end
        
    configuration "noblob"
		outputNoblob = "../output/noblob/" .. usingProjectName .. "_" .. _ACTION .. "_" .. currentOS .. "/" .. version
        targetdir ( outputNoblob )
        debugdir( outputNoblob )
        
        defines
        {
           "NDEBUG",
		   "_CRT_SECURE_NO_WARNINGS",
        }
        
        flags 
        {
           "OptimizeSpeed",
        }
		
		if postBuild then
			postbuildcommands
			{
				lua .. " --file=" .. "\"" .. postbuildFile .. "\" \"" .. path.getabsolute(outputNoblob) .. "\""
			}
		end
    
    usingProjectName = nil
    
    -- Always finish this file with configuration "*"
    configuration "*"