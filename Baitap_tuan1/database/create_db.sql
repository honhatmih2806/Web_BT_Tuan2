-- ========================================================
-- KỊCH BẢN TẠO CƠ SỞ DỮ LIỆU BÀI TẬP TUẦN 1
-- Học phần: LẬP TRÌNH WEB (WEBPR330479) - HCM-UTE
-- Giảng viên: ThS. Nguyễn Hữu Trung
-- ========================================================

-- 1. Tạo cơ sở dữ liệu BanHang (hoặc ShoppingServiceMVC)
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BanHang')
BEGIN
    CREATE DATABASE BanHang;
    PRINT N'Đã tạo thành công cơ sở dữ liệu BanHang!';
END
GO

USE BanHang;
GO

-- 2. Tạo bảng [User] (Theo bài giảng 06_MVC_3tier.pdf)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'User')
BEGIN
    CREATE TABLE [User] (
        [id] INT IDENTITY(1,1) PRIMARY KEY,
        [email] VARCHAR(100) NOT NULL UNIQUE,
        [username] VARCHAR(50) NOT NULL UNIQUE,
        [fullname] NVARCHAR(100) NOT NULL,
        [password] VARCHAR(255) NOT NULL,
        [avatar] NVARCHAR(255) NULL,
        [roleid] INT NOT NULL DEFAULT 3, -- 1: Admin, 2: Manager, 3: User
        [phone] VARCHAR(20) NULL,
        [createdDate] DATE DEFAULT CAST(GETDATE() AS DATE)
    );
    PRINT N'Đã tạo bảng [User]!';
END
GO

-- 3. Tạo bảng Category (Theo bài giảng 14_HD_Servlet_JDBC_CRUD.pdf)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Category')
BEGIN
    CREATE TABLE Category (
        [cate_id] INT IDENTITY(1,1) PRIMARY KEY,
        [cate_name] NVARCHAR(255) NOT NULL,
        [icons] NVARCHAR(255) NULL
    );
    PRINT N'Đã tạo bảng Category!';
END
GO

-- 4. Chèn dữ liệu mẫu cho bảng [User]
IF NOT EXISTS (SELECT * FROM [User] WHERE username = 'admin')
BEGIN
    INSERT INTO [User] (email, username, fullname, password, avatar, roleid, phone, createdDate)
    VALUES 
    ('trungnh@hcmute.edu.vn', 'admin', N'ThS. Nguyễn Hữu Trung', '123456', 'admin.png', 1, '0908617108', GETDATE()),
    ('manager@hcmute.edu.vn', 'manager', N'Quản Lý Cửa Hàng', '123456', 'manager.png', 2, '0901234567', GETDATE()),
    ('user@hcmute.edu.vn', 'user', N'Nguyễn Văn A', '123456', 'user.png', 3, '0987654321', GETDATE());
    PRINT N'Đã chèn dữ liệu mẫu bảng [User]!';
END
GO

-- 5. Chèn dữ liệu mẫu cho bảng Category
IF NOT EXISTS (SELECT * FROM Category)
BEGIN
    INSERT INTO Category (cate_name, icons)
    VALUES 
    (N'Điện thoại & Phụ kiện', 'phone.png'),
    (N'Laptop & Máy vi tính', 'laptop.png'),
    (N'Thời trang & Mỹ phẩm', 'fashion.png'),
    (N'Sách & Văn phòng phẩm', 'book.png');
    PRINT N'Đã chèn dữ liệu mẫu bảng Category!';
END
GO

-- Kiểm tra dữ liệu
SELECT * FROM [User];
SELECT * FROM Category;
GO
