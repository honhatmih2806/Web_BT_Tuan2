#!/bin/bash
set -e
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOMCAT_DIR="/mnt/D/E/Web/apache-tomcat-11.0.27"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"

echo "=== [1/3] Building Btap_Tuan3 Maven WAR package ==="
cd "$PROJECT_DIR"
mvn clean package -DskipTests

echo "=== [2/3] Deploying Btap_Tuan3.war to Tomcat ==="
cp "$PROJECT_DIR/target/Btap_Tuan3.war" "$TOMCAT_DIR/webapps/"

echo "=== [3/3] Starting Tomcat 11 ==="
"$TOMCAT_DIR/bin/startup.sh"

echo "✅ Tomcat started! Access URLs:"
echo "   - Trang chủ (Top 10 video): http://localhost:8080/Btap_Tuan3/home"
echo "   - Phân trang 6sp/trang:     http://localhost:8080/Btap_Tuan3/video"
echo "   - Quản trị Videos (CRUD):   http://localhost:8080/Btap_Tuan3/admin/videos"
echo "   - Đăng nhập:                http://localhost:8080/Btap_Tuan3/login"
echo "   - Đăng ký (OTP Email):      http://localhost:8080/Btap_Tuan3/register"
