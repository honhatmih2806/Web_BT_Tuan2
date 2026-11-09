#!/bin/bash
# Script biên dịch và deploy vào Tomcat 11
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR"

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk

echo "=== 1. Biên dịch và đóng gói WAR với Maven ==="
mvn clean package

echo "=== 2. Deploy vào Tomcat 11 webapps/ROOT.war ==="
rm -rf "$DIR/apache-tomcat-11.0.27/webapps/ROOT"*
cp "$DIR/target/demo-3tier.war" "$DIR/apache-tomcat-11.0.27/webapps/ROOT.war"

echo "=== Build và Deploy thành công! ==="
