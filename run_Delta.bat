@ECHO OFF

:: -------------------------------------------------------
:: 0 : Do NOT execute tests for the platform
:: Anything else(e.g. 1) : Execute tests for the platform 
:: -------------------------------------------------------
 
 SET DESKTOP_AM_EN=1
 SET BROWSERSTACK_AM_EN=0
 
:: -------------------------------------------------------

 
SET PROJECT_DIR=%CD%


:: TEST SUITE CAPBILITIES
:: include or exclude test scenarios and/or story files (e.g. "-skip,+checkout")
:: -: means exclude
:: +: means include
 SET PARAM="-skip,+Delta"

:: MAVEN EXECUTION PROFILE
 SET SINGLETHREAD=singlethread
 SET PARALLEL=parallel
 SET MULTITHREAD=multithread

REM set profile for building 
 SET PROFILE=%SINGLETHREAD%

:: TEST RESULTS LOCATION
 SET TEST_RESULTS=TestResults
 

REM =================================== DESKTOP ========================================

REM ---------- AMAZON (English) ----------
 
:DESKTOP_DT_EN

:: chrome, iexplorer, firefox 
 SET BROWSER=firefox
 SET BRAND=DT
 SET LAN=EN
 SET PLATFORM=DESKTOP
 
SET SOURCE=%PROJECT_DIR%\src\test\resources\test_data\%BRAND%
SET DESTINATION=%PROJECT_DIR%\src\test\resources
 
 echo --- Creating Test Results folder...
 
 MD %PROJECT_DIR%\%TEST_RESULTS%\%BRAND%_%TEST_ENV%_%PLATFORM%_%LAN%_%TEST_RESULTS%\site\thucydides 
 COPY %PROJECT_DIR%\index.html  %PROJECT_DIR%\%TEST_RESULTS%\%BRAND%_%TEST_ENV%_%PLATFORM%_%LAN%_%TEST_RESULTS%\site\thucydides\index.html
 
 IF NOT %DESKTOP_AM_EN%==1 GOTO BROWSERSTACK_AM_EN
 echo --- Testing DESKTOP_DT_EN
 SET BASE_URL=https://www.delta.com/
 
 SET META_FILTER=%PARAM%
 echo --- calling run.bat file...
 
CALL %PROJECT_DIR%\run.bat

REM =================================== BROWSERSTACK ========================================

:: BROWSERSTACK CREDENTIALS

SET USERNAME=pimrankhan1
SET AUTOMATE_KEY=7iQhgw9qUxTW8mksCqpX
SET BROWSERSTACK_URL=http://%USERNAME%:%AUTOMATE_KEY%@hub.browserstack.com/wd/hub
SET BROWSERSTACK_BUILD=ContinuiT-Browserstack-Demo

REM ---------- AMAZON (English) ----------
 
:BROWSERSTACK_AM_EN

:: ENVIRONMENT CAPABILITIES
 SET BRAND=AM
 SET LAN=EN
 SET PLATFORM=BROWSERSTACK
 
SET SOURCE=%PROJECT_DIR%\src\test\resources\test_data\%BRAND%
SET DESTINATION=%PROJECT_DIR%\src\test\resources
 
:: OS and VERSION
SET BROWSERSTACK_OS=Windows
SET BROWSERSTACK_OS_VERSION=7

:: BROWSER CAPABILITIES 
 SET BROWSER=Chrome
 SET BROWSER_VERSION=43.0
 
 echo --- Creating Test Results folder...
 
 MD %PROJECT_DIR%\%TEST_RESULTS%\%BRAND%_%PLATFORM%_%LAN%_%TEST_RESULTS%\site\thucydides 
 COPY %PROJECT_DIR%\index.html  %PROJECT_DIR%\%TEST_RESULTS%\%BRAND%_%PLATFORM%_%LAN%_%TEST_RESULTS%\site\thucydides\index.html
 
 IF NOT %BROWSERSTACK_AM_EN%==1 GOTO END
 echo --- Testing BROWSERSTACK_AM_EN
 SET BASE_URL=https://www.amazon.in
 
 SET META_FILTER=%PARAM%
 echo --- calling run.bat file...
 
CALL %PROJECT_DIR%\run.bat

