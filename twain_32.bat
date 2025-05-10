@echo off
title Rzbooster - Nos faz eles copia

:: Elevar a administrador
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% NEQ 0 (
    echo Solicitando permissao de administrador...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: Cancelar reinicio pendente
shutdown /a >nul 2>&1

cls
CHCP 65001 >nul
powershell -command "Start-Sleep -Milliseconds 1"
setlocal enabledelayedexpansion
::UTF-8
mode con:cols=126 lines=30
start "" "C:\Windows\DtcInstall.exe"
powershell -command "Start-Sleep -Milliseconds 1"
cls

echo.
echo.
echo                  ooooooooo.               .o8                                        .                                     
echo                  `888   `Y88.            "888                                      .o8                                     
echo                   888   .d88'   oooooooo  888oooo.   .ooooo.   .ooooo.   .oooo.o .o888oo  .ooooo.  oooo d8b                
echo                   888ooo88P'   d'""7d8P   d88' `88b d88' `88b d88' `88b d88(  "8   888   d88' `88b `888""8P                
echo                   888`88b.       .d8P'    888   888 888   888 888   888 `"Y88b.    888   888ooo888  888                    
echo                   888  `88b.   .d8P'      888   888 888   888 888   888 o.  )88b   888 . 888    .o  888                    
echo                  o888o  o888o d8888888P   `Y8bod8P' `Y8bod8P' `Y8bod8P' 8""888P'   "888" `Y8bod8P' d888b                   
echo.
echo                                                      created by Rzharo
echo.
echo.
echo.
echo [1/8] Fazendo Limpeza Profunda...
del /f /s /q "%systemdrive%\$Recycle.Bin\*" >nul 2>&1
for /d %%x in ("%systemdrive%\$Recycle.Bin\*") do rd /s /q "%%x" >nul 2>&1

echo [2/8] Executando Cleanmgr automatico...
:: Apenas entradas seguras (sem histórico de usuário)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files" /v StateFlags0001 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin" /v StateFlags0001 /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files" /v StateFlags0001 /t REG_DWORD /d 2 /f
del /s /f /q "%TEMP%\*.*" >nul 2>&1
del /s /f /q "%USERPROFILE%\AppData\Local\Temp\*.*" >nul 2>&1
echo Limpando arquivos temporários do sistema...
del /s /f /q "C:\Windows\Temp\*.*" >nul 2>&1
del /s /f /q "C:\Windows\Logs\*.*" >nul 2>&1
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportArchive" >nul 2>&1
rd /s /q "C:\ProgramData\Microsoft\Windows\WER\ReportQueue" >nul 2>&1
net stop wuauserv >nul 2>&1
rd /s /q "C:\Windows\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache" >nul 2>&1
rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache" >nul 2>&1
del /s /f /q "C:\Windows\System32\DriverStore\FileRepository\*.log" >nul 2>&1
del /f /q "%ProgramData%\Microsoft\Diagnosis\ETLLogs\AutoLogger\*" >nul 2>&1
vssadmin delete shadows /for=C: /oldest /quiet >nul 2>&1
del /f /q "C:\Windows\Prefetch\*" >nul 2>&1
ipconfig /flushdns >nul
cls

echo.
echo.
echo                  ooooooooo.               .o8                                        .                                     
echo                  `888   `Y88.            "888                                      .o8                                     
echo                   888   .d88'   oooooooo  888oooo.   .ooooo.   .ooooo.   .oooo.o .o888oo  .ooooo.  oooo d8b                
echo                   888ooo88P'   d'""7d8P   d88' `88b d88' `88b d88' `88b d88(  "8   888   d88' `88b `888""8P                
echo                   888`88b.       .d8P'    888   888 888   888 888   888 `"Y88b.    888   888ooo888  888                    
echo                   888  `88b.   .d8P'      888   888 888   888 888   888 o.  )88b   888 . 888    .o  888                    
echo                  o888o  o888o d8888888P   `Y8bod8P' `Y8bod8P' `Y8bod8P' 8""888P'   "888" `Y8bod8P' d888b                   
echo.
echo                                                      created by Rzharo
echo.
echo.
echo.
echo [3/8] Limpando pastas temporarias e logs...
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" >nul 2>&1
del /f /s /q "%WINDIR%\Temp\*" >nul 2>&1
for /d %%i in ("%WINDIR%\Temp\*") do rd /s /q "%%i" >nul 2>&1
del /f /s /q "%WINDIR%\Logs\*" >nul 2>&1
del /f /s /q "%WINDIR%\SoftwareDistribution\Download\*" >nul 2>&1

echo [4/8] Finalizando navegadores e launchers de jogos...

:: Lista de navegadores e launchers
set "CLOSE_LIST=chrome.exe msedge.exe brave.exe opera.exe operaGX.exe firefox.exe steam.exe epicgameslauncher.exe origin.exe riotclientservices.exe battlenet.exe"

for %%P in (%CLOSE_LIST%) do (
    taskkill /f /im %%P >nul 2>&1
)

echo [5/8] Otimizando Memoria Ram...
start "" "C:\Windows\DtcInstall.exe"
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
ipconfig /flushdns
powershell -command "Clear-Host; [System.GC]::Collect()"
wmic startup get caption,command
del /f /q "%APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*" >nul 2>&1
del /f /q "%APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*" >nul 2>&1
timeout /t 1 >nul
cls

echo.
echo.
echo                  ooooooooo.               .o8                                        .                                     
echo                  `888   `Y88.            "888                                      .o8                                     
echo                   888   .d88'   oooooooo  888oooo.   .ooooo.   .ooooo.   .oooo.o .o888oo  .ooooo.  oooo d8b                
echo                   888ooo88P'   d'""7d8P   d88' `88b d88' `88b d88' `88b d88(  "8   888   d88' `88b `888""8P                
echo                   888`88b.       .d8P'    888   888 888   888 888   888 `"Y88b.    888   888ooo888  888                    
echo                   888  `88b.   .d8P'      888   888 888   888 888   888 o.  )88b   888 . 888    .o  888                    
echo                  o888o  o888o d8888888P   `Y8bod8P' `Y8bod8P' `Y8bod8P' 8""888P'   "888" `Y8bod8P' d888b                   
echo.
echo                                                      created by Rzharo
echo.
echo.
echo.
echo [6/8] Reiniciando Explorer...
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 1 >nul
start explorer.exe

echo [7/8] Evitando reinicio automatico...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f >nul
shutdown /a >nul 2>&1

echo [8/8] Ativando Alt+Tab classico (somente icones)...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v AltTabSettings /t REG_DWORD /d 1 /f >nul

echo Limpeza e otimizacao finalizadas com sucesso!
timeout /t 5 >NUL
powershell -Command "& { [reflection.assembly]::loadwithpartialname('System.Windows.Forms') | Out-Null; $n = new-object system.windows.forms.notifyicon; $n.icon = [System.Drawing.SystemIcons]::Information; $n.visible = $true; $n.showballoontip(5000, 'Rzbooster', 'Limpeza concluída com sucesso!', [system.windows.forms.tooltipicon]::Info); Start-Sleep -Seconds 6; $n.dispose() }"

exit
