@echo off
cscript.exe //Nologo "%~dpn0.wsf" %*
exit /b %errorlevel%
