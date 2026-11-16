# BÀI TẬP TUẦN 3 - VIDEO PORTAL & XÁC THỰC OTP EMAIL, MẬT KHẨU BCRYPT, QUAN HỆ 1-N (JPA 3.0 & JAKARTA EE 10)

**Trường:** Đại học Sư phạm Kỹ thuật TP. Hồ Chí Minh (HCMUTE)  
**Môn học:** Lập trình Web (WEBPR330479)  
**Giảng viên:** ThS. Nguyễn Hữu Trung  
**Sinh viên:** Hồ Nhật Minh (honhatmih2806)  
**Công nghệ:** Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0), JPA 3.0 / Hibernate Core 6.6, Microsoft SQL Server 2022, Apache Tomcat 11.0.27, jBCrypt, Jakarta Mail, Java 17.

---

## 1. Các Yêu Cầu Đã Hoàn Thành Đầy Đủ

1. **Kích hoạt tài khoản bằng mã OTP gửi qua Email:**
   - Đăng ký tài khoản tại `/register`.
   - Hệ thống tự động băm mật khẩu bằng BCrypt, sinh mã OTP ngẫu nhiên 6 chữ số, lưu `status = 0`, `code = otp`.
   - Gửi mã OTP xác nhận tới email của người dùng thông qua Jakarta Mail SMTP (đồng thời có fallback console logger và demo cache).
   - Người dùng nhập mã OTP tại `/verify-otp?email=...`. Khi mã trùng khớp, hệ thống cập nhật `status = 1` để kích hoạt tài khoản.

2. **Đăng nhập mật khẩu băm (Hash Password BCrypt) & Đăng xuất:**
   - Mật khẩu lưu trữ trong bảng `users` được băm bằng thuật toán an toàn `jBCrypt` (cost factor = 12).
   - Đăng nhập tại `/login`: Hệ thống kiểm tra mật khẩu đã hash và kiểm tra trạng thái kích hoạt (`status == 1`). Tài khoản chưa kích hoạt OTP sẽ không được phép đăng nhập.
   - Đăng xuất tại `/logout`: Xóa session, điều hướng về màn hình đăng nhập an toàn.

3. **Quên mật khẩu gửi mã xác nhận OTP qua Mail:**
   - Người dùng yêu cầu quên mật khẩu tại `/forgot-password`.
   - Hệ thống kiểm tra email, sinh mã OTP 6 số mới và gửi email tới người dùng.
   - Chuyển hướng tới `/reset-password?email=...`: Người dùng nhập OTP và mật khẩu mới.
   - Hệ thống xác thực OTP, băm mật khẩu mới bằng BCrypt và cập nhật vào CSDL.

4. **Bảng Videos với quan hệ 1-N với bảng Users:**
   - Thiết lập `@ManyToOne` từ `Video` sang `User` (`@JoinColumn(name = "userId")`) và `@OneToMany` từ `User` sang `Video`.
   - **CRUD Bảng Videos:** Quản trị toàn diện tại `/admin/videos`, `/admin/video/add`, `/admin/video/edit`, `/admin/video/delete`. Hỗ trợ upload ảnh Poster và file Video MP4 bằng `@MultipartConfig` theo slide bài giảng.
   - **Hiển thị 10 Video mới nhất lên trang chủ:** Trang chủ `/home` hiển thị Top 10 video sắp xếp theo thứ tự mới nhất (`v.videoId DESC`).
   - **Hiển thị tất cả video của user phân trang 6sp/trang:** Tại URL `/video`, hệ thống phân trang chính xác **6 video/trang** (`pageSize = 6`).
   - **Xem chi tiết & Play 01 Video:** Khi bấm vào tiêu đề hoặc poster của bất kỳ video nào trên trang chủ `/home` hoặc `/video`, hệ thống chuyển hướng tới `/video/detail?id=...`, tự động tăng số lượt xem (`views + 1`) và phát video trực tiếp bằng trình phát HTML5 Video Player / YouTube Embed.

---

## 2. Cấu Trúc Thư Mục Dự Án

```
Btap_Tuan3/
├── database/
│   └── create_db.sql               # Script SQL Server (users, Videos 1-n, categories)
├── pom.xml                         # Cấu hình Maven dependencies (jBCrypt, Jakarta Mail, Multipart)
├── README.md                       # Hướng dẫn chi tiết
├── package_submission.sh           # Đóng gói zip nộp bài
├── push_to_github.sh               # Đẩy code lên GitHub
├── start.sh                        # Build WAR và deploy lên Tomcat 11
├── stop.sh                         # Dừng Tomcat 11
├── test_endpoints.sh               # Kiểm thử tự động toàn bộ endpoints
├── src/
│   ├── main/
│   │   ├── java/vn/iotstar/
│   │   │   ├── config/             # JpaConfig kết nối EntityManager
│   │   │   ├── controller/         # AuthController, HomeController, VideoUserController, VideoDetailController, VideoAdminController, DownloadImageController
│   │   │   ├── dao/                # UserDao, VideoDao, CategoryDao (JPA + In-Memory Fallback)
│   │   │   ├── entity/             # User, Video, Category (JPA Entity ánh xạ 1-N)
│   │   │   ├── service/            # UserService, VideoService, CategoryService
│   │   │   └── util/               # PasswordUtils (BCrypt), EmailService (OTP), constants
│   │   ├── resources/
│   │   │   └── META-INF/persistence.xml
│   │   └── webapp/
│   │       ├── index.jsp           # Điều hướng về /home
│   │       ├── WEB-INF/web.xml
│   │       └── views/
│   │           ├── home.jsp        # Trang chủ Top 10 video mới nhất
│   │           ├── login.jsp       # Đăng nhập BCrypt
│   │           ├── register.jsp    # Đăng ký tài khoản
│   │           ├── verify-otp.jsp  # Kích hoạt tài khoản OTP Email
│   │           ├── forgot-password.jsp # Quên mật khẩu
│   │           ├── reset-password.jsp  # Đặt lại mật khẩu với OTP
│   │           ├── video/
│   │           │   ├── list.jsp    # URL /video phân trang 6sp/trang
│   │           │   └── detail.jsp  # Chi tiết & Play video HTML5
│   │           └── admin/
│   │               ├── video-list.jsp
│   │               ├── video-add.jsp
│   │               └── video-edit.jsp
│   └── test/
│       └── java/vn/iotstar/        # JUnit 5 tests (9/9 passed)
```

---

## 3. Hướng Dẫn Chạy & Kiểm Thử

### 3.1 Chạy tự động (Tomcat 11)
```bash
cd /mnt/D/E/Web/Btap_Tuan3
./start.sh
```

### 3.2 Kiểm thử Endpoints tự động
```bash
./test_endpoints.sh
```

### 3.3 Chạy Unit Test (JUnit 5)
```bash
mvn test
```
Tất cả 9/9 test case đều vượt qua (`BUILD SUCCESS`).
