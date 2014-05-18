-- debug.getinfo(4).source is the filename of the file who called dofile()
solutionName = path.getbasename(path.getabsolute(debug.getinfo(4).source .. "/.." ))
currentOS = path.getbasename(debug.getinfo(4).source);

solution( solutionName .. "_" .. _ACTION .. "_" .. currentOS )
    configurations
    {
        "debug",
        "release",
        "noblob",
    }
    
    location ( "../tmp/projects/" .. solutionName .. "_" .. _ACTION .. "_" .. currentOS )