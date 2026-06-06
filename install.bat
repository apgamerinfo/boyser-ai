@echo off
rem Install BOYSER AI on Windows: venv + deps + skills + `boyser-ai` launcher
setlocal
set "DIR=%~dp0"

where python >nul 2>nul
if errorlevel 1 (
    echo Python 3 is required - install from https://python.org and tick "Add to PATH"
    exit /b 1
)

echo - Creating virtualenv...
python -m venv "%DIR%.venv" || exit /b 1
"%DIR%.venv\Scripts\python.exe" -m pip install --upgrade pip -q
echo - Installing dependencies...
"%DIR%.venv\Scripts\pip.exe" install -r "%DIR%requirements.txt" -q || exit /b 1

echo - Installing skills (only ones not already present)...
set "SKILLS=%USERPROFILE%\.config\boyser-ai\skills"
if not exist "%SKILLS%" mkdir "%SKILLS%"
for /d %%s in ("%DIR%skills\*") do (
    if not exist "%SKILLS%\%%~nxs" xcopy /e /i /q "%%s" "%SKILLS%\%%~nxs" >nul
)

echo - Creating launcher boyser-ai.cmd...
set "BIN=%USERPROFILE%\.local\bin"
if not exist "%BIN%" mkdir "%BIN%"
(
    echo @echo off
    echo "%DIR%.venv\Scripts\python.exe" "%DIR%agent.py" %%*
) > "%BIN%\boyser-ai.cmd"

rem Add %BIN% to user PATH if missing (via PowerShell - setx truncates PATH over 1024 chars)
powershell -NoProfile -Command "$d='%BIN%'; $p=[Environment]::GetEnvironmentVariable('Path','User'); if (($p -split ';') -notcontains $d) { [Environment]::SetEnvironmentVariable('Path', $p + ';' + $d, 'User'); Write-Host ('- Added ' + $d + ' to PATH (open a NEW terminal before use)') }"

echo.
echo Done! Open a new terminal and run: boyser-ai   (first run shows the setup wizard)
endlocal
