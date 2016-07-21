@echo off

set /p slnName=ÇëÊäÈëslnÃû×Ö£º
echo %slnName%

mkdir build
cd build
mkdir sln
cd sln
call :createSln
cd ../../

mkdir bin
mkdir doc
mkdir lib
mkdir runtime_config
mkdir setup
mkdir src
mkdir test

echo.>change.log
call :createPreBuild
call :createVersion

goto end



:createSln
echo createSln
echo Microsoft Visual Studio Solution File, Format Version 10.00>>%slnName%.sln
echo # Visual Studio 2008>>%slnName%.sln
echo Global>>%slnName%.sln
echo 	GlobalSection(SolutionProperties) = preSolution>>%slnName%.sln
echo 		HideSolutionNode = FALSE>>%slnName%.sln
echo 	EndGlobalSection>>%slnName%.sln
echo EndGlobal>>%slnName%.sln
goto:eof

:createPreBuild
echo pre_build.bat
echo xcopy .\runtime\*.*              .\bin\ /e /y>>pre_build.bat
echo copy .\version.xml               .\bin>>pre_build.bat
goto:eof

:createVersion
echo version.xml
echo ^<?xml version="1.0" encoding="utf-8" ?^>>>version.xml

echo ^<config^>>>version.xml
echo     ^<name val="%slnName%" /^>>>version.xml
echo     ^<mainVer val="1.00" ^/^>>>version.xml
echo     ^<buildVer val="" ^/^>>>version.xml
echo ^</config^>>>version.xml
goto:eof

:end 
pause
