if _ARGS[1] == nil or _ARGS[2] == nil or _ARGS[3] == nil then
    local callername = path.getbasename(debug.getinfo(4).source)
    error("Error : Missing arguments.\nUsage : " .. callername .. " type project path\nEx: " .. callername .. " prebuild detector c:\\pathtooutput")
end

if os.isfile( project .. "/commands.lua" ) then
	dofile( project .. "/commands.lua" )

	if preBuild ~= nil and string.lower(_ARGS[2]) == "prebuild" then
		preBuild()
	end

	if postBuild ~= nil and string.lower(_ARGS[2]) == "postbuild" then
		postBuild()
	end

	if preTests ~= nil and string.lower(_ARGS[2]) == "pretests" then
		postBuild()
	end

	if postTests ~= nil and string.lower(_ARGS[2]) == "posttests" then
		postTests()
	end
end

