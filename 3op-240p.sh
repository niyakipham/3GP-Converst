#!/bin/bash
#===================================================================#
# 🚀 FFMPEG ULTIMATE CONVERTER v4.0 (Kaguya DIRECTORY MODE)        #
# ▸ GUI Directory Selection | Real-time Logging | Multi-Platform   #
#===================================================================#

#------------- 1. CẤU HÌNH GIAO DIỆN ----------------------------#
THEME="cyberpunk"                  # ▸ [cyberpunk/matrix/retro/monokai]
LOG_MODE="realtime"                # ▸ [realtime/minimal/debug]
SHOW_PROGRESS_BAR=true             # ▸ Hiển thị thanh tiến trình 

#------------- 2. LOAD THEME -------------------------------------#
init_theme() {
  case $THEME in
    "cyberpunk")
      COLOR_HEADER="\033[38;5;201m"  # Màu tím neon
      COLOR_FILE="\033[38;5;81m"     # Màu xanh ngọc
      COLOR_TIME="\033[38;5;227m"    # Màu vàng
      COLOR_LOG="\033[38;5;255m"     # Màu trắng
      COLOR_SUCCESS="\033[38;5;48m"  # Màu xanh lá sáng
      COLOR_ERROR="\033[38;5;196m"   # Màu đỏ cảnh báo
      PROGRESS_CHAR="▓"              # Ký tự progress bar
      ;;
    # ... (Các theme khác)
  esac
}

#------------- 3. CHỌN THƯ MỤC NGUỒN ---------------------------#
select_input_directory() {
  if [ "$(uname)" == "Darwin" ]; then
    # macOS - Sử dụng AppleScript để mở Finder
    input_dir=$(osascript -e 'tell app "Finder" to return POSIX path of (choose folder with prompt "Chọn thư mục chứa video MP4")')
  elif [ "$(uname)" == "Linux" ]; then
    # Linux - Sử dụng zenity
    input_dir=$(zenity --file-selection --directory --title="Chọn thư mục chứa video MP4")
  else
    # Windows (WSL) - Sử dụng explorer.exe
    input_dir=$(wslpath -u "$(explorer.exe /e,selectfolder | sed 's/\r//g')")
  fi

  [ -z "$input_dir" ] && echo -e "${COLOR_ERROR}❌ Không chọn thư mục - Thoát script${reset}" && exit 1
  echo -e "${COLOR_HEADER}📂 Thư mục nguồn: ${COLOR_FILE}$input_dir${reset}"
}

#------------- 4. TẠO THƯ MỤC ĐÍCH -----------------------------#
create_output_dir() {
  output_dir="${input_dir}/converted_3gp_$(date +%Y%m%d_%H%M%S)"
  mkdir -p "$output_dir"
  echo -e "${COLOR_HEADER}📂 Thư mục đích: ${COLOR_FILE}$output_dir${reset}"
  LOG_FILE="${output_dir}/conversion_$(date +%s).log"
}

#------------- 5. HIỂN THỊ LOG THEO THỜI GIAN THỰC --------------#
log() {
  local message_type=$1
  local message=$2
  local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
  
  case $message_type in
    "INFO")
      echo -e "${COLOR_TIME}[${timestamp}] ${COLOR_LOG}ℹ ${message}${reset}"
      ;;
    "SUCCESS")
      echo -e "${COLOR_TIME}[${timestamp}] ${COLOR_SUCCESS}✓ ${message}${reset}"
      ;;
    "ERROR")
      echo -e "${COLOR_TIME}[${timestamp}] ${COLOR_ERROR}✗ ${message}${reset}" >&2
      ;;
  esac

  # Ghi vào file log
  echo "[${timestamp}] [${message_type}] ${message}" >> "$LOG_FILE"
}

#------------- 6. PROGRESS BAR ĐỘNG -----------------------------#
show_progress() {
  local current=$1
  local total=$2
  local width=50
  local percent=$((current * 100 / total))
  local progress=$((current * width / total))
  
  printf "\r${COLOR_HEADER}🔄 Tiến trình: ["
  for ((i=0; i<progress; i++)); do printf "${COLOR_SUCCESS}${PROGRESS_CHAR}"; done
  for ((i=progress; i<width; i++)); do printf " "; done
  printf "] ${percent}%% (${current}/${total})${reset}"
}

#------------- 7. CORE CONVERSION FUNCTION -----------------------#
convert_video() {
  local input_file=$1
  local filename=$(basename -- "$input_file")
  local output_file="${output_dir}/${filename%.*}.3gp"
  
  log "INFO" "Bắt đầu xử lý: ${filename}"
  
  # Hiển thị thông tin file
  if [ "$LOG_MODE" == "debug" ]; then
    log "INFO" "$(ffprobe -v error -show_format -show_streams "$input_file" | grep -E 'codec_name|width|height|duration|bit_rate')"
  fi

  # Lệnh FFmpeg với progress
  ffmpeg -y -i "$input_file" \
    -c:v h263 -s 352x288 -r 15 -b:v 128k \
    -c:a aac -ar 44100 -ac 2 \
    -crf 23 -preset fast \
    "$output_file" 2>&1 | while read -r line; do
      [ "$LOG_MODE" == "realtime" ] && log "INFO" "$line"
    done

  if [ $? -eq 0 ]; then
    log "SUCCESS" "Hoàn thành: ${filename} → ${output_file##*/}"
    return 0
  else
    log "ERROR" "Lỗi khi xử lý ${filename}"
    return 1
  fi
}

#------------- 8. MAIN PROCESS -----------------------------------#
main() {
  init_theme
  select_input_directory
  create_output_dir
  
  # Tìm file MP4
  files=("$input_dir"/*.mp4)
  total_files=${#files[@]}
  completed=0
  
  [ $total_files -eq 0 ] && log "ERROR" "Không tìm thấy file MP4 nào" && exit 1
  
  log "INFO" "Phát hiện ${total_files} file cần chuyển đổi"
  
  # Xử lý song song 4 file
  export -f convert_video log
  export output_dir LOG_MODE COLOR_SUCCESS COLOR_ERROR reset
  
  printf "\n"
  for file in "${files[@]}"; do
    if (( $(jobs -r -p | wc -l) >= 4 )); then wait -n; fi
    
    convert_video "$file" &
    ((completed++))
    $SHOW_PROGRESS_BAR && show_progress $completed $total_files
  done
  wait
  
  printf "\n\n"
  log "SUCCESS" "Hoàn thành tất cả! Đã chuyển đổi ${completed}/${total_files} file"
  log "INFO" "Xem log đầy đủ tại: ${LOG_FILE}"
  echo -e "${COLOR_HEADER}👉 Mở thư mục kết quả: ${COLOR_FILE}open \"$output_dir\"${reset}"
}

#------------- 9. RUN --------------------------------------------#
reset="\033[0m"
main
