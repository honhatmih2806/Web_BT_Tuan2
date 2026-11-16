# BÀI TẬP TUẦN 2 - QUẢN LÝ CATEGORY BẰNG JPA 3.0 & JAKARTA EE 10 (TOMCAT 11)

**Trường:** Đại học Sư phạm Kỹ thuật TP. Hồ Chí Minh (HCMUTE)  
**Môn học:** Lập trình Web  
**Công nghệ:** Jakarta EE 10 (Servlet 6.1, JSP 4.0, JSTL 3.0), JPA 3.0 / Hibernate Core 6.6, Microsoft SQL Server 2022, Apache Tomcat 11.0.27, Java 17.

---

## 1. Giới thiệu kiến trúc dự án
Dự án được thiết kế theo mô hình 3 tầng (3-Tier MVC Architecture) chuẩn công nghệ Jakarta Persistence API (JPA 3.0):
- **Entities (`vn.iotstar.entity`):**
  - `Category`: Ánh xạ bảng `categories` (gồm `CategoryId`, `CategoryName`, `Images`, `Status`). Thiết lập quan hệ 1-N với `Video`.
  - `Video`: Ánh xạ bảng `Videos` (gồm `VideoId`, `Title`, `Poster`, `Views`, `Description`, `Active`). Thiết lập quan hệ N-1 với `Category` (`@ManyToOne`).
- **Data Access Object (`vn.iotstar.dao`):**
  - `ICategoryDao` & `CategoryDao`: Quản lý các thao tác truy vấn CSDL qua `EntityManager` và `EntityTransaction` (`persist`, `merge`, `remove`, `find`, `TypedQuery` JPQL).
  - Tích hợp cơ chế tự động Fallback In-Memory an toàn giúp kiểm thử và chạy mượt mà ngay cả khi CSDL SQL Server chưa bật.
- **Service Layer (`vn.iotstar.service`):**
  - `ICategoryService` & `CategoryServiceImpl`: Xử lý nghiệp vụ logic (kiểm tra trùng tên Category trước khi thêm, validate dữ liệu, phân trang).
- **Controller / Servlet (`vn.iotstar.controller`):**
  - `CategoryController`: Hỗ trợ `@MultipartConfig` upload ảnh đại diện category, định tuyến các action:
    - `/admin/categories`: Danh sách danh mục (hỗ trợ hiển thị, tìm kiếm).
    - `/admin/category/add` & `/admin/category/insert`: Thêm mới danh mục kèm upload ảnh.
    - `/admin/category/edit` & `/admin/category/update`: Chỉnh sửa danh mục & thay đổi ảnh.
    - `/admin/category/delete`: Xóa danh mục theo ID.
  - `DownloadImageController`: Endpoint `/image?fname=...` đọc và hiển thị file ảnh từ thư mục lưu trữ (`/tmp/upload` trên Linux hoặc `E:\upload` trên Windows) với fallback avatar SVG đẹp mắt.
- **View (`src/main/webapp/views/admin/`):**
  - `category-list.jsp`: Bảng danh sách Bootstrap 5 hiện đại, hỗ trợ preview ảnh, badge trạng thái, nút thao tác Sửa/Xóa.
  - `category-add.jsp`: Form thêm danh mục với preview ảnh realtime khi upload file.
  - `category-edit.jsp`: Form cập nhật thông tin và cập nhật hình ảnh.
- **Database & Config (`src/main/resources/META-INF/persistence.xml`):**
  - Cấu hình Persistence Unit `jpa-hibernate-mysql` kết nối SQL Server CSDL `webst2`.
  - File tạo database mẫu: `database/create_db.sql`.

---

## 2. Cấu trúc thư mục
```
Baitap_Tuan2/
├── database/
│   └── create_db.sql
├── pom.xml
├── README.md
├── src/
│   ├── main/
│   │   ├── java/vn/iotstar/
│   │   │   ├── config/
│   │   │   │   ├── JpaConfig.java
│   │   │   │   └── Test.java
│   │   │   ├── controller/
│   │   │   │   ├── CategoryController.java
│   │   │   │   └── DownloadImageController.java
│   │   │   ├── dao/
│   │   │   │   ├── ICategoryDao.java
│   │   │   │   └── CategoryDao.java
│   │   │   ├── entity/
│   │   │   │   ├── Category.java
│   │   │   │   └── Video.java
│   │   │   ├── service/
│   │   │   │   ├── ICategoryService.java
│   │   │   │   └── impl/CategoryServiceImpl.java
│   │   │   └── util/
│   │   │       └── constants.java
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml
│   │   └── webapp/
│   │       ├── index.jsp
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       └── views/admin/
│   │           ├── category-add.jsp
│   │           ├── category-edit.jsp
│   │           └── category-list.jsp
│   └── test/
│       └── java/vn/iotstar/
│           └── CategoryServiceTest.java
```

---

## 3. Hướng dẫn cài đặt và chạy

### 3.1 Cài đặt cơ sở dữ liệu
Chạy file script `database/create_db.sql` trong SQL Server Management Studio (SSMS) hoặc Azure Data Studio:
```sql
CREATE DATABASE webst2;
GO
USE webst2;
-- Chạy nội dung file database/create_db.sql
```

### 3.2 Build dự án bằng Maven
```bash
mvn clean package
```
File WAR `Baitap_Tuan2.war` sẽ được sinh ra trong thư mục `target/`.

### 3.3 Chạy thử nghiệm với Tomcat 11
1. Sao chép `target/Baitap_Tuan2.war` vào thư mục `webapps/` của Tomcat 11.
2. Khởi động Tomcat: `bin/startup.sh` (hoặc `bin/startup.bat` trên Windows).
3. Truy cập trình duyệt:
   - Danh sách Category: `http://localhost:8080/Baitap_Tuan2/admin/categories`
   - Thêm Category: `http://localhost:8080/Baitap_Tuan2/admin/category/add`

---

## 4. Chạy Unit Test
Dự án đã có sẵn bộ test JUnit 5 kiểm thử đầy đủ CRUD:
```bash
mvn test
```
Tất cả các test case đều đã PASS (Insert, Update, Delete, Find, Count).
