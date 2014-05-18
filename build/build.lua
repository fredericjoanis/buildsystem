-- Notes : For windows, msbuild.exe must be in path (ex: C:\Windows\Microsoft.NET\Framework64\v4.0.30319) and VCTargetsPath to something such as C:\Program Files (x86)\MSBuild\Microsoft.Cpp\v4.0

dofile("args.lua")

if isBuildSystem == true then
    print("Cleaning all output directories")
    os.rmdir("../tmp")
    os.rmdir("../output")
    
    -- Java directories unfortunatly output to /target because of eclipse
    local srcFolders = os.matchdirs("../src/*")
    for matchCount = 1, #srcFolders do
        os.rmdir(srcFolders[matchCount] .. "/target" )
    end
    
    local srcFolders = os.matchdirs("../extern/*")
    for matchCount = 1, #srcFolders do
        os.rmdir(srcFolders[matchCount] .. "/target" )
    end
end
	
if string.startswith(compiler, "vs") then
    executeCmd("cmd /C ..\\projects\\launcher.bat " .. solutionName .. " noide")
	
	local folders
	if os.is64bit() then
		folders = os.matchdirs(os.getenv("SystemRoot") .. "/Microsoft.NET/Framework64/v*")
	else
		folders = os.matchdirs(os.getenv("SystemRoot") .. "/Microsoft.NET/Framework/v*")
	end
	
	-- Last folder should be highest version
	local msbuildversion = folders[#folders]
    executeCmd( msbuildversion .. "/msbuild \"" .. projectPath .. "/" .. solutionName .. ".sln\" /p:Configuration=" .. configuration)
elseif string.startswith(compiler, "xcode") then
    executeCmd("../projects/launcher " .. solutionName .. " noide" )
elseif string.find(compiler , "gmake") ~= nil then
   executeCmd("../projects/launcher.sh " .. solutionName .. " noide" )

   executeCmd("cd " .. projectPath .. " && make config=" .. configuration )
end

if string.startswith(compiler, "java") then
	if os.isfile( project .. "/commands.lua" ) then
		dofile( project .. "/commands.lua" )
	end

	-- Not handled in Java
	if preBuild ~= nil then
		preBuild()
	end
	
    local folder = nil;
    if os.isdir("..\\src\\" .. project ) then
        folder = "src"
    elseif os.isdir("..\\extern\\" .. project ) then
        folder = "extern"
    else
        error("Java project not found")
    end
    
    executeCmd("cmd /C ..\\tools\\maven\\bin\\mvn.bat -f ..\\" .. folder .. "\\" .. project .. "\\pom.xml clean install")
	
	-- Not handled in Java
	if postBuild ~= nil then
		postBuild()
	end
end

