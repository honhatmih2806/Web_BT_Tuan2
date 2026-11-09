-- ========================================================
-- KỊCH BẢN KHỞI TẠO CƠ SỞ DỮ LIỆU MICROSOFT SQL SERVER 14.x (2017+)
-- Trường Đại học Công nghệ Kỹ thuật TP. Hồ Chí Minh (HCM-UTE)
-- Dự án: Web Demo 3 Tầng (Jakarta EE 11 & Tomcat 11)
-- ========================================================

-- 1. Tạo Database nếu chưa tồn tại
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'HCMUTE_WebDemo')
BEGIN
    CREATE DATABASE HCMUTE_WebDemo;
    PRINT N'Đã tạo thành công cơ sở dữ liệu HCMUTE_WebDemo!';
END
GO

USE HCMUTE_WebDemo;
GO

-- 2. Tạo Bảng Users
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Users')
BEGIN
    CREATE TABLE Users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        fullName NVARCHAR(100) NOT NULL,
        email VARCHAR(100) NULL,
        role VARCHAR(20) NOT NULL DEFAULT 'USER',
        createdAt DATETIME DEFAULT GETDATE()
    );
    PRINT N'Đã tạo bảng Users!';
END
GO

-- 3. Chèn dữ liệu mẫu (Mock Data)
IF NOT EXISTS (SELECT * FROM Users WHERE username = 'admin')
BEGIN
    INSERT INTO Users (username, password, fullName, email, role)
    VALUES 
    ('admin', '123456', N'ThS. Nguyễn Hữu Trung', 'trungnh@hcmute.edu.vn', 'ADMIN'),
    ('user', '123', N'Nguyễn Văn A', 'vana@student.hcmute.edu.vn', 'USER'),
    ('sinhvien', '123', N'Lê Thị B', 'thib@student.hcmute.edu.vn', 'USER');
    PRINT N'Đã chèn dữ liệu mẫu thành công!';
END
GO

-- Kiểm tra dữ liệu vừa tạo
SELECT * FROM Users;
GO
