#!/bin/bash

# Đảm bảo rằng thư mục đầu ra cho các tệp 3gp tồn tại
output_dir="3gp"
mkdir -p "$output_dir"

# Biến đếm để đánh số tệp 3gp
counter=1

# Lặp qua tất cả các tệp mp4 trong thư mục hiện tại
for file in *.mp4; do
    # Kiểm tra nếu tệp là mp4
    if [[ -f "$file" && "$file" == *.mp4 ]]; then
        # Tạo tên tệp đầu ra
        output_file="$output_dir/$counter.3gp"

        # Chuyển đổi và nén tệp mp4 sang 3gp bằng lệnh ffmpeg
        ffmpeg -y -i "$file" \
            -r 15 -s 176x144 -vb 50k \
            -acodec aac -strict experimental -ac 1 -ar 8000 -ab 24k \
            -crf 51 -preset slow \
            "$output_file"

        # Tăng biến đếm
        ((counter++))
    fi
done

echo "Chuyển đổi hoàn tất. Các tệp 3gp đã được lưu trong thư mục '$output_dir'."
