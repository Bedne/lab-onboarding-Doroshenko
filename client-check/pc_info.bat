@echo off
chcp 65001 > nul

REM Тема: Диагностика клиентского компьютера
REM Фамилия: Дорошенко
REM Дата: 2026

echo ====================================
echo         ДИАГНОСТИКА КОМПЬЮТЕРА
echo ====================================
echo.

REM Сохранение заголовка в отчет
echo ==================================== > "%~dp0pc_report.txt"
echo         ДИАГНОСТИКА КОМПЬЮТЕРА >> "%~dp0pc_report.txt"
echo ==================================== >> "%~dp0pc_report.txt"
echo. >> "%~dp0pc_report.txt"

REM --- 1. Операционная система ---
echo [Операционная система]
echo [Операционная система] >> "%~dp0pc_report.txt"
wmic os get Caption,Version /format:list
wmic os get Caption,Version /format:list >> "%~dp0pc_report.txt"
echo.
echo. >> "%~dp0pc_report.txt"

REM --- 2. Процессор ---
echo [Процессор]
echo [Процессор] >> "%~dp0pc_report.txt"
wmic cpu get Name /format:list
wmic cpu get Name /format:list >> "%~dp0pc_report.txt"
echo.
echo. >> "%~dp0pc_report.txt"

REM --- 3. Оперативная память ---
echo [Оперативная память]
echo [Оперативная память] >> "%~dp0pc_report.txt"
for /f "tokens=2 delims==" %%a in ('wmic OS get TotalVisibleMemorySize /value') do set total_kb=%%a
for /f "tokens=2 delims==" %%a in ('wmic OS get FreePhysicalMemory /value') do set free_kb=%%a
set /a total_gb=%total_kb% / 1048576
set /a free_gb=%free_kb% / 1048576
echo Всего памяти: %total_gb% ГБ
echo Свободно памяти: %free_gb% ГБ
echo Всего памяти: %total_gb% ГБ >> "%~dp0pc_report.txt"
echo Свободно памяти: %free_gb% ГБ >> "%~dp0pc_report.txt"
echo.
echo. >> "%~dp0pc_report.txt"

REM --- 4. Свободное место на диске C ---
echo [Диск C]
echo [Диск C] >> "%~dp0pc_report.txt"
for /f "tokens=2 delims==" %%a in ('wmic logicaldisk where DeviceID^='C:' get Size /value') do set size_b=%%a
for /f "tokens=2 delims==" %%a in ('wmic logicaldisk where DeviceID^='C:' get FreeSpace /value') do set free_b=%%a
set /a size_gb=%size_b% / 1073741824
set /a free_gb_disk=%free_b% / 1073741824
echo Размер диска C: %size_gb% ГБ
echo Свободно на диске C: %free_gb_disk% ГБ
echo Размер диска C: %size_gb% ГБ >> "%~dp0pc_report.txt"
echo Свободно на диске C: %free_gb_disk% ГБ >> "%~dp0pc_report.txt"
echo.
echo. >> "%~dp0pc_report.txt"

REM --- 5. Список установленных программ ---
echo [Установленные программы]
echo [Установленные программы] >> "%~dp0pc_report.txt"
echo Идёт поиск программ, это может занять минуту...
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B /C:"    DisplayName"
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr /B /C:"    DisplayName" >> "%~dp0pc_report.txt"
echo.
echo. >> "%~dp0pc_report.txt"

echo Отчёт сохранён
echo Отчёт сохранён >> "%~dp0pc_report.txt"
pause