@echo off
title APP
setlocal EnableDelayedExpansion

set x=0
for /f %%f in ('dir /a:d /b') do (
    if exist "%%f/exec.bat" (
        call:insert %%f
    )
)

set /a width=(%x%+1)*2
mode con: cols=50 lines=%width%

if %x% equ 0 (
    echo Sem aplicativos.
    pause
    exit
)

for /l %%i in (1,1,%x%) do (
    echo %%i - !apps[%%i]!
)

choice /c "%choices%" /n /m "Selecione uma das opcoes para abrir:"
set x=%errorlevel%
cd !apps[%x%]!
cls
title !apps[%x%]!
exec.bat


:insert
set /a x+=1
set apps[%x%]=%1
set choices=%choices%%x%

exit /b 0