# HƯỚNG DẪN TRIỂN KHAI ỨNG DỤNG (DEPLOYMENT GUIDE)

Tài liệu này chuẩn bị sẵn toàn bộ quy trình để bạn có thể đưa ứng dụng lên môi trường Production bất kỳ lúc nào.

---

## 1. Triển Khai Cục Bộ / Máy Chủ Bằng Docker & Docker Compose (Khuyên dùng)

### Yêu cầu:
- Đã cài đặt Docker và Docker Compose.

### Các bước thực hiện:
```bash
# 1. Khởi chạy toàn bộ hệ thống (Web Tomcat 11 + SQL Server 14.x)
docker compose up -d --build

# 2. Khởi tạo dữ liệu vào SQL Server (chỉ cần chạy lần đầu):
docker exec -i hcmute_sqlserver_14 /opt/mssql-tools/bin/sqlcmd \
   -S localhost -U sa -P 'YourStrong@Passw0rd' \
   -i /docker-entrypoint-initdb.d/init.sql

# 3. Truy cập ứng dụng:
# http://localhost:8080/

# 4. Xem nhật ký hoạt động (logs):
docker compose logs -f

# 5. Dừng hệ thống:
docker compose down
```

---

## 2. Triển Khai Miễn Phí Lên Render.com (Cloud Hosting)

1. Đăng ký tài khoản tại [render.com](https://render.com/).
2. Chọn **New +** $\rightarrow$ **Web Service**.
3. Kết nối với kho lưu trữ GitHub của bạn.
4. Render sẽ tự động nhận diện file `Dockerfile` và tệp cấu hình `deploy/render.yaml`.
5. Bấm **Deploy Web Service**. Sau 2-3 phút, bạn sẽ nhận được một địa chỉ web HTTPS công khai miễn phí dạng: `https://ten-du-an.onrender.com`.

---

## 3. Triển Khai Lên Railway.app

1. Đăng nhập [railway.app](https://railway.app/) bằng tài khoản GitHub.
2. Chọn **New Project** $\rightarrow$ **Deploy from GitHub repo**.
3. Chọn repo dự án này. Railway sẽ đọc cấu hình `deploy/railway.json` và build Dockerfile tự động.
4. Bấm **Generate Domain** trong phần Settings để có domain công khai.

---

## 4. Triển Khai Lên Máy Chủ Ảo Riêng (VPS Ubuntu / Debian)

```bash
# Trên VPS:
git clone <URL_REPO_GITHUB_CUA_BAN>
cd Web
docker compose up -d --build
```
Cài đặt thêm Nginx làm Reverse Proxy và cấp chứng chỉ SSL Let's Encrypt nếu gắn tên miền riêng.
