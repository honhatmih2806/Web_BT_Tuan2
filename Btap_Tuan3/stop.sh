#!/bin/bash
TOMCAT_DIR="/mnt/D/E/Web/apache-tomcat-11.0.27"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk"

echo "=== Stopping Tomcat 11 ==="
"$TOMCAT_DIR/bin/shutdown.sh" || true
pkill -f "catalina" 2>/dev/null || true
echo "✅ Tomcat stopped."
