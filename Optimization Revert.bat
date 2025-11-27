@echo off
color 0C
title VISHAL OPTIMIZATION - RESTORE DEFAULT SETTINGS
cls

echo =====================================================
echo     🔁 RESTORING DEFAULT WINDOWS PERFORMANCE SETTINGS
echo =====================================================
echo.

:: ------------------ Power Plan ------------------
echo [*] Restoring default 'Balanced' power plan...
powercfg -setactive a1841308-3541-4fab-bc81-f71556f20b4a
echo ✅ Power plan restored.

:: ------------------ Game Bar & Game Mode ------------------
echo [*] Re-enabling Game DVR and Game Bar...
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore" /f >nul 2>&1
echo ✅ Game features restored.

:: ------------------ Cortana & Telemetry ------------------
echo [*] Re-enabling Cortana and telemetry...
reg delete "HKLM\Software\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
echo ✅ Cortana & telemetry restored.

:: ------------------ Background Apps ------------------
echo [*] Re-enabling background apps...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1
echo ✅ Background apps re-enabled.

:: ------------------ GPU Scheduling ------------------
echo [*] Resetting GPU hardware-accelerated scheduling...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /f >nul 2>&1
echo ✅ GPU scheduling setting restored.

:: ------------------ Power Throttling ------------------
echo [*] Enabling power throttling...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /f >nul 2>&1
echo ✅ Power throttling re-enabled.

:: ------------------ Essential Services ------------------
echo [*] Re-enabling essential Windows services...

sc config "SysMain" start=auto >nul 2>&1
sc start "SysMain" >nul 2>&1
echo ✅ SysMain (Superfetch) enabled.

sc config "WSearch" start=delayed-auto >nul 2>&1
sc start "WSearch" >nul 2>&1
echo ✅ Windows Search service enabled.

sc config "DiagTrack" start=auto >nul 2>&1
sc start "DiagTrack" >nul 2>&1
echo ✅ Diagnostics Tracking enabled.

sc config "dmwappushservice" start=manual >nul 2>&1
echo ✅ DMWAppPush service reset.

sc config "RetailDemo" start=manual >nul 2>&1
echo ✅ Retail Demo service reset.

sc config "Fax" start=manual >nul 2>&1
echo ✅ Fax service reset.

sc config "RemoteRegistry" start=manual >nul 2>&1
echo ✅ Remote Registry service reset.

:: ------------------ Windows Tips ------------------
echo [*] Re-enabling Windows Tips...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /f >nul 2>&1
echo ✅ Windows Tips restored.

:: ------------------ OneDrive ------------------
echo [*] Reinstalling OneDrive (if available)...
if exist "%SystemRoot%\SysWOW64\OneDriveSetup.exe" (
    "%SystemRoot%\SysWOW64\OneDriveSetup.exe" /install
    echo ✅ OneDrive reinstall initiated.
) else (
    echo ⚠️ OneDrive installer not found. Skipped.
)

:: ------------------ Restart Explorer ------------------
echo [*] Restarting Windows Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo ✅ Explorer restarted.

:: ------------------ Done ------------------
echo.
echo 🎉 ALL DEFAULT SETTINGS SUCCESSFULLY RESTORED!
echo 🔄 PLEASE RESTART YOUR PC FOR FULL EFFECT.
echo.
pause
exit
