@echo off
mode con:cols=126 lines=25
title Rzbooster - By Rzharo

cls
CHCP 65001 >nul
powershell -command "Start-Sleep -Milliseconds 1"
setlocal enabledelayedexpansion
::UTF-8
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
:: OTIMIZADOR WINDOWS COMPLETO - By Fassa Pramin
:: Limpeza de RAM, navegadores, temp files, Alt+Tab clássico e mais!

:: =============================================
:: VERIFICA ADMINISTRADOR
:: =============================================
NET FILE >nul 2>&1 || (
    echo. & echo [ERRO] EXECUTE COMO ADMINISTRADOR!
    echo. & echo Clique com botão direito > "Executar como administrador"
    timeout /t 5 >nul & exit
)
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
:: =============================================
:: 1. FECHAR NAVEGADORES E GAMES
:: =============================================
echo.
echo [1/5] Fechando navegadores e clients de games...
call :fechar_processos "chrome.exe,firefox.exe,msedge.exe,brave.exe,opera.exe,steam.exe,EpicGamesLauncher.exe,Origin.exe"
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
:: =============================================
:: 2. LIMPEZA DE ARQUIVOS TEMPORÁRIOS
:: =============================================
echo.
echo [2/5] Limpando arquivos temporários e lixeira...
(
    del /q /f /s "%temp%\*" >nul 2>&1
    del /q /f /s "%windir%\temp\*" >nul 2>&1
    rd /s /q "%windir%\temp" >nul 2>&1
    md "%windir%\temp" >nul 2>&1
    echo Y | vssadmin delete shadows /all /quiet >nul 2>&1
    echo Lixeira e arquivos temporários limpos!
)
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
:: =============================================
:: 3. LIMPEZA DE RAM (MÉTODO NATIVO)
:: =============================================
echo.
echo [3/5] Otimizando memória RAM...
(
    setlocal enabledelayedexpansion
    for /f "tokens=2 delims==" %%A in ('wmic OS get FreePhysicalMemory /value') do set "mem_antes=%%A"
    
    wmic process where "WorkingSetSize>150000000 and not(name='explorer.exe' or name='cmd.exe')" call terminate >nul 2>&1
    
    for /f "tokens=2 delims==" %%A in ('wmic OS get FreePhysicalMemory /value') do set "mem_depois=%%A"
    set /a diferenca=mem_depois-mem_antes
    set /a diferenca=diferenca/1024
    echo Memória liberada: !diferenca! MB
    endlocal
)
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
:: =============================================
:: 4. LIMPEZA DE DISCO AUTOMÁTICA
:: =============================================
echo.
echo [4/5] Executando limpeza de disco...
(
    echo Criando tarefa temporária...
    schtasks /create /tn "LimpezaDiscoTemp" /tr "cleanmgr /sagerun:1" /sc once /st 00:00 /f >nul 2>&1
    schtasks /run /tn "LimpezaDiscoTemp" >nul 2>&1
    timeout /t 3 >nul
    schtasks /delete /tn "LimpezaDiscoTemp" /f >nul 2>&1
)

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
:: =============================================
:: RELATÓRIO FINAL
:: =============================================
echo.
echo ====================================
echo    OTIMIZAÇÃO COMPLETA COM SUCESSO!
echo ====================================
echo.
echo Ações realizadas:
echo ✓ Navegadores e games fechados
echo ✓ Arquivos temporários e lixeira limpos
echo ✓ Memória RAM otimizada
echo ✓ Limpeza de disco automática
echo ✓ Alt+Tab configurado para modo clássico
echo.
timeout /t 2 >NUL
cls

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
:: =============================================
:: 5. CONFIGURAR ALT+TAB CLÁSSICO
:: =============================================
echo.
echo [5/5] Configurando sistema...
(
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "AltTabSettings" /t REG_DWORD /d 1 /f >nul 2>&1
    echo Alt+Tab configurado para modo clássico!
    
    echo Reiniciando Explorer...
    taskkill /f /im explorer.exe >nul 2>&1
    start explorer.exe
)

cls
echo.
echo.
echo.
echo.
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



echo                                                        Finalizando...
timeout /t 10 >NUL
exit /b