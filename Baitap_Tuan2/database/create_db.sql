-- ========================================================
-- KỊCH BẢN TẠO CƠ SỞ DỮ LIỆU BÀI TẬP TUẦN 2 (JPA 3.0 & JAKARTA)
-- Học phần: LẬP TRÌNH WEB (WEBPR330479) - HCM-UTE
-- Giảng viên: ThS. Nguyễn Hữu Trung
-- ========================================================

-- 1. Tạo cơ sở dữ liệu webst2
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'webst2')
BEGIN
    CREATE DATABASE webst2;
    PRINT N'Đã tạo thành công cơ sở dữ liệu webst2!';
END
GO

USE webst2;
GO

-- 2. Tạo bảng categories
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'categories')
BEGIN
    CREATE TABLE categories (
        CategoryId INT IDENTITY(1,1) PRIMARY KEY,
        CategoryName NVARCHAR(255) NOT NULL,
        Images NVARCHAR(500) NULL,
        Status INT NOT NULL DEFAULT 1
    );
    PRINT N'Đã tạo bảng categories!';
END
GO

-- 3. Tạo bảng Videos
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Videos')
BEGIN
    CREATE TABLE Videos (
        VideoId VARCHAR(50) PRIMARY KEY,
        Active INT NOT NULL DEFAULT 1,
        Description NVARCHAR(500) NULL,
        Poster NVARCHAR(500) NULL,
        Title NVARCHAR(500) NULL,
        Views INT NOT NULL DEFAULT 0,
        CategoryId INT NULL FOREIGN KEY REFERENCES categories(CategoryId) ON DELETE SET NULL
    );
    PRINT N'Đã tạo bảng Videos!';
END
GO

-- 4. Chèn dữ liệu mẫu
IF NOT EXISTS (SELECT * FROM categories)
BEGIN
    INSERT INTO categories (CategoryName, Images, Status)
    VALUES 
    (N'Điện thoại & Phụ kiện', 'phone.png', 1),
    (N'Laptop & Thiết bị số', 'laptop.png', 1),
    (N'Thời trang & Mỹ phẩm', 'fashion.png', 1),
    (N'Sách & Văn phòng phẩm', 'book.png', 1);

    INSERT INTO Videos (VideoId, Active, Description, Poster, Title, Views, CategoryId)
    VALUES
    ('v01', 1, N'Video mở hộp điện thoại flagship', 'poster1.png', N'Mở hộp Điện Thoại 2026', 1500, 1),
    ('v02', 1, N'Đánh giá chi tiết laptop văn phòng', 'poster2.png', N'Đánh giá Laptop Siêu Nhẹ', 3200, 2);

    PRINT N'Đã chèn dữ liệu mẫu thành công!';
END
GO

SELECT * FROM categories;
SELECT * FROM Videos;
GO
