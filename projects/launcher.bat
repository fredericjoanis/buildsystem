@echo off
for /f "tokens=1,2,3 delims=_" %%a in ("%1") do set solution=%%a& set ide=%%b& set os=%%c
..\tools\premake\premake.exe --file=..\build\%solution%\%os%.lua %ide%
if errorlevel 1 pause && exit
if "%2" == "noide" exit
start ..\tmp\projects\%1\%1.sln