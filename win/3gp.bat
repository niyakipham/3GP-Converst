@echo off
setlocal enabledelayedexpansion

:: Đảm bảo rằng thư mục đầu ra tồn tại
set "output_dir=3gp"
if not exist "%output_dir%" mkdir "%output_dir%"

:: Biến đếm để đánh số tệp 3gp
set /a counter=1

:: Lặp qua tất cả các tệp mp4 trong thư mục hiện tại
for %%f in (*.mp4) do (
    echo Dang chuyen doi: %%f
    
    :: Chuyển đổi bằng ffmpeg
    ffmpeg -y -i "%%f" ^
        -r 15 -s 176x144 -b:v 50k ^
        -c:a aac -strict experimental -ac 1 -ar 8000 -b:a 24k ^
        -crf 51 -preset slow ^
        "%output_dir%\!counter!.3gp"

    :: Tăng biến đếm
    set /a counter+=1
)

echo Chuyen doi hoan tat. Cac tep 3gp da duoc luu trong thu muc '%output_dir%'.
pause
