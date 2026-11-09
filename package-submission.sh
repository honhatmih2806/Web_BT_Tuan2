#!/bin/bash
# Script đóng gói mã nguồn để nộp bài (loại trừ Tomcat và target/ để dung lượng nhẹ nhất)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

ZIP_NAME="BaiTap_Servlet_3Tier_HCMUTE.zip"
echo "=== Đóng gói mã nguồn nộp bài: $ZIP_NAME ==="

rm -f "$ZIP_NAME"
zip -r "$ZIP_NAME" \
    pom.xml \
    README.md \
    .gitignore \
    start.sh \
    stop.sh \
    build.sh \
    src \
    -x "*.class"

echo "=== Đóng gói hoàn tất! File kết quả: $DIR/$ZIP_NAME ==="
ls -lh "$ZIP_NAME"
