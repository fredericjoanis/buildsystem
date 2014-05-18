dofile("args.lua")

function buildDirPath(testname)
    local dirPath = path.getabsolute("../output/" .. configuration .. "/" .. project .. "_" .. testname .. "_" .. compiler .. "_" .. platform )
    
    local folder = os.matchdirs(dirPath .. "/*")
    
    return folder[1]
end
    
function buildFilePath(testname)
    local dirPath = buildDirPath(testname)

    if dirPath ~= nil then
        -- Here we should only have one folder.
        return dirPath .. "/" .. project .. "_" .. testname .. ".exe"
    else
        return nil
    end
end

local unittestDirPath = buildDirPath("unittests")
local unittestsFilePath = buildFilePath("unittests")
local metricsFilePath = buildFilePath("metrics")

if os.isfile(unittestsFilePath) then
    executeCmd(unittestsFilePath .. " --gtest_output=xml:" .. unittestDirPath .. "/" .. project .. "_unittests_output.xml")
end

if os.isfile(metricsFilePath) then
    executeCmd("cd " .. projectPath .. " && " .. metricsFilePath)
end