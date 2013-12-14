-- Arg 0 : Ignore
if _ARGS[1] == nil or _ARGS[2] == nil or _ARGS[3] == nil then
    local callername = path.getbasename(debug.getinfo(4).source)
    error("Error : Missing arguments.\nUsage : " .. callername .. " project compiler configuration [buildsystem]\nEx: " .. callername .. " detector vs2010 debug")
end

project = string.lower(_ARGS[1])
compiler = string.lower(_ARGS[2])
configuration = string.lower(_ARGS[3])

platform = "win"
if compiler == "xcode3" then
    platform = "ios"
elseif compiler == "gmake" then
    platform = "linux"
end

solutionName = project .. "_" .. compiler .. "_" .. platform

isBuildSystem = false
if _ARGS[4] ~= nil and string.lower(_ARGS[4]) == "buildsystem" then
    isBuildSystem = true
end

projectPath = path.getabsolute("../tmp/projects") .. "/" .. solutionName;

function executeCmd(cmd)
    local result = os.execute(cmd)
    if( result > 0 ) then
        error( "Command execution failed " .. cmd )
    end
end