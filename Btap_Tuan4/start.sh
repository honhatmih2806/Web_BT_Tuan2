#!/bin/bash
set -e
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOMCAT_DIR="/mnt/D/E/Web/apache-tomcat-11.0.27"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"

echo "=== [1/3] Building Btap_Tuan4 Maven WAR package ==="
cd "$PROJECT_DIR"
mvn clean package -DskipTests

echo "=== [2/3] Deploying Btap_Tuan4.war to Tomcat ==="
cp "$PROJECT_DIR/target/Btap_Tuan4.war" "$TOMCAT_DIR/webapps/"

echo "=== [3/3] Starting Tomcat 11 ==="
"$TOMCAT_DIR/bin/startup.sh"

echo "✅ Tomcat started! Access URLs:"
echo "   - Trang chủ (SiteMesh 3 Decorator): http://localhost:8080/Btap_Tuan4/home"
echo "   - Hồ sơ Profile (Đổi Email & OTP):  http://localhost:8080/Btap_Tuan4/profile"
echo "   - Đăng nhập (Form Validation):      http://localhost:8080/Btap_Tuan4/login"
echo "   - Đăng ký (Form Validation & OTP):  http://localhost:8080/Btap_Tuan4/register"
echo "   - Video phân trang 6sp/trang:       http://localhost:8080/Btap_Tuan4/video"
echo "   - Quản trị Videos (Admin Decorator):http://localhost:8080/Btap_Tuan4/admin/videos"
