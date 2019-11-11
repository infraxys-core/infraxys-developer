@echo off

setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Running Docker requires privileged access
ECHO   If Windows Defender blocks access, then click on "More info" and then "Run anyway"
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges

echo Please enter the root directory for Infraxys.
echo   All files will be stored here.
echo   !!! Make sure this directory can be mounted by Docker and that it is empty.
set "batchPath=%~dp0"

set /p INFRAXYS_ROOT_DIR="Directory name: "

>nul 2>nul dir /b /a "%INFRAXYS_ROOT_DIR%\*" | >nul findstr "^" && (echo Directory %INFRAXYS_ROOT_DIR% is not empty. Not making any changes to it. && goto :EXIT)

set /p VERSION=<%batchPath%..\VERSION

set IMAGE=quay.io/jeroenmanders/infraxys-developer-installer:%VERSION%

echo Using image %IMAGE%
setlocal enableextensions
md %INFRAXYS_ROOT_DIR%
endlocal

docker pull %IMAGE%
docker run -it --rm -e "INSTALL_MODE=WINDOWS" -e "VERSION=%VERSION%" -e "INFRAXYS_ROOT_DIR=%INFRAXYS_ROOT_DIR%" -v %INFRAXYS_ROOT_DIR%:/infraxys-root:rw %IMAGE%

cd "%INFRAXYS_ROOT_DIR%\bin";
up.bat;

:EXIT
