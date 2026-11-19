# BÀI TẬP TUẦN 4 - SITEMESH DECORATOR 3, FORM VALIDATION, USER PROFILE & CLOUDINARY MULTIPART

**Trường:** Đại học Sư phạm Kỹ thuật TP. Hồ Chí Minh (HCMUTE)  
**Môn học:** Lập trình Web (WEBPR330479)  
**Giảng viên:** ThS. Nguyễn Hữu Trung  
**Sinh viên:** Hồ Nhật Minh (honhatmih2806)  
**Công nghệ:** Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0), SiteMesh 3, Cloudinary SDK, JPA 3.0 / Hibernate Core 6.6, Microsoft SQL Server 2022, Apache Tomcat 11.0.27, jBCrypt, Jakarta Mail, Java 17.

---

## 1. Các Yêu Cầu Đã Hoàn Thành Chi Tiết

### 1.1 Cấu hình SiteMesh Decorator 3 với Template Bootstrap 5
- Tệp cấu hình SiteMesh: `src/main/webapp/WEB-INF/sitemesh3.xml`.
- Bộ lọc `SiteMeshFilter` (`vn.iotstar.filter.SiteMeshFilter`): Tự động trích xuất `<title>`, `<head>`, `<body>` của trang con và trang trí vào Layout Template.
- **Decorator Template Người Dùng (`/decorators/web.jsp`):**
  - Thanh điều hướng Navbar Bootstrap 5 responsive, Brand logo, menu Trang Chủ, Videos, Profile, Login/Logout.
  - Vùng nội dung `<sitemesh:write property="body"/>`.
  - Chân trang Footer chuẩn giao diện HCMUTE.
- **Decorator Template Quản Trị (`/decorators/admin.jsp`):**
  - Giao diện Admin chuyên nghiệp cho các URL bắt đầu bằng `/admin/*`.

### 1.2 Thực hiện Validation cho tất cả các chức năng có FORM
Bộ kiểm tra dữ liệu tập trung [FormValidator.java](file:///mnt/D/E/Web/Btap_Tuan4/src/main/java/vn/iotstar/util/FormValidator.java):
- **Form Đăng Nhập (`/login`):** Bắt buộc nhập username/email (tối thiểu 3 ký tự), mật khẩu (tối thiểu 6 ký tự).
- **Form Đăng Ký (`/register`):** Kiểm tra username không chứa ký tự đặc biệt (3-30 ký tự), email đúng định dạng regex chuẩn, mật khẩu tối thiểu 6 ký tự, số điện thoại đúng chuẩn 10-11 số của Việt Nam.
- **Form Quên Mật Khẩu (`/forgot-password`):** Kiểm tra email hợp lệ và tồn tại trong hệ thống.
- **Form Thêm/Sửa Video (`/admin/video/add`, `/admin/video/edit`):** Kiểm tra tiêu đề video không được để trống (3-300 ký tự).
- **Form Thêm/Sửa Category (`/admin/category/add`, `/admin/category/edit`):** Kiểm tra tên danh mục không được để trống.
- **Hiển thị lỗi:** Kết hợp validation phía client (Bootstrap `is-invalid`) và validation chặt chẽ phía server trả về thông báo lỗi chi tiết.

### 1.3 Chức năng Profile Người Dùng (Đổi Email qua OTP & Upload Cloudinary)
- **URL**: `/profile`, `/profile/update`, `/profile/verify-email-otp`.
- **Cập nhật Fullname, Phone, Avatar:**
  - Hỗ trợ upload ảnh đại diện thông qua [CloudinaryService.java](file:///mnt/D/E/Web/Btap_Tuan4/src/main/java/vn/iotstar/util/CloudinaryService.java) bằng Multipart.
  - Tự động đẩy ảnh lên dịch vụ đám mây **Cloudinary** và lưu URL an toàn (kèm fallback lưu local khi chạy offline).
- **Quy trình Đổi Email An Toàn với OTP:**
  - Khi người dùng nhập Email mới khác với email hiện tại:
  - Hệ thống **chưa** đổi email ngay mà sinh mã OTP 6 chữ số và gửi đến **Email mới** đó thông qua Jakarta Mail SMTP.
  - Chuyển hướng người dùng sang trang `/profile/verify-email-otp`.
  - Người dùng nhập đúng mã OTP gửi về email mới thì hệ thống mới chính thức cập nhật email trong CSDL và cập nhật session.

---

## 2. Cấu Trúc Thư Mục Dự Án

```
Btap_Tuan4/
├── database/
│   └── create_db.sql               # Script SQL Server
├── pom.xml                         # Cấu hình SiteMesh 3 & Cloudinary SDK
├── README.md                       # Hướng dẫn chi tiết
├── package_submission.sh           # Đóng gói zip nộp bài
├── push_to_github.sh               # Đẩy code lên GitHub
├── start.sh                        # Build WAR và deploy lên Tomcat 11
├── stop.sh                         # Dừng Tomcat 11
├── test_endpoints.sh               # Kiểm thử tự động toàn bộ endpoints
├── src/
│   ├── main/
│   │   ├── java/vn/iotstar/
│   │   │   ├── config/             # JpaConfig
│   │   │   ├── controller/         # ProfileController, AuthController, HomeController, VideoAdminController...
│   │   │   ├── dao/                # UserDao, VideoDao, CategoryDao
│   │   │   ├── entity/             # User, Video, Category
│   │   │   ├── filter/             # SiteMeshFilter (Jakarta Servlet 6.1)
│   │   │   ├── service/            # UserService, VideoService, CategoryService
│   │   │   └── util/               # CloudinaryService, FormValidator, PasswordUtils, EmailService
│   │   ├── resources/
│   │   │   └── META-INF/persistence.xml
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── web.xml
│   │       │   └── sitemesh3.xml   # Cấu hình SiteMesh 3 Decorator
│   │       ├── decorators/
│   │       │   ├── web.jsp         # Template Bootstrap cho người dùng
│   │       │   └── admin.jsp       # Template Bootstrap cho quản trị
│   │       └── views/
│   │           ├── profile.jsp     # Giao diện Profile cá nhân & Upload Cloudinary
│   │           ├── profile-verify-otp.jsp # Giao diện xác thực OTP khi đổi Email
│   │           ├── home.jsp
│   │           ├── login.jsp
│   │           ├── register.jsp
│   │           └── admin/
│   └── test/
│       └── java/vn/iotstar/        # JUnit 5 tests (14/14 passed)
```

---

## 3. Hướng Dẫn Chạy & Kiểm Thử

### 3.1 Khởi động Tomcat 11
```bash
cd /mnt/D/E/Web/Btap_Tuan4
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
Tất cả **14/14 test cases** đều PASS (`BUILD SUCCESS`).
