# 📸 HƯỚNG DẪN CÁC THAO TÁC CẦN CHỤP MÀN HÌNH NỘP BÀI TUẦN 1
**Học phần:** LẬP TRÌNH WEB (WEBPR330479) - HCM-UTE  
**Giảng viên:** ThS. Nguyễn Hữu Trung  
**Hai tài liệu áp dụng:** `06_MVC_3tier.pdf` & `14_HD_Servlet_JDBC_CRUD.pdf`

---

## 📋 DANH SÁCH 9 ẢNH CHỤP MÀN HÌNH CẦN THỰC HIỆN

### 🔹 ẢNH 1: Cấu trúc Cơ sở dữ liệu trong SQL Server Management Studio (SSMS)
- **Thao tác:**
  1. Mở SSMS hoặc Azure Data Studio, mở tệp kịch bản [`database/create_db.sql`](database/create_db.sql).
  2. Bấm **Execute** (`F5`) để chạy tạo Database `BanHang`, bảng `[User]` và bảng `Category`.
  3. Mở cây thư mục bên trái: `Databases -> BanHang -> Tables` (hiển thị rõ 2 bảng `dbo.Category` và `dbo.User`).
- **Nội dung chụp:** Cửa sổ SSMS hiển thị kết quả truy vấn `SELECT * FROM [User];` và `SELECT * FROM Category;` kèm cây thư mục Tables.

---

### 🔹 ẢNH 2: Cấu trúc Project trong IDE (Eclipse / IntelliJ / VS Code)
- **Thao tác:**
  1. Mở thư mục `/mnt/D/E/Web/Baitap_tuan1` trong Eclipse / IntelliJ / VS Code.
  2. Mở rộng cây thư mục gói `src/main/java`:
     - `vn.iotstar.connection` (`DBConnection.java`)
     - `vn.iotstar.model` (`User.java`, `Category.java`)
     - `vn.iotstar.dao` & `impl` (`UserDao.java`, `CategoryDao.java`)
     - `vn.iotstar.service` & `impl` (`UserService.java`, `CategoryService.java`)
     - `vn.iotstar.controller` (`LoginController`, `RegisterController`, `WaitingController`,...)
     - `vn.iotstar.controller.admin` (`CategoryListController`, `CategoryAddController`, `CategoryEditController`, `CategoryDeleteController`)
     - `src/main/webapp/views` (các tệp `.jsp`)
- **Nội dung chụp:** Cây thư mục Project Explorer thể hiện rõ ràng mô hình kiến trúc 3 tầng chuẩn.

---

### 🔹 ẢNH 3: Giao diện Đăng Ký Tài Khoản (`/register`)
- **Thao tác:**
  1. Truy cập: [http://localhost:8080/Baitap_tuan1/register](http://localhost:8080/Baitap_tuan1/register)
  2. **Thử nghiệm 1 (Báo lỗi trùng):** Nhập username `admin` rồi bấm Đăng ký $\rightarrow$ Chụp lại màn hình hiện thông báo đỏ: *"Tài khoản đã tồn tại!"*.
  3. **Thử nghiệm 2 (Đăng ký thành công):** Nhập username mới (vd: `sinhvien1`, pass: `123456`, email: `sv1@gmail.com`, họ tên: `Lê Văn B`) $\rightarrow$ Bấm Đăng ký $\rightarrow$ Tự động chuyển hướng về trang Login kèm thông báo xanh: *"Đăng ký thành công!"*.
- **Nội dung chụp:** Màn hình form đăng ký và thông báo kết quả.

---

### 🔹 ẢNH 4: Giao diện Đăng Nhập (`/login`) & Báo lỗi khi sai mật khẩu
- **Thao tác:**
  1. Truy cập: [http://localhost:8080/Baitap_tuan1/login](http://localhost:8080/Baitap_tuan1/login)
  2. Nhập `admin` và mật khẩu sai `999999` $\rightarrow$ Bấm nút **Đăng Nhập**.
- **Nội dung chụp:** Trang login hiển thị thông báo lỗi: *"Tài khoản hoặc mật khẩu không đúng!"*.

---

### 🔹 ẢNH 5: Đăng nhập thành công với quyền Admin & Chuyển hướng (`/waiting`)
- **Thao tác:**
  1. Tại trang [http://localhost:8080/Baitap_tuan1/login](http://localhost:8080/Baitap_tuan1/login), nhập `admin` và mật khẩu `123456`, tích chọn checkbox **"Ghi nhớ đăng nhập (Remember Me)"**.
  2. Bấm nút **Đăng Nhập**.
  3. Hệ thống sẽ chuyển qua URL `/waiting` rồi tự động nhận diện `roleid == 1` để đưa vào trang: [http://localhost:8080/Baitap_tuan1/admin/home](http://localhost:8080/Baitap_tuan1/admin/home).
- **Nội dung chụp:** Trang Admin Dashboard hiển thị tên **ThS. Nguyễn Hữu Trung**, badge đỏ `ADMIN (Role ID = 1)` và topbar có nút Đăng xuất.

---

### 🔹 ẢNH 6: Danh sách Danh mục CRUD (`/admin/category/list`)
- **Thao tác:**
  1. Truy cập: [http://localhost:8080/Baitap_tuan1/admin/category/list](http://localhost:8080/Baitap_tuan1/admin/category/list)
  2. Bảng danh sách hiển thị đầy đủ: Cột STT, Cột Hình ảnh (tải từ servlet `/image?fname=...`), Tên danh mục, Nút Sửa, Nút Xóa.
- **Nội dung chụp:** Bảng danh mục sản phẩm (Category List) với các ảnh thumbnail đại diện.

---

### 🔹 ẢNH 7: Thêm mới Danh mục có Upload ảnh (`/admin/category/add`)
- **Thao tác:**
  1. Bấm nút **"Thêm Danh Mục Mới"** hoặc truy cập: [http://localhost:8080/Baitap_tuan1/admin/category/add](http://localhost:8080/Baitap_tuan1/admin/category/add)
  2. Nhập tên danh mục: `Đồng Hồ Thông Minh & Smartwatch`.
  3. Bấm **Chọn tệp (Browse)** để chọn 1 ảnh bất kỳ từ máy tính của bạn làm Icon.
  4. Bấm **Lưu Danh Mục**.
- **Nội dung chụp:** Màn hình form thêm mới có chọn ảnh và màn hình danh sách sau khi đã thêm thành công danh mục mới.

---

### 🔹 ẢNH 8: Chỉnh sửa Danh mục (`/admin/category/edit`)
- **Thao tác:**
  1. Tại danh sách danh mục, bấm nút **Sửa** ở một dòng bất kỳ (vd: dòng Điện thoại).
  2. Màn hình hiển thị: ID danh mục, Tên hiện tại, Ảnh đại diện hiện tại và ô tải ảnh mới.
  3. Thay đổi tên thành: `Điện Thoại Cao Cấp (Flagship)` $\rightarrow$ Bấm **Cập Nhật**.
- **Nội dung chụp:** Form chỉnh sửa danh mục và bảng danh sách sau khi cập nhật.

---

### 🔹 ẢNH 9: Xóa Danh mục (`/admin/category/delete`)
- **Thao tác:**
  1. Bấm nút **Xóa** ở một danh mục bạn vừa thêm.
  2. Hộp thoại xác nhận của trình duyệt hiện lên: *"Bạn có chắc chắn muốn xóa danh mục này?"* $\rightarrow$ Chọn **OK**.
  3. Danh mục được xóa khỏi bảng.
- **Nội dung chụp:** Hộp thoại xác nhận xóa và danh sách sau khi xóa.

---

## ⚡ CÁCH KHỞI ĐỘNG SERVER ĐỂ CHỤP ẢNH
Server hiện đang được khởi chạy sẵn tại cổng `8080`. Nếu bạn cần bật lại, chỉ cần mở terminal tại thư mục `/mnt/D/E/Web/Baitap_tuan1`:
```bash
# Khởi động server:
./start.sh

# Chạy kịch bản kiểm tra tự động 10 kịch bản:
./test_endpoints.sh

# Dừng server:
./stop.sh
```
