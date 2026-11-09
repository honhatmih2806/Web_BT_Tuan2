#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export CATALINA_PID="$DIR/apache-tomcat-11.0.27/temp/tomcat.pid"

# Kiểm tra nếu đang chạy thì báo
if [ -f "$CATALINA_PID" ] && kill -0 $(cat "$CATALINA_PID") 2>/dev/null; then
    echo "Tomcat đang chạy với PID $(cat "$CATALINA_PID")."
    exit 0
fi

echo "=== Khởi động Apache Tomcat 11.0 ==="
nohup "$DIR/apache-tomcat-11.0.27/bin/catalina.sh" run > "$DIR/apache-tomcat-11.0.27/logs/catalina.out" 2>&1 &
echo $! > "$CATALINA_PID"

echo "Đang chờ server khởi động (2s)..."
sleep 2

echo "Kiểm tra kết nối:"
curl -sI http://localhost:8080/ || true

echo ""
echo "=== Tomcat 11 đã sẵn sàng! ==="
echo "Địa chỉ truy cập ứng dụng:"
echo " - Trang chủ:   http://localhost:8080/"
echo " - Hoặc:        http://localhost:8080/home"
echo " - Đăng nhập:   http://localhost:8080/login"
echo " - Trang lỗi:   http://localhost:8080/error"
echo "=============================="
