#!/bin/bash
# Script hỗ trợ đẩy source code lên GitHub cho sinh viên
set -e

REPO_URL="$1"

if [ -z "$REPO_URL" ]; then
    echo "================================================================"
    echo " HƯỚNG DẪN ĐẨY SOURCE CODE LÊN GITHUB"
    echo "================================================================"
    echo "1. Tạo một repository mới trên GitHub (ví dụ: 'Web-HCMUTE' hoặc 'Baitap_Tuan2'):"
    echo "   Truy cập: https://github.com/new"
    echo "2. Chạy lệnh sau với đường dẫn repo của bạn:"
    echo "   ./push_to_github.sh https://github.com/honhatmih2806/<ten-repo>.git"
    echo "================================================================"
    exit 1
fi

echo "=== Đang thêm remote origin: $REPO_URL ==="
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

echo "=== Đang push nhánh main lên GitHub ==="
git push -u origin main

echo "✅ Đẩy code lên GitHub thành công!"
echo "👉 Link nộp utexlms của bạn: $REPO_URL"
