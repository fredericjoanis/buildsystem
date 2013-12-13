--
-- _lua_main.lua
-- Script-side entry point for the main program logic.
-- Copyright (c) 2002-2011 Jason Perkins and the Premake project
--

	local scriptfile    = "premake4.lua"
	local shorthelp     = "Type 'premake4 --help' for help"
	local versionhelp   = "premake4 (Premake Build Script Generator) %s"
	
	_WORKING_DIR        = os.getcwd()

--
-- Script-side program entry point.
--

	function _lua_main(scriptpath)
		
		-- if running off the disk (in debug mode), load everything 
		-- listed in _manifest.lua; the list divisions make sure
		-- everything gets initialized in the proper order.
		
		if (scriptpath) then
			local scripts  = dofile(scriptpath .. "/_manifest.lua")
			for _,v in ipairs(scripts) do
				dofile(scriptpath .. "/" .. v)
			end
		end
		

		-- Now that the scripts are loaded, I can use path.getabsolute() to properly
		-- canonicalize the executable path.
		
		_PREMAKE_COMMAND = path.getabsolute(_PREMAKE_COMMAND)

		-- Seed the random number generator so actions don't have to do it themselves
		math.randomseed(os.time())
		
		-- If there is a project script available, run it to get the
		-- project information, available options and actions, etc.
		local fname = _OPTIONS["file"] or scriptfile
		if (os.isfile(fname)) then
			dofile(fname)
		end


		-- Process special options
		if (_OPTIONS["version"]) then
			printf(versionhelp, _PREMAKE_VERSION)
			return 1
		end
		
		if (_OPTIONS["help"]) then
			premake.showhelp()
			return 1
		end

		-- If there wasn't a project script I've got to bail now
		if (not os.isfile(fname)) then
			error("No LUA script ("..scriptfile..") found!", 2)
		end

		return 0

	end
	
