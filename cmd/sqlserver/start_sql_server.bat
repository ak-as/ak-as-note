@echo off
setlocal
call :Main %*
endlocal & exit /b %errorlevel%

rem ----------------------------------------------------------------------------
rem  Initialize
rem ----------------------------------------------------------------------------
:Initialize

    rem SQL Server�̃C���X�^���X��
    set SQL_SERVER_INSTANCE_NAME=SQLEXPRESS

    rem SQL Server�֘A�̃T�[�r�X
    set SERVICE_LIST=
    set SERVICE_LIST=%SERVICE_LIST%  MSSQL$%SQL_SERVER_INSTANCE_NAME%
rem set SERVICE_LIST=%SERVICE_LIST%  MSSQLFDLauncher$%SQL_SERVER_INSTANCE_NAME%
rem set SERVICE_LIST=%SERVICE_LIST%  SQLAgent$%SQL_SERVER_INSTANCE_NAME%
rem set SERVICE_LIST=%SERVICE_LIST%  SQLTELEMETRY$%SQL_SERVER_INSTANCE_NAME%
rem set SERVICE_LIST=%SERVICE_LIST%  SQLBrowser
rem set SERVICE_LIST=%SERVICE_LIST%  SQLWriter

    exit /b

rem ----------------------------------------------------------------------------
rem  Main
rem ----------------------------------------------------------------------------
:Main

    call :Initialize

    for %%i in (%SERVICE_LIST%) do call :Start_Service %%i

    echo.
    pause
    exit /b 0

rem ----------------------------------------------------------------------------
rem  Start_Service
rem ----------------------------------------------------------------------------
:Start_Service

    sc query "%~1" | findstr STATE | findstr RUNNING > nul

    if "%errorlevel%"=="0" (
        echo �T�[�r�X %~1 �͊��ɊJ�n���Ă��܂��B
        exit /b 1
    )

    net start "%~1"

    if not "%errorlevel%"=="0" (
        echo �T�[�r�X %~1 �̊J�n�Ɏ��s���܂����B
        exit /b 2
    )

    exit /b 0

