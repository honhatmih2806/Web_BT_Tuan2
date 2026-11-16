#!/bin/bash
# Script khởi chạy Tomcat 11 và deploy ứng dụng Baitap_tuan1
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
TOMCAT_DIR="/mnt/D/E/Web/apache-tomcat-11.0.27"
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

echo "=== 1. Deploy ứng dụng vào Tomcat 11 ==="
cp "$DIR/target/Baitap_tuan1.war" "$TOMCAT_DIR/webapps/Baitap_tuan1.war"
rm -rf "$TOMCAT_DIR/webapps/Baitap_tuan1"

echo "=== 2. Khởi động Tomcat 11 ==="
"$TOMCAT_DIR/bin/catalina.sh" stop 5 -force 2>/dev/null || true
"$TOMCAT_DIR/bin/startup.sh"

echo "Đang chờ server khởi động (3s)..."
sleep 3

echo ""
echo "=== SERVER ĐÃ SẴN SÀNG! ==="
echo "Địa chỉ truy cập các chức năng:"
echo " 1. Trang chủ:        http://localhost:8080/Baitap_tuan1/home"
echo " 2. Đăng nhập:        http://localhost:8080/Baitap_tuan1/login"
echo " 3. Đăng ký:          http://localhost:8080/Baitap_tuan1/register"
echo " 4. Admin Dashboard:  http://localhost:8080/Baitap_tuan1/admin/home"
echo " 5. CRUD Category:    http://localhost:8080/Baitap_tuan1/admin/category/list"
echo "==========================="
