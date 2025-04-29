<div align = center>
<img alt="Dynamic JSON Badge" src="https://cdn1.iconfinder.com/data/icons/hawcons/32/699818-icon-55-file-3gp-512.png">
    </a>
</div>
  <h3 align="center">3GP CONVERST</h3>

  <p align="center">
    3GP CONVERST - VIDEO TO 3GP CONVERTER</p>

<div align="center">
<br>

  <a href="#INTRODUCE"><kbd> <br> INTRODUCE <br> </kbd></a>&ensp;&ensp;
  <a href="#INSTALL"><kbd> <br> INSTALL <br> </kbd></a>&ensp;&ensp;
  <a href="#UPDATE"><kbd> <br> UPDATE <br> </kbd></a>&ensp;&ensp;
  <a href="#RUN"><kbd> <br> RUN <br> </kbd></a>&ensp;&ensp;
  <a href="#NOTE"><kbd> <br> NOTE <br> </kbd></a>&ensp;&ensp;
  </div><br><br>

## INTRODUCE
3GP CONVERST - VIDEO TO 3GP CONVERTER

> 3GP CONVERST - VIDEO TO 3GP CONVERTER là một trình chuyển đổi video mp4 thành 3gp được viết bằng bash ( định dạng video cho điện thoại ngày xưa )

Tính năng nổi bật:

🔍 Chuyển đổi tất cả video có tên là mp4 thành 3gp

💻 đặt tên thứ tự file ( ví dụ trong thư mục của bạn có 20 file thì chương trình sẽ dặt tên từng file 3gp là 1.3gp,... 20.3gp )

<div align="right">
  <br>
</div>

## INSTALL 

Đối với ubuntu

```shell
sudo apt install ffmpeg zenity
```

Đối với Arch linux
```shell
sudo pacman -S ffmpeg zenity
```

<div align="right">
  <br>
</div>

## UPDATE

- giảm 20 fps xuống 15 fps
- giảm độ phân giải 
- giảm bitrate video
- giảm chất lượng video
...


### Giải thích chi tiết:

1 Lặp qua tất cả các tệp .mp4 trong thư mục hiện tại
```shell
for file in *.mp4; do
```

2 Kiểm tra xem tệp có phải là .mp4 không
```shell
if [[ -f "$file" && "$file" == *.mp4 ]]; then

```

3 Tạo tên tệp đầu ra
```shell
output_file="$output_dir/$counter.3gp"
```

4 Chuyển đổi tệp .mp4 sang .3gp bằng ffmpeg 
```shell
ffmpeg -y -i "$file" \
    -r 20 -s 352x288 -vb 400k \
    -acodec aac -strict experimental -ac 1 -ar 8000 -ab 24k \
    "$output_file"
```

5 Đặt tên file theo số thứ tự
```shell
((counter++))
```
<div align="right">
  <br>
</div>

## RUN
> 1. Bạn chuyển hết video mà bạn muốn chuyển đổi vào 1 thư mục

>2. Sao chép file 3gp.sh để file thực thi việc chuyển đổi video trong thư mục đó

>3. Sau đó hãy chạy file và toàn bộ video mp4 sẽ được chuyển thành 3gp trong giây lát

<div align="right">
  <br>
</div>

## NOTE
> FILE CHUYỂN ĐỔI NÀY SẼ BIẾN ĐỔI TỆP ĐẦU RA NHIỀU HƠN DUNG LƯỢNG CỦA TỆP ĐẦU VÀO ( TRƯỚC KHI CHUYỂN ĐỔI VIDEO HÃY TẢI VIDEO Ở CHẤT LƯỢNG 144 ĐỂ KHÔNG BỊ QUÁ TẢI DUNG LƯỢNG)

<div align="right">
  <br>
</div>

CẢM ƠN VÌ ĐÃ ĐỌC
NIYAKI PHẠM
