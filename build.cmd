@echo off

pushd "%~dp0" 

set name=%~nx1
set template=%~f1\template.json
set box=%~f1\%name%_virtualbox.box

echo name: %name%
echo template: %template%
echo box: %box%

if not exist %template% (
        echo Usage: %~nx0 ^<name^>
        exit /b 1
)

echo.
echo Build "%template%"
call packer version || exit /b 2
call packer build "%template%" || exit /b 3

echo.
echo Add local box as "local-%name%" 
call vagrant box add --force --name "local-%name%" "%box%" || exit /b 4
call vagrant box list | findstr "%name%" || exit /b 5

echo All done.
popd
