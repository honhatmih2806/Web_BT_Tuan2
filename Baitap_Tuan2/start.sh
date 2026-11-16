#!/bin/bash
set -e
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOMCAT_DIR="/mnt/D/E/Web/apache-tomcat-11.0.27"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"

echo "=== [1/3] Building Baitap_Tuan2 Maven WAR package ==="
cd "$PROJECT_DIR"
mvn clean package -DskipTests

echo "=== [2/3] Deploying Baitap_Tuan2.war to Tomcat ==="
cp "$PROJECT_DIR/target/Baitap_Tuan2.war" "$TOMCAT_DIR/webapps/"

echo "=== [3/3] Starting Tomcat 11 ==="
"$TOMCAT_DIR/bin/startup.sh"

echo "✅ Tomcat started! Access URL:"
echo "   http://localhost:8080/Baitap_Tuan2/admin/categories"
