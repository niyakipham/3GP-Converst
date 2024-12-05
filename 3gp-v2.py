import os
import ffmpeg

# Đảm bảo rằng thư mục đầu ra cho các tệp 3gp tồn tại
output_dir = "3gp"
os.makedirs(output_dir, exist_ok=True)

# Biến đếm để đánh số tệp 3gp
counter = 1

# Lặp qua tất cả các tệp mp4 trong thư mục hiện tại
for file in os.listdir('.'):
    if file.endswith('.mp4') and os.path.isfile(file):
        # Tạo tên tệp đầu ra
        output_file = os.path.join(output_dir, f"{counter}.3gp")

        # Chuyển đổi và nén tệp mp4 sang 3gp bằng ffmpeg-python
        ffmpeg.input(file) \
            .output(output_file, r=15, s='176x144', vb='50k',
                    acodec='aac', ac=1, ar=8000, ab='24k', crf=51, preset='slow') \
            .run()

        # Tăng biến đếm
        counter += 1

print(f"Chuyển đổi hoàn tất. Các tệp 3gp đã được lưu trong thư mục '{output_dir}'.")
