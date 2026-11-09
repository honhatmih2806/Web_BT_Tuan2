# 🌸 HCMUTE 3-Tier Web Application (Jakarta EE 11 & Tomcat 11) 🌸

[![Java CI/CD](https://github.com/actions/workflows/ci.yml/badge.svg)](https://github.com)
![Java](https://img.shields.io/badge/Java-17%20LTS-orange.svg)
![Jakarta EE](https://img.shields.io/badge/Jakarta%20EE-11-blue.svg)
![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-11.0.27-yellow.svg)
![SQL Server](https://img.shields.io/badge/Microsoft%20SQL%20Server-14.x%20(2017+)-red.svg)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

> Dự án bài tập Lập Trình Web theo mô hình kiến trúc 3 tầng (Presentation - Business Logic - Data Access) với giao diện phong cách Anime (Sakura Theme), hỗ trợ kết nối Cơ sở dữ liệu **Microsoft SQL Server 14.x (2017+)**, đóng gói chuẩn Docker và tích hợp sẵn CI/CD GitHub Actions.

---

## 🏛️ Kiến Trúc 3 Tầng (3-Tier Architecture)

```
                            [ Trình duyệt Web (Client) ]
                                         │
                   HTTP Request          │          HTTP Response
                                         ▼
┌───────────────────────────────────────────────────────────────────────────────────┐
│ 1. PRESENTATION LAYER (Tầng Giao Diện & Điều Khiển)                               │
│  - Controllers: HomeController (/ và /home), LoginController (/login),            │
│                 ErrorController (/error), LogoutController (/logout)              │
│  - Views:       views/index.jsp, views/login.jsp, views/error.jsp                 │
│                 (Hiệu ứng Sakura cánh hoa rơi + Glassmorphism Kawaii)             │
└────────────────────────────────────────┬──────────────────────────────────────────┘
                                         │ Gọi Service
                                         ▼
┌───────────────────────────────────────────────────────────────────────────────────┐
│ 2. BUSINESS LOGIC LAYER (Tầng Nghiệp Vụ)                                          │
│  - UserService & UserServiceImpl (Xác thực dữ liệu, điều phối đăng nhập)          │
└────────────────────────────────────────┬──────────────────────────────────────────┘
                                         │ Gọi DAO
                                         ▼
┌───────────────────────────────────────────────────────────────────────────────────┐
│ 3. DATA ACCESS LAYER (Tầng Dữ Liệu)                                               │
│  - UserDao & UserDaoImpl: Truy vấn Microsoft SQL Server 14.x qua DBContext        │
│    (Tự động fallback mock data dự phòng nếu chưa bật Database)                    │
│  - Entity: UserModel                                                              │
└───────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🗄️ Cấu Hình Cơ Sở Dữ Liệu SQL Server 14.1.0 (2017+)

### 1. Kịch bản SQL tạo Database & Bảng:
File script khởi tạo nằm tại: [`database/init.sql`](database/init.sql).

### 2. Thông số kết nối mặc định ([`DBContext.java`](src/main/java/vn/edu/hcmute/dao/DBContext.java)):
- **Host**: `localhost` (hoặc `sqlserver` khi chạy trong Docker)
- **Port**: `1433`
- **Database Name**: `HCMUTE_WebDemo`
- **User**: `sa`
- **Password**: `YourStrong@Passw0rd`
- *Lưu ý: Có thể tùy chỉnh linh hoạt thông qua biến môi trường (`DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`).*

### 3. Tài khoản mẫu có sẵn:
| Username | Password | Họ và tên | Chức danh / Vai trò |
|---|---|---|---|
| `admin` | `123456` | ThS. Nguyễn Hữu Trung | Grand Sensei (ADMIN) |
| `user` | `123` | Nguyễn Văn A | Otaku Coder (USER) |
| `sinhvien` | `123` | Lê Thị B | Magical Kouhai (USER) |

---

## 🚀 Hướng Dẫn Chạy Cục Bộ (Local)

### Cách 1: Sử dụng Tomcat 11 có sẵn (Nhanh nhất)
```bash
# 1. Khởi chạy server:
./start.sh

# 2. Mở trình duyệt truy cập:
# http://localhost:8080/

# 3. Dừng server:
./stop.sh
```

### Cách 2: Sử dụng Docker & Docker Compose
```bash
# Khởi chạy cả Tomcat 11 và SQL Server 14.x:
docker compose up -d --build
```

---

## 🧪 Kiểm Thử (Testing)

### 1. Kiểm thử tự động (Unit Test):
```bash
mvn test
```
*7/7 bài kiểm thử JUnit 5 ở tầng Service và DAO đều vượt qua 100%.*

### 2. Chạy toàn bộ 10 kịch bản test luồng Servlet:
```bash
./test-scenarios.sh
```

---

## 🌐 Sẵn Sàng Triển Khai (Ready to Deploy)

Dự án đã tích hợp đầy đủ file cấu hình cho các nền tảng đám mây:
- [`Dockerfile`](Dockerfile): Multi-stage build tối ưu kích thước.
- [`docker-compose.yml`](docker-compose.yml): Chạy cùng SQL Server 14.x.
- [`deploy/render.yaml`](deploy/render.yaml): Triển khai miễn phí trên Render.com.
- [`deploy/railway.json`](deploy/railway.json): Triển khai trên Railway.app.
- Chi tiết hướng dẫn xem tại: [`deploy/DEPLOY_GUIDE.md`](deploy/DEPLOY_GUIDE.md).

---

## 🐙 Cách Đưa Dự Án Lên GitHub (Khi bạn muốn)

Dự án đã được cấu hình Git và commit cục bộ sẵn sàng. Khi bạn muốn đưa lên GitHub, chỉ cần thực hiện 2 lệnh:

```bash
# 1. Liên kết với repository GitHub của bạn (thay URL bằng link repo thật của bạn):
git remote add origin https://github.com/<tai-khoan-cua-ban>/<ten-repo>.git

# 2. Đẩy toàn bộ mã nguồn lên nhánh main:
git push -u origin main
```
Ngay sau khi push, GitHub Actions (`.github/workflows/ci.yml`) sẽ tự động kích hoạt để build và kiểm thử mã nguồn.

---

&copy; 2026 HCM-UTE | Giảng viên hướng dẫn: **ThS. Nguyễn Hữu Trung**
