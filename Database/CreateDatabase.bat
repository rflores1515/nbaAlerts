@echo off 
rem 
rem  
rem
rem  Usage:   CreateDatabase.bat  database_name_to_create db_server db_user_name db_password source_file_root_dir 
rem
rem  
rem

set result=false
if "%1%" == "" set result=true
if "%1%" == "?" set result=true
if "%1%" == "/?" set result=true
if "%1%" == "-?" set result=true
rem if "%2%" == "" set result=true
if "%result%" == "true" (
  echo.
  echo Usage: CreateDatabase.bat database_name_to_create db_server db_user_name db_password source_file_root_dir 
  echo.
  echo Example: CreateDatabase.bat MyTestDB 127.0.0.1 test test123 path
  EXIT /B
)

SetLocal EnableDelayedExpansion
set "separator=******************************************************************************"

rem no defaults for dbName
set "server=localhost"
set "user=test"
set "psw=test123"
set srcDir=%cd%

if not "%1"=="" set "dbName=%1"
if not "%2"=="" set "server=%2"
if not "%3"=="" set "user=%3"
if not "%4"=="" set "psw=%4"
if not "%5"=="" set "showlog=%5"
if not "%6"=="" set "srcDir=%6"

rem echo %dbName% %server% %user% %psw% %srcDir%

set "logFile=%srcDir%\CreateDatabase.log"
set "createCmd=CREATE DATABASE [%dbName%]"

echo.
echo Creating database %dbName%
rem >%logFile% echo Creating database %dbName% 
sqlcmd -U %user% -P %psw% -S %server% -d master -b -h-1 -Q "%createCmd%" >>%logFile%
if !ERRORLEVEL! NEQ 0 (
  echo.
  echo ERROR executing: "%createCmd%"
  echo ERROR executing: "%createCmd%" >> %logFile%
  EXIT /B !ERRORLEVEL!
)

echo.
echo. >>%logFile%
echo Creating the schema 
echo Creating the schema >> %logFile%
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\schema\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile%
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo .
echo. >>%logFile%
echo Creating Functions
echo Creating Functions >> %logFile%
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\functions\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile% 
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo.
echo. >>%logFile%
echo Creating views
echo Creating views >> %logFile%
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\views\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >>%logFile%
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo .
echo. >>%logFile%
echo Creating stored procedures
echo Creating stored procedures >> %logFile%
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\procs\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile% 
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo.
echo. >>%logFile%
echo Populating configuration data 
echo Populating configuration data >> %logFile%
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\data\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile% 
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo.
echo. >>%logFile%
echo Adding triggers 
echo Adding triggers >> %logFile%
rem somehow this gets lost
set "separator=******************************************************************************"
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\triggers\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile% 
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo.
echo. >>%logFile%
echo Adding indexes 
echo Adding indexes >> %logFile%
rem somehow this gets lost
set "separator=******************************************************************************"
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\indexes\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile% 
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo.
echo. >>%logFile%
echo Adding constraints 
echo Adding constraints >> %logFile%
rem somehow this gets lost
set "separator=******************************************************************************"
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\constraints\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile% 
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)

echo.
echo. >>%logFile%
echo Populating unit test data 
echo Populating unit test data >> %logFile%
echo %separator%
echo %separator% >> %logFile%
set "workDir=%srcDir%\unittestdata\*.sql"
FOR %%f IN (%workDir%) DO (
  echo !time!: %%~nxf 
  echo !time!: %%~nxf >> %logFile% 
  sqlcmd -U %user% -P %psw% -S %server% -d %dbName% -b -h-1 -i %%f >>%logFile%
  if !ERRORLEVEL! NEQ 0 (
    echo.
    echo ERROR in: %%f
    echo ERROR in: %%f >> %logFile%
    EXIT /B !ERRORLEVEL!
  )
)


echo.
echo Script executed successfully
echo Script executed successfully >> %logFile%
echo Log file: %logFile%

IF "%showlog%" == "true" (
start notepad %logFile%
)