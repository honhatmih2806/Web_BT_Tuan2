#!/bin/bash
# Đóng gói mã nguồn nộp bài Tuần 1 (loại trừ target/ và file tạm)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

ZIP_NAME="Baitap_tuan1_HCMUTE.zip"
echo "=== Đóng gói mã nguồn: $ZIP_NAME ==="
rm -f "$ZIP_NAME"

zip -r "$ZIP_NAME" \
    pom.xml \
    database/ \
    start.sh \
    stop.sh \
    test_endpoints.sh \
    HUONG_DAN_CHUP_MAN_HINH.md \
    src/

echo "=== Đóng gói thành công: $DIR/$ZIP_NAME ==="
ls -lh "$ZIP_NAME"
