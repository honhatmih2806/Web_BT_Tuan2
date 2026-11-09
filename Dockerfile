# ========================================================
# DOCKERFILE CHO ỨNG DỤNG JAKARTA EE 11 / TOMCAT 11
# Sử dụng Multi-stage build để tối ưu dung lượng ảnh (Image)
# ========================================================

# STAGE 1: Biên dịch mã nguồn và đóng gói WAR với Maven
FROM maven:3.9.6-eclipse-temurin-17 AS builder
WORKDIR /app

# Tận dụng cache của Docker cho dependencies
COPY pom.xml .
RUN mvn dependency:go-offline -B || true

# Sao chép mã nguồn và đóng gói WAR
COPY src ./src
RUN mvn clean package -DskipTests

# STAGE 2: Khởi chạy trên nền Apache Tomcat 11.0
FROM tomcat:11.0-jdk17-temurin
WORKDIR /usr/local/tomcat

# Dọn dẹp thư mục webapps mặc định
RUN rm -rf webapps/ROOT webapps/ROOT.war

# Sao chép file WAR từ stage builder vào làm ứng dụng mặc định (ROOT)
COPY --from=builder /app/target/demo-3tier.war webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
