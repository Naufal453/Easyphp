@echo off
setlocal EnableDelayedExpansion

echo Choose the main folder for your php file
:: Create a temporary VBScript file
echo Set objShell = CreateObject("Shell.Application") > temp.vbs
echo set objFolder = objShell.BrowseForFolder(0, "Select a folder", 0, "") >> temp.vbs
echo if not objFolder is nothing then >> temp.vbs
echo     WScript.Echo objFolder.Self.Path >> temp.vbs
echo end if >> temp.vbs

:: Run the VBScript and capture the selected folder
for /f "delims=" %%a in ('cscript //nologo temp.vbs') do set "folderPath=%%a"

:: Delete the temporary VBScript file
del temp.vbs

:: Check if a folder was selected
if not defined folderPath (
    echo No folder selected. Exiting.
    exit /b 1
)

:: Start the PHP server with the selected folder
php -S 127.0.0.1:8888 -t "!folderPath!"
