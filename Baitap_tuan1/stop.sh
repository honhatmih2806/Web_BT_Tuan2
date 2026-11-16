#!/bin/bash
TOMCAT_DIR="/mnt/D/E/Web/apache-tomcat-11.0.27"
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
echo "=== Dừng Tomcat 11 ==="
"$TOMCAT_DIR/bin/catalina.sh" stop 5 -force || true
echo "Tomcat 11 đã dừng."
