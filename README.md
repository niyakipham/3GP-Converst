<div align = center>
    <a href="https://discord.gg/AYbJ9MJez7">
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
  <a href="#CMD"><kbd> <br> CMD <br> </kbd></a>&ensp;&ensp;
  <a href="#SERVICE"><kbd> <br> SERVICE <br> </kbd></a>&ensp;&ensp;
  <a href="#PRIVACY"><kbd> <br> PRIVACY <br> </kbd></a>&ensp;&ensp;
  <a href="https://discord.com/oauth2/authorize?client_id=1289528997088067606&permissions=2048&response_type=code&redirect_uri=https%3A%2F%2Fdiscord.com%2Foauth2%2Fauthorize%3Fclient_id%3D1289528997088067606%26permissions%3D8%26integration_type%3D0%26scope%3Dbot&integration_type=0&scope=bot+applications.commands.permissions.update"><kbd> <br> INVITE BOT <br> </kbd></a>&ensp;&ensp;
  <a href="https://discord.gg/te5eGwJZMU"><kbd> <br> Discord <br> </kbd></a>

  </div><br><br>

## INTRODUCE
3GP CONVERST - VIDEO TO 3GP CONVERTER

> 3GP CONVERST - VIDEO TO 3GP CONVERTER là một trình chuyển đổi video mp4 thành 3gp được viết bằng bash ( định dạng video cho điện thoại ngày xưa )

Tính năng nổi bật:

🔍 Chuyển đổi tất cả video có tên là mp4 thành 3gp

💻 đặt tên thứ tự file ( ví dụ trong thư mục của bạn có 20 file thì chương trình sẽ dặt tên từng file 3gp là 1.3gp,... 20.3gp )

<div align="right">
  <br>
  <a href="#-design-by-t2"><kbd> <br> 🡅 <br> </kbd></a>
</div>

## INSTALL 

Đối với ubuntu

```shell
sudo apt install ffmpeg
```

Đối với Arch linux
```shell
sudo pacman -S ffmpeg
```

<div align="right">
  <br>
  <a href="#-design-by-t2"><kbd> <br> 🡅 <br> </kbd></a>
</div>

## CMD

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
  <a href="#-design-by-t2"><kbd></kbd></a>
</div>

## SERVICE
> 1. Giới thiệu: Khi bạn thêm và sử dụng Bot Discord của chúng tôi (gọi là "Bot"), bạn đồng ý tuân thủ các điều khoản sau đây. Điều khoản này có thể được cập nhật bất kỳ lúc nào mà không cần thông báo trước, và bạn có trách nhiệm kiểm tra thường xuyên để cập nhật các thay đổi. 

>2. Điều kiện sử dụng: Bạn phải ít nhất 18 tuổi để sử dụng Discord và bot của chúng tôi, tuân thủ theo chính sách của Discord.

>3. Trách nhiệm: Chúng tôi cam kết bot sẽ không làm server của bạn tấn công, mã nguồn tôi đăng lên để dùng vào mục đích học tập, chúng tôi từ chối mọi trách nhiệm mà bạn dùng bot để làm mục đích xấu

>4. Nội dung và Quyền sở hữu trí tuệ:
** Tất cả mã nguồn, nội dung, và tài liệu liên quan đến bot đều thuộc sở hữu của chúng tôi hoặc đối tác hợp tác của chúng tôi, và được bảo vệ bởi các luật về sở hữu trí tuệ. Bạn không được phép sao chép, phân phối, hoặc chỉnh sửa bot mà không có sự cho phép bằng văn bản từ chúng tôi. **

>5. Cập nhật và thay đổi dịch vụ: Chúng tôi có quyền cập nhật, thay đổi hoặc thêm tính năng mới cho bot mà không cần thông báo trước. Các cập nhật có thể bao gồm sửa lỗi, thay đổi giao diện, hoặc bổ sung chức năng mới.

>6. Chấm dứt dịch vụ: Chúng tôi có quyền chấm dứt hoặc ngừng cung cấp Bot vào bất kỳ lúc nào mà không có trách nhiệm thông báo hoặc đền bù.

>7. Phản hồi và hỗ trợ: Người dùng có thể gửi phản hồi, báo lỗi, hoặc yêu cầu hỗ trợ qua các kênh chính thức của chúng tôi (ví dụ như GitHub hoặc Discord server hỗ trợ). Chúng tôi sẽ cố gắng hỗ trợ trong thời gian nhanh nhất có thể, nhưng không cam kết giải quyết tất cả vấn đề ngay lập tức. 

<div align="right">
  <br>
  <a href="#-design-by-t2"><kbd> <br> 🡅 <br> </kbd></a>
</div>

## PRIVACY
> MÃ NGUỒN NÀY ĐƯỢC TẠO RA ĐỂ MANG MỤC ĐÍCH HỌC TẬP, CHÚNG TÔI SẼ KHÔNG THU TẬP THÔNG TIN HAY DDOS SERVER,...

<div align="right">
  <br>
  <a href="#-design-by-t2"><kbd> <br> 🡅 <br> </kbd></a>
</div>

CẢM ƠN VÌ ĐÃ ĐỌC
NIYAKI PHẠM