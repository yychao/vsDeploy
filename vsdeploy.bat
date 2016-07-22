@echo off

set /p slnName=请输入sln名字：
echo %slnName%

mkdir build
cd build
mkdir sln
cd sln
call :createSln
mkdir demo
cd ../../

mkdir bin
mkdir doc
mkdir lib
mkdir runtime_config
mkdir setup
xcopy %M_TOOLS_PATH%\files\setup\*.*              .\setup\ /e /y
echo %M_TOOLS_PATH%

mkdir src
cd src
mkdir prj
cd prj
call :createMyVar
cd ../../
mkdir test

echo.>change.log
call :createPreBuild
call :createVersion

xcopy %M_TOOLS_PATH%\files\说明\*.*              .\ /e /y


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
echo xcopy .\runtime\*.*              .\bin\ /e /y  >>pre_build.bat
echo copy .\version.xml               .\bin         >>pre_build.bat
goto:eof

:createVersion
echo version.xml
echo ^<?xml version="1.0" encoding="utf-8" ?^>      >>version.xml
echo ^<config^>                                     >>version.xml
echo     ^<name val="%slnName%" /^>                 >>version.xml
echo     ^<mainVer val="1.00" ^/^>                  >>version.xml
echo     ^<buildVer val="" ^/^>                     >>version.xml
echo ^</config^>                                    >>version.xml
goto:eof

:createMyVar
echo myvar.vsprops
echo ^<?xml version="1.0" encoding="gb2312"?^>   >>myvar.vsprops
echo ^<VisualStudioPropertySheet                 >>myvar.vsprops
echo    ^ProjectType="Visual C++"                >>myvar.vsprops
echo    ^Version="8.00"                          >>myvar.vsprops
echo    ^Name="myvar"                            >>myvar.vsprops
echo    ^>                                       >>myvar.vsprops
echo    ^<UserMacro                              >>myvar.vsprops
echo        ^Name="rootdir"                      >>myvar.vsprops
echo        ^Value="$(ProjectDir)../../../"      >>myvar.vsprops
echo    ^/^>                                     >>myvar.vsprops
echo ^</VisualStudioPropertySheet^>              >>myvar.vsprops
goto:eof

:end 
@echo on
