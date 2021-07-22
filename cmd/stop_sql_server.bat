@echo off
setlocal
call :Main %*
endlocal & exit /b %errorlevel%

rem ----------------------------------------------------------------------------
rem  Initialize
rem ----------------------------------------------------------------------------
:Initialize

    set SQL_SERVER_INSTANCE_NAME=SQLEXPRESS

    set SERVICE_LIST=
    set SERVICE_LIST=%SERVICE_LIST%  MSSQL$%SQL_SERVER_INSTANCE_NAME%
    set SERVICE_LIST=%SERVICE_LIST%  MSSQLFDLauncher$%SQL_SERVER_INSTANCE_NAME%
    set SERVICE_LIST=%SERVICE_LIST%  SQLAgent$%SQL_SERVER_INSTANCE_NAME%
    set SERVICE_LIST=%SERVICE_LIST%  SQLTELEMETRY$%SQL_SERVER_INSTANCE_NAME%
    set SERVICE_LIST=%SERVICE_LIST%  SQLBrowser
    set SERVICE_LIST=%SERVICE_LIST%  SQLWriter

    exit /b

rem ----------------------------------------------------------------------------
rem  Main
rem ----------------------------------------------------------------------------
:Main

    call :Initialize

    for %%i in (%SERVICE_LIST%) do call :Stop_Service %%i

    echo.
    pause
    exit /b 0

rem ----------------------------------------------------------------------------
rem  Stop_Service
rem ----------------------------------------------------------------------------
:Stop_Service

    sc query "%~1" | findstr STATE | findstr STOPPED > nul

    if "%errorlevel%"=="0" (
        echo サービス %~1 は既に停止しています。
        exit /b 1
    )

    net stop "%~1"

    if not "%errorlevel%"=="0" (
        echo サービス %~1 の停止に失敗しました。
        exit /b 2
    )

    exit /b 0

