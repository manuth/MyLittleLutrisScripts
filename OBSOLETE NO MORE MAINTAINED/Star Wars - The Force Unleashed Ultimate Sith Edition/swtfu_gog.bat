@echo off
title Star Wars - The Force Unleashed - Ultimate Sith Edition
color FC
c:

goto :launcher

:launcher

rem create config folder and copy default config files
call :copyconfig

cls
echo.
echo.
echo.	-------------------------------------------------------
echo.	Star Wars - The Force Unleashed - Ultimate Sith Edition
echo.	-------------------------------------------------------
echo.
echo.	1) Play with keyboard and mouse
echo.	2) Play with x360 compatible controller
echo.	3) Edit game config
echo.	4) Change game language
echo.	5) Exit
echo.
echo.	-------------------------------------------------------
echo.
echo.

choice /c12345 /s /N Your choice? [1-5]:
if errorlevel 5 goto :exit
if errorlevel 4 goto :language
if errorlevel 3 goto :config
if errorlevel 2 goto :play2
if errorlevel 1 goto :play1

:play1
c:\tmp\sed.exe -i "s/IsKBAndMouse\".*/IsKBAndMouse\">TRUE<\/s>/g" c:\tmp\config.xml & call :copyconfig
start "" "c:\GOG Games\Star Wars - The Force Unleashed Ultimate Sith Edition\swtfu.exe"
goto :launcher

:play2
c:\tmp\sed.exe -i "s/IsKBAndMouse\".*/IsKBAndMouse\">FALSE<\/s>/g" c:\tmp\config.xml & call :copyconfig 
start "" "c:\GOG Games\Star Wars - The Force Unleashed Ultimate Sith Edition\swtfu.exe"
goto :launcher

:config
notepad.exe c:\tmp\Config.xml & call :copyconfig
goto :launcher

:language
cls
echo.
echo.
echo.	-------------------------------------------------------
echo.	Star Wars - The Force Unleashed - Ultimate Sith Edition
echo.	-------------------------------------------------------
echo.
echo.	1) English
echo.	2) French
echo.	3) German
echo.	4) Italian
echo.	5) Spanish
echo.	6) Polish
echo.	7) Russian
echo.	8) Go back to main menu
echo.
echo.	-------------------------------------------------------

for /F "skip=2 tokens=3" %%A in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\aspyr\star wars the force unleashed" /v "Language"') do (
set varlang1=%%A
call :whichlang %%A
)
echo.	The game language is actually set to %varlang2%  (%varlang1%)

echo.	Choose your new preferred language for menus, subtitles
echo. 	and cutscenes:
echo.
choice /c12345678 /s /N     Your choice? [1-8]:

if errorlevel 8 goto :launcher
if errorlevel 7 call :lang ru & goto :language
if errorlevel 6 call :lang pl & goto :language
if errorlevel 5 call :lang es & goto :language
if errorlevel 4 call :lang it & goto :language
if errorlevel 3 call :lang de & goto :language
if errorlevel 2 call :lang fr & goto :language
if errorlevel 1 call :lang en & goto :language

:lang
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\aspyr\star wars the force unleashed" /t REG_SZ /v Language /d %1 /f
call :whichlang %1
set varlang1=%1
echo The game language is now actually set to %varlang2%  %varlang1%
pause
goto :eof

:whichlang
if "%1" == "en" set varlang2=English 
if "%1" == "fr" set varlang2=French
if "%1" == "de" set varlang2=German
if "%1" == "it" set varlang2=Italian
if "%1" == "es" set varlang2=Spanish
if "%1" == "pl" set varlang2=Polish
if "%1" == "ru" set varlang2=Russian
goto :eof

:copyconfig
if not exist "%userprofile%\AppData\Local\Aspyr\Star Wars Le Pouvoir de la Force" mkdir "%userprofile%\AppData\Local\Aspyr\Star Wars Le Pouvoir de la Force\"
if not exist "%userprofile%\AppData\Local\Aspyr\Star Wars The Force Unleashed\" mkdir "%userprofile%\AppData\Local\Aspyr\Star Wars The Force Unleashed\"
if not exist "%userprofile%\AppData\Local\Aspyr\Star Wars Il Potere della Forza\" mkdir "%userprofile%\AppData\Local\Aspyr\Star Wars Il Potere della Forza\"
if not exist "%userprofile%\AppData\Local\Aspyr\Star Wars El Poder de la Fuerza\" mkdir "%userprofile%\AppData\Local\Aspyr\Star Wars El Poder de la Fuerza\"

copy /Y "c:\tmp\Config.xml" "%userprofile%\AppData\Local\Aspyr\Star Wars Le Pouvoir de la Force\Config.xml"
copy /Y "c:\tmp\Config.xml" "%userprofile%\AppData\Local\Aspyr\Star Wars The Force Unleashed\Config.xml"
copy /Y "c:\tmp\Config.xml" "%userprofile%\AppData\Local\Aspyr\Star Wars Il Potere della Forza\Config.xml"
copy /Y "c:\tmp\Config.xml" "%userprofile%\AppData\Local\Aspyr\Star Wars El Poder de la Fuerza\Config.xml"
goto :eof

:exit
exit
