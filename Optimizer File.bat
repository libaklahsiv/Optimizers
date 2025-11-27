@echo off
color 0A
title VISHAL'S ULTIMATE FPS OPTIMIZER
cls

echo ===========================================================
echo       🔧 VISHAL'S ULTIMATE FPS & SYSTEM OPTIMIZER 🔧
echo ===========================================================
echo.
echo  Please wait while performance and FPS tweaks are applied...
echo  (Run this file as ADMINISTRATOR!)
echo.

:: Disable power throttling
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f

:: Set power plan to Ultimate Performance (for desktop)
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg -setactive e9a42b02-d5df-448d-aa00-03f14749eb61

:: Disable unnecessary services
sc stop "SysMain" >nul 2>&1
sc config "SysMain" start=disabled
sc stop "WSearch" >nul 2>&1
sc config "WSearch" start=disabled
sc stop "DiagTrack" >nul 2>&1
sc config "DiagTrack" start=disabled
sc stop "dmwappushservice" >nul 2>&1
sc config "dmwappushservice" start=disabled
sc stop "RetailDemo" >nul 2>&1
sc config "RetailDemo" start=disabled
sc stop "Fax" >nul 2>&1
sc config "Fax" start=disabled
sc stop "RemoteRegistry" >nul 2>&1
sc config "RemoteRegistry" start=disabled

:: Disable GameDVR, Xbox Game Bar, Background Recording
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\GameBar" /v ShowGameBar /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f

:: Disable Cortana & Telemetry
reg add "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f

:: Disable Background Apps
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f

:: Enable hardware-accelerated GPU scheduling (Windows 10/11)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f

:: Clear temp and prefetch files
del /f /s /q %temp%\*
del /f /s /q C:\Windows\Temp\*
del /f /s /q C:\Windows\Prefetch\*

:: Empty recycle bin
PowerShell -Command "Clear-RecycleBin -Force" >nul

:: Clear Standby RAM (optional if EmptyStandbyList.exe available)
echo Clearing RAM cache...
if exist "%temp%\EmptyStandbyList.exe" (
    "%temp%\EmptyStandbyList.exe" standbylist
) else (
    echo Downloading RAM cleaner...
    powershell -Command "Invoke-WebRequest -Uri https://live.sysinternals.com/EmptyStandbyList.exe -OutFile %temp%\EmptyStandbyList.exe"
    "%temp%\EmptyStandbyList.exe" standbylist
)

:: Disable OneDrive
taskkill /f /im OneDrive.exe >nul 2>&1
%SystemRoot%\System32\OneDriveSetup.exe /uninstall

:: Disable Startup Apps (Reg-based)
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /f

:: Network Tweaks
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global rss=enabled
netsh int tcp set global chimney=enabled
netsh int tcp set global netdma=enabled

:: Disable Windows Tips
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 0 /f

:: Restart Explorer to apply UI tweaks
taskkill /f /im explorer.exe
start explorer.exe

echo.
echo ✅ All optimizations applied successfully!
echo 🔄 It is recommended to reboot your PC for full effect.
echo.
pause
exit
