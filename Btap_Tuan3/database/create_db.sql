-- ========================================================
-- KỊCH BẢN TẠO CƠ SỞ DỮ LIỆU BÀI TẬP TUẦN 3 (JPA 3.0 & JAKARTA)
-- Học phần: LẬP TRÌNH WEB (WEBPR330479) - HCM-UTE
-- Giảng viên: ThS. Nguyễn Hữu Trung
-- Sinh viên: Hồ Nhật Minh (honhatmih2806)
-- Chức năng: Kích hoạt OTP Email, Mật khẩu BCrypt, Quên mật khẩu OTP,
--            Bảng Videos quan hệ 1-N với Bảng users, Phân trang 6sp/trang
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

-- 2. Tạo bảng users
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'users')
BEGIN
    CREATE TABLE users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        email NVARCHAR(200) NOT NULL UNIQUE,
        username NVARCHAR(100) NOT NULL UNIQUE,
        fullname NVARCHAR(200) NULL,
        password NVARCHAR(255) NOT NULL,
        avatar NVARCHAR(500) NULL,
        roleid INT DEFAULT 3,
        phone NVARCHAR(50) NULL,
        status INT DEFAULT 0,
        code NVARCHAR(50) NULL,
        created_date DATE DEFAULT GETDATE()
    );
    PRINT N'Đã tạo bảng users!';
END
GO

-- 3. Tạo bảng categories
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

-- 4. Tạo bảng Videos (quan hệ 1-n với bảng users)
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Videos')
BEGIN
    CREATE TABLE Videos (
        VideoId VARCHAR(50) PRIMARY KEY,
        Active INT NOT NULL DEFAULT 1,
        Description NVARCHAR(MAX) NULL,
        Poster NVARCHAR(500) NULL,
        Title NVARCHAR(500) NOT NULL,
        VideoUrl NVARCHAR(500) NULL,
        Views INT NOT NULL DEFAULT 0,
        userId INT NULL FOREIGN KEY REFERENCES users(id) ON DELETE SET NULL,
        CategoryId INT NULL FOREIGN KEY REFERENCES categories(CategoryId) ON DELETE SET NULL
    );
    PRINT N'Đã tạo bảng Videos với khoá ngoại userId liên kết users!';
END
GO

-- 5. Chèn dữ liệu mẫu
IF NOT EXISTS (SELECT * FROM users WHERE username = 'admin')
BEGIN
    -- Mật khẩu mẫu: 123456 (băm bằng BCrypt)
    INSERT INTO users (email, username, fullname, password, roleid, status, created_date)
    VALUES 
    (N'admin@hcmute.edu.vn', N'admin', N'Quản Trị Viên', N'$2a$12$e80yqX4g8tX6q01vXJ6fceWcSm8k5WbL/y8L3N8p2c6N4V0z7uE2W', 1, 1, GETDATE()),
    (N'honhatmih2806@gmail.com', N'nhatminh', N'Hồ Nhật Minh', N'$2a$12$e80yqX4g8tX6q01vXJ6fceWcSm8k5WbL/y8L3N8p2c6N4V0z7uE2W', 3, 1, GETDATE());

    PRINT N'Đã tạo tài khoản mẫu (pass: 123456)!';
END
GO

IF NOT EXISTS (SELECT * FROM categories)
BEGIN
    INSERT INTO categories (CategoryName, Images, Status)
    VALUES 
    (N'Lập trình Web Jakarta', 'web.png', 1),
    (N'Công nghệ Phần mềm', 'software.png', 1);
END
GO

IF NOT EXISTS (SELECT * FROM Videos)
BEGIN
    INSERT INTO Videos (VideoId, Active, Description, Poster, Title, VideoUrl, Views, userId, CategoryId)
    VALUES
    ('VID001', 1, N'Video hướng dẫn cài đặt Jakarta EE 10 và Tomcat 11', 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 01', 'https://www.w3schools.com/html/mov_bbb.mp4', 150, 2, 1),
    ('VID002', 1, N'Hướng dẫn cấu hình JPA 3.0 với Hibernate ORM', 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 02', 'https://www.w3schools.com/html/mov_bbb.mp4', 230, 2, 1),
    ('VID003', 1, N'Hướng dẫn xác thực tài khoản qua OTP Email', 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 03', 'https://www.w3schools.com/html/mov_bbb.mp4', 310, 2, 1),
    ('VID004', 1, N'Kỹ thuật mã hóa mật khẩu an toàn bằng BCrypt', 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 04', 'https://www.w3schools.com/html/mov_bbb.mp4', 450, 2, 2),
    ('VID005', 1, N'Xây dựng chức năng Quên mật khẩu qua mã OTP', 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 05', 'https://www.w3schools.com/html/mov_bbb.mp4', 520, 2, 2),
    ('VID006', 1, N'Thiết kế quan hệ 1-N giữa Users và Videos trong JPA', 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 06', 'https://www.w3schools.com/html/mov_bbb.mp4', 680, 2, 2),
    ('VID007', 1, N'Thuật toán phân trang 6 video/trang trên Servlet JSP', 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 07', 'https://www.w3schools.com/html/mov_bbb.mp4', 710, 2, 1),
    ('VID008', 1, N'Trình phát video HTML5 Player trên trang chi tiết video', 'https://images.unsplash.com/photo-1504639725590-34d0984388bd?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 08', 'https://www.w3schools.com/html/mov_bbb.mp4', 890, 2, 1),
    ('VID009', 1, N'Hướng dẫn Upload File với @MultipartConfig chuẩn Jakarta', 'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 09', 'https://www.w3schools.com/html/mov_bbb.mp4', 940, 2, 2),
    ('VID010', 1, N'Tổng kết dự án 3-Tier MVC với JPA và Jakarta EE', 'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=600&auto=format&fit=crop&q=80', N'Lập trình Web Jakarta EE - Bài học 10', 'https://www.w3schools.com/html/mov_bbb.mp4', 1250, 2, 2);

    PRINT N'Đã chèn 10 video mẫu hoàn tất!';
END
GO
