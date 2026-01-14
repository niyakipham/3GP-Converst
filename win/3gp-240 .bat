@echo off
setlocal enabledelayedexpansion
title FFMPEG ULTIMATE CONVERTER v4.0

:: ------------- 1. CẤU HÌNH MÀU SẮC ----------------------------
:: ANSI Colors cho Windows 10/11
set "COLOR_HEADER=[38;5;201m"
set "COLOR_FILE=[38;5;81m"
set "COLOR_TIME=[38;5;227m"
set "COLOR_SUCCESS=[38;5;48m"
set "COLOR_ERROR=[38;5;196m"
set "RESET=[0m"

:: ------------- 2. CHỌN THƯ MỤC NGUỒN --------------------------
echo %COLOR_HEADER%--- FFMPEG ULTIMATE CONVERTER v4.0 ---%RESET%
echo Đang mở hộp thoại chọn thư mục...

set "psCommand="(new-object -COM 'Shell.Application').BrowseForFolder(0,'Chon thu muc chua video MP4',0,0).Self.Path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "input_dir=%%I"

if "%input_dir%"=="" (
    echo %COLOR_ERROR%[!] Khong co thu muc nao duoc chon. Thoat...%RESET%
    pause
    exit /b
)

:: ------------- 3. TẠO THƯ MỤC ĐÍCH ----------------------------
set "timestamp=%date:~10,4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%"
set "timestamp=%timestamp: =0%"
set "output_dir=%input_dir%\converted_3gp_%timestamp%"

mkdir "%output_dir%"
echo %COLOR_HEADER%📂 Thu muc nguon:%COLOR_FILE% %input_dir%
echo %COLOR_HEADER%📂 Thu muc dich:%COLOR_FILE% %output_dir%%RESET%

:: ------------- 4. KIỂM TRA FFMPEG -----------------------------
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo %COLOR_ERROR%[!] Khong tim thay ffmpeg. Hay cai dat va them vao PATH.%RESET%
    pause
    exit /b
)

:: ------------- 5. BẮT ĐẦU CHUYỂN ĐỔI --------------------------
set /a total=0
set /a current=0

:: Đếm tổng số file
for %%f in ("%input_dir%\*.mp4") do set /a total+=1

if %total% equ 0 (
    echo %COLOR_ERROR%[!] Khong tim thay file .mp4 nao trong thu muc.%RESET%
    pause
    exit /b
)

echo %COLOR_TIME%[INFO] Phat hien %total% file. Bat dau xu ly...%RESET%

for %%i in ("%input_dir%\*.mp4") do (
    set /a current+=1
    echo.
    echo %COLOR_TIME%[%time%] %COLOR_FILE%[%current%/%total%] Dang xu ly: %%~nxi%RESET%
    
    ffmpeg -y -i "%%i" ^
        -c:v h263 -s 352x288 -r 15 -b:v 128k ^
        -c:a aac -ar 44100 -ac 2 ^
        "%output_dir%\%%~ni.3gp" -loglevel error

    if !errorlevel! equ 0 (
        echo %COLOR_SUCCESS%[OK] Hoan thanh: %%~ni.3gp%RESET%
    ) else (
        echo %COLOR_ERROR%[X] Loi khi chuyen doi: %%~nxi%RESET%
    )
)

:: ------------- 6. KẾT THÚC ------------------------------------
echo.
echo %COLOR_HEADER%==============================================%RESET%
echo %COLOR_SUCCESS% THANH CONG! Da xu ly %current%/%total% file.
echo %COLOR_HEADER%==============================================%RESET%
echo Dang mo thu muc ket qua...
start "" "%output_dir%"
pause
