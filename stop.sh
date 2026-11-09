#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export CATALINA_PID="$DIR/apache-tomcat-11.0.27/temp/tomcat.pid"

echo "=== Dừng Apache Tomcat 11.0 ==="
"$DIR/apache-tomcat-11.0.27/bin/catalina.sh" stop 10 -force || true
rm -f "$CATALINA_PID"
echo "Tomcat đã dừng."
