@echo off
set "newParameter=-pure_1"
set "shortcutFound=false"

echo Adding %newParameter% to FiveM shortcuts on the Desktop and in the Start Menu...

:: Define the paths to search
set "startMenuPath=%APPDATA%\Microsoft\Windows\Start Menu\Programs"
set "desktopPath=%USERPROFILE%\Desktop"
set "shortcutName=FiveM.lnk"

:: Search and modify the shortcut in the Start Menu
for %%f in ("%startMenuPath%\%shortcutName%") do (
    if exist "%%f" (
        echo Shortcut found in Start Menu: %%f. Modifying to include %newParameter%...
        set "shortcutFound=true"

        :: Add the parameter using PowerShell
        powershell -ExecutionPolicy Bypass -Command ^
        "$wsh = New-Object -ComObject WScript.Shell; " ^
        "$shortcut = $wsh.CreateShortcut('%%f'); " ^
        "if (-not $shortcut.Arguments.Contains('%newParameter%')) { " ^
        "$shortcut.Arguments += ' %newParameter%'; " ^
        "$shortcut.Save(); " ^
        "Write-Host 'Shortcut modified successfully with %newParameter%.' } " ^
        "else { Write-Host 'The shortcut already includes %newParameter%.' }"
    )
)

:: Search and modify the shortcut on the Desktop
for %%f in ("%desktopPath%\%shortcutName%") do (
    if exist "%%f" (
        echo Shortcut found on Desktop: %%f. Modifying to include %newParameter%...
        set "shortcutFound=true"

        :: Add the parameter using PowerShell
        powershell -ExecutionPolicy Bypass -Command ^
        "$wsh = New-Object -ComObject WScript.Shell; " ^
        "$shortcut = $wsh.CreateShortcut('%%f'); " ^
        "if (-not $shortcut.Arguments.Contains('%newParameter%')) { " ^
        "$shortcut.Arguments += ' %newParameter%'; " ^
        "$shortcut.Save(); " ^
        "Write-Host 'Shortcut modified successfully with %newParameter%.' } " ^
        "else { Write-Host 'The shortcut already includes %newParameter%.' }"
    )
)

if "%shortcutFound%" == "false" (
    echo FiveM shortcut not found in the Start Menu or on the Desktop.
)

pause
