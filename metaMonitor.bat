@echo off
setlocal enabledelayedexpansion

set "TIMEOUT=60"
set "START_DELAY=30"
set "TERMINALS_FILE=terminals.txt"
set "LOG_FILE=metaMonitor.log"

if not exist "%TERMINALS_FILE%" (
    echo ERROR: %TERMINALS_FILE% not found.
    echo Please ensure the file "%TERMINALS_FILE%" exists and contains valid paths to at least one MetaTrader terminal
    pause
    exit /b
)

:loop
cls
set "online_terminals="

:: Validate terminals file is not empty (excluding comments)
set "valid_lines=0"
for /f "usebackq delims=" %%l in ("%TERMINALS_FILE%") do (
    set "line=%%l"
    set "firstChar=!line:~0,1!"
    if not "!firstChar!"=="#" if not "!line!"=="" (
        set /a valid_lines+=1
    )
)
if !valid_lines! LSS 1 (
    echo ERROR: %TERMINALS_FILE% is empty or contains only comments.
    echo Please add valid paths to Metatrader terminals
    timeout /t %START_DELAY%
    goto loop
)

echo -----------------------------------
echo --------  metaMonitor v1.0 --------
echo -----------------------------------

:: Get the list of running terminal processes (both terminal.exe and terminal64.exe)
for /f "delims=" %%p in ('wmic process where "name='terminal.exe'" get executablepath ^| find /I "C:\"') do (
    set "online_terminals=!online_terminals! %%p"
)
for /f "delims=" %%p in ('wmic process where "name='terminal64.exe'" get executablepath ^| find /I "C:\"') do (
    set "online_terminals=!online_terminals! %%p"
)

:: Loop through the terminals file and check which ones are not running
for /f "usebackq delims=" %%t in ("%TERMINALS_FILE%") do (
    set "line=%%t"
    set "firstChar=!line:~0,1!"
    if "!firstChar!"=="#" (
        rem Skip commented line
    ) else if "!line!"=="" (
        rem Skip empty line
    ) else (
        :: Get the current date and time
        for /f "tokens=1,2 delims= " %%d in ('echo %date% %time%') do set "datetime=%%d %%e"

        set "full_path=%%t"
        set "exe_path="
        set "lnk_path="

        :: Check if the line contains a semicolon
        echo %%t | find ";" >nul
        if not errorlevel 1 (
            for /f "tokens=1,2 delims=;" %%a in ("%%t") do (
                set "exe_path=%%a"
                set "lnk_path=%%b"
            )
        ) else (
            set "exe_path=%%t"
        )

        :: Check if the file exists before proceeding
        if not exist "!exe_path!" (
            echo !datetime! - NOT FOUND!!!:  !exe_path!
            echo !datetime! - NOT FOUND!!!:  !exe_path! >> "%LOG_FILE%"
        ) else (
            :: Compare the terminal path with the list of running terminals
            echo !online_terminals! | find /I "!exe_path!" > nul

            if errorlevel 1 (
                if defined lnk_path (
                    start "" "!lnk_path!"
                    echo !datetime! - START:  !lnk_path!
                    echo !datetime! - START:  !lnk_path! >> "%LOG_FILE%"
                ) else (
                    start "" "!exe_path!"
                    echo !datetime! - START:  !exe_path!
                    echo !datetime! - START:  !exe_path! >> "%LOG_FILE%"
                )
                timeout /t %START_DELAY% /nobreak >nul
            ) else (
                echo !datetime! - ONLINE: !exe_path!
            )
        )
    )
)

timeout /t %TIMEOUT% /nobreak
goto loop
