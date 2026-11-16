#!/bin/bash
set -e

# Tìm thư mục gốc của Git repository
GIT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || echo "/mnt/D/E/Web")"
cd "$GIT_ROOT"

REPO_URL="$1"

if [ -z "$REPO_URL" ]; then
    echo "================================================================"
    echo "           HƯỚNG DẪN ĐẨY SOURCE CODE LÊN GITHUB"
    echo "================================================================"
    echo "1. Mở trình duyệt vào link: https://github.com/new"
    echo "2. Đặt tên Repository, ví dụ: Baitap_Tuan2 (hoặc Web-HCMUTE)"
    echo "3. Chọn 'Public' rồi nhấn nút màu xanh 'Create repository'"
    echo "================================================================"
    echo ""
    read -p "👉 Dán link Repository của bạn vào đây: " REPO_URL
fi

# Loại bỏ dấu < > hoặc khoảng trắng thừa nếu người dùng lỡ copy nhầm
REPO_URL=$(echo "$REPO_URL" | tr -d '<>' | xargs)

if [ -z "$REPO_URL" ]; then
    echo "❌ Bạn chưa nhập link repo. Thoát."
    exit 1
fi

# Tự động thêm .git vào cuối nếu thiếu
if [[ "$REPO_URL" != *.git ]]; then
    REPO_URL="${REPO_URL}.git"
fi

echo ""
echo "=== Đang cấu hình remote origin: $REPO_URL ==="
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

echo "=== Đang push nhánh main lên GitHub ==="
git push -u origin main

echo ""
echo "================================================================"
echo "🎉 ĐẨY CODE LÊN GITHUB THÀNH CÔNG!"
echo "👉 Link để bạn copy nộp trên utexlms:"
echo "   ${REPO_URL%.git}"
echo "================================================================"
