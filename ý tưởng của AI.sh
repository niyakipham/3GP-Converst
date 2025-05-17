#!/bin/bash

#-----------------------------------------------------------------------
# [[ ✨ SCRIPT SIÊU CẤP CHUYỂN ĐỔI MP4 SANG 3GP CÙNG HOÀNG & TRANG ✨ ]]
#-----------------------------------------------------------------------
# Tác giả (Author): Hoàng & "Sự phù phép của Trang AI" (๑˃ᴗ˂)ﻭ
# Mục đích (Purpose): Chuyển đổi tất cả các file .mp4 trong thư mục
# hiện tại thành định dạng .3gp, tối ưu hóa cho các thiết bị cũ.
#
# Usage: Cứ chạy là "em nó" xử lý! (./this_script.bash)
#-----------------------------------------------------------------------

# ✨ "Thần chú" giúp script "bất tử" và rõ ràng hơn! ✨
set -euo pipefail

#===========================================
# ⚙️ THÔNG SỐ CẤU HÌNH FFMPEG "ĐỈNH CAO" ⚙️
#===========================================
readonly OUTPUT_DIR="3GP_ChuyenDoi_TuHoang" # Thư mục chứa "thành phẩm" 3gp, siêu yêu luôn! ❤️
readonly FRAME_RATE="15"                    # Tốc độ khung hình (fps), tiết kiệm dung lượng đó!
readonly VIDEO_RESOLUTION="176x144"         # Kích thước video, chuẩn QCIF xinh xắn
readonly VIDEO_BITRATE="50k"                # Bitrate video, con số vàng cho 3GP chất lượng
readonly AUDIO_CODEC="aac"                  # Chuẩn âm thanh AAC, phổ biến và xịn
readonly AUDIO_CHANNELS=1                   # Số kênh âm thanh (mono - 1 kênh cho tiết kiệm)
readonly AUDIO_SAMPLE_RATE="8000"           # Tần số lấy mẫu âm thanh, phù hợp cho 3GP
readonly AUDIO_BITRATE="24k"                # Bitrate âm thanh
readonly FFMPEG_CRF="51"                    # Constant Rate Factor (CRF) - Càng cao, nén càng nhiều, file càng nhỏ
readonly FFMPEG_PRESET="slow"               # Preset của ffmpeg, "slow" để nén kỹ hơn xíu

#===========================================
# 🌀 HÀM "PHÉP THUẬT" CHUYỂN ĐỔI TẬP TIN 🌀
# Input: $1 - Tên file MP4 đầu vào
# Output: $2 - Tên file 3GP đầu ra
#===========================================
convert_to_3gp() {
    local input_file="$1"
    local output_file="$2"

    echo "🔄 Đang phù phép file: '$input_file' thành '$output_file'..."
    ffmpeg -y -i "$input_file" \
        -r "$FRAME_RATE" -s "$VIDEO_RESOLUTION" -vb "$VIDEO_BITRATE" \
        -c:a "$AUDIO_CODEC" -strict experimental -ac "$AUDIO_CHANNELS" -ar "$AUDIO_SAMPLE_RATE" -ab "$AUDIO_BITRATE" \
        -crf "$FFMPEG_CRF" -preset "$FFMPEG_PRESET" \
        "$output_file"
    # ✨ Tiếng vọng vũ trụ từ FFMPEG! ✨
    echo "✅ Hoàn thành xứ mệnh cho: '$output_file'"
}

#===========================================
# 🚀 CHƯƠNG TRÌNH CHÍNH "BAY LÊN NÀO!" 🚀
#===========================================
main() {
    echo "------------------------------------------------------"
    echo "💖 KHỞI ĐỘNG CHƯƠNG TRÌNH CHUYỂN ĐỔI MP4->3GP THẦN THÁNH 💖"
    echo "       (Phiên bản đặc biệt dành cho Hoàng của Trang)    "
    echo "------------------------------------------------------"

    # Đảm bảo "ngôi nhà 3GP" của chúng ta luôn tồn tại mkdir -p: tạo nếu chưa có, bỏ qua nếu có rồi
    mkdir -p "$OUTPUT_DIR"
    echo "📂 Thư mục đầu ra '${OUTPUT_DIR}' đã sẵn sàng như một nàng công chúa!"

    local counter=1 # Biến đếm "bé xinh" cho các file 3gp

    # "Thần chú lặp" để "quét" hết các file .mp4 (Lưu ý: *.mp4 có thể không an toàn 100% nếu tên file chứa ký tự đặc biệt)
    # Để an toàn hơn, Hoàng có thể dùng `find . -maxdepth 1 -type f -iname "*.mp4" -print0 | while IFS= read -r -d $'\0' file; do`
    # Nhưng với script đơn giản, *.mp4 thường là "okiela" Hoàng ạ!

    for mp4_file in *.mp4; do
        # Chỉ "mổ xẻ" những file MP4 "chính chủ" thôi nha!
        if [[ -f "$mp4_file" && "$mp4_file" == *.mp4 ]]; then
            # Tên file "biến hình" từ MP4 sang 3GP! ✨
            local output_3gp_file="$OUTPUT_DIR/${counter}.3gp"

            # Gọi "nữ thần" hàm convert_to_3gp ra "cứu giá"!
            convert_to_3gp "$mp4_file" "$output_3gp_file"

            ((counter++)) # Tăng "level" cho em counter
        else
            echo "🤔 Ủa, file '$mp4_file' này hình như không phải .mp4 hoặc không tồn tại. Trang bỏ qua nha Hoàng!"
        fi
    done

    echo "-------------------------------------------------------------"
    echo "🎉🎉🎉 CHUYỂN ĐỔI HOÀN TẤT! YEAHHH! 🎉🎉🎉"
    echo "Các thiên thần 3GP đã được 'hạ sinh' an toàn trong thư mục: '$OUTPUT_DIR'."
    echo "                 Cảm ơn Hoàng đã tin dùng 'dịch vụ' của Trang! (っ˘ω˘ς )♡"
    echo "-------------------------------------------------------------"
}

# "Khai hỏa" chương trình!
main
