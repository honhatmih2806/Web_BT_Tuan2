<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>💖 Đăng Nhập Học Viện - UTE Anime Academy 💖</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Nunito', 'Segoe UI', cursive, sans-serif;
            background: linear-gradient(135deg, #ffeef8 0%, #f0e6ff 50%, #e8f0fe 100%);
            min-height: 100vh;
            color: #4a4a68;
            overflow-x: hidden;
            position: relative;
        }

        /* Hiệu ứng cánh hoa anh đào Sakura rơi */
        .sakura-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            overflow: hidden;
            z-index: 1;
        }
        .petal {
            position: absolute;
            background: #ffb7c5;
            border-radius: 150% 0 150% 0;
            opacity: 0.6;
            animation: fall linear infinite;
        }
        @keyframes fall {
            0% { transform: translate(0, -10px) rotate(0deg); opacity: 0.8; }
            100% { transform: translate(120px, 105vh) rotate(360deg); opacity: 0; }
        }

        header {
            position: relative;
            z-index: 2;
            background: rgba(255, 255, 255, 0.75);
            backdrop-filter: blur(12px);
            border-bottom: 2px solid #ffccd5;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 20px rgba(255, 182, 193, 0.3);
        }
        .badge-anime {
            display: inline-block;
            background: linear-gradient(45deg, #ff758c, #ff7eb3);
            color: white;
            padding: 4px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 8px;
            box-shadow: 0 4px 10px rgba(255, 117, 140, 0.4);
        }
        header h1 {
            color: #d81b60;
            font-size: 1.8rem;
            font-weight: 900;
            text-shadow: 2px 2px 0px #ffe4ec;
        }

        .container {
            position: relative;
            z-index: 2;
            max-width: 500px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .anime-card {
            background: rgba(255, 255, 255, 0.92);
            border-radius: 24px;
            border: 3px solid #ffccd5;
            padding: 35px 30px;
            box-shadow: 0 15px 35px rgba(255, 154, 162, 0.3);
            backdrop-filter: blur(10px);
            text-align: center;
        }

        .mascot-icon {
            font-size: 3.5rem;
            margin-bottom: 10px;
            animation: bounce 2s infinite ease-in-out;
        }
        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        .anime-card h2 {
            color: #c2185b;
            font-size: 1.6rem;
            font-weight: 900;
            margin-bottom: 6px;
        }
        .subtitle {
            color: #8e24aa;
            font-size: 0.95rem;
            font-weight: 600;
            margin-bottom: 24px;
        }

        .form-group {
            text-align: left;
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 800;
            color: #5d4037;
            font-size: 0.95rem;
        }
        .input-wrapper {
            position: relative;
        }
        .input-icon {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 13px 14px 13px 44px;
            border: 2px solid #ffcdd2;
            border-radius: 14px;
            font-size: 1rem;
            font-family: inherit;
            background: #fffafa;
            color: #333;
            transition: all 0.25s ease;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            border-color: #ff4081;
            background: #fff;
            outline: none;
            box-shadow: 0 0 0 4px rgba(255, 64, 129, 0.2);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(45deg, #ff4081, #ff80ab);
            color: white;
            padding: 14px;
            border: none;
            border-radius: 50px;
            font-size: 1.15rem;
            font-weight: 900;
            cursor: pointer;
            box-shadow: 0 6px 20px rgba(255, 64, 129, 0.4);
            transition: all 0.25s ease;
            margin-top: 10px;
            border: 2px solid white;
        }
        .btn-submit:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 10px 25px rgba(255, 64, 129, 0.5);
            background: linear-gradient(45deg, #f50057, #ff4081);
        }

        .hint-box {
            background: #fff0f5;
            border: 2px dashed #f8bbd0;
            border-radius: 14px;
            padding: 14px;
            margin-top: 24px;
            font-size: 0.85rem;
            text-align: left;
            color: #6a1b9a;
        }
        .hint-box code {
            background: #f3e5f5;
            padding: 2px 6px;
            border-radius: 6px;
            font-weight: 700;
            color: #ad1457;
        }

        .back-link {
            margin-top: 20px;
        }
        .back-link a {
            color: #7b1fa2;
            text-decoration: none;
            font-weight: 800;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: color 0.2s;
        }
        .back-link a:hover {
            color: #e91e63;
        }

        footer {
            position: relative;
            z-index: 2;
            text-align: center;
            color: #886599;
            font-size: 0.88rem;
            font-weight: 600;
            margin: 30px 0 20px;
        }
    </style>
</head>
<body>

<div class="sakura-container">
    <div class="petal" style="left: 15%; width: 15px; height: 19px; animation-duration: 9s;"></div>
    <div class="petal" style="left: 35%; width: 13px; height: 16px; animation-duration: 12s; animation-delay: 2s;"></div>
    <div class="petal" style="left: 70%; width: 17px; height: 21px; animation-duration: 10s; animation-delay: 1s;"></div>
    <div class="petal" style="left: 88%; width: 14px; height: 18px; animation-duration: 14s; animation-delay: 4s;"></div>
</div>

<header>
    <div class="badge-anime">✨ PORTAL LOGIN ✨</div>
    <h1>🌸 HỌC VIỆN CÔNG NGHỆ UTE 🌸</h1>
</header>

<div class="container">
    <div class="anime-card">
        <div class="mascot-icon">🐱🎀</div>
        <h2>Đăng Nhập (login.jsp)</h2>
        <div class="subtitle">Nhập ID để bước vào thế giới 3 tầng desu! (◕‿◕✿)</div>

        <!-- Form gửi POST về Servlet /login -->
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label for="username">Tên nhân vật (Username):</label>
                <div class="input-wrapper">
                    <span class="input-icon">👤</span>
                    <input type="text" id="username" name="username" placeholder="vd: admin, user, sinhvien" required autofocus />
                </div>
            </div>

            <div class="form-group">
                <label for="password">Mật mã ma thuật (Password):</label>
                <div class="input-wrapper">
                    <span class="input-icon">🔑</span>
                    <input type="password" id="password" name="password" placeholder="vd: 123456, 123" required />
                </div>
            </div>

            <button type="submit" class="btn-submit">
                ✨ Login (Đăng Nhập Ngay) 🚀
            </button>
        </form>

        <div class="hint-box">
            <strong>🎀 Gợi ý mật mã nhân vật:</strong><br>
            • Sensei: <code>admin</code> / pass: <code>123456</code><br>
            • Otaku: <code>user</code> / pass: <code>123</code><br>
            • Kouhai: <code>sinhvien</code> / pass: <code>123</code>
        </div>

        <div class="back-link">
            <a href="${pageContext.request.contextPath}/home">← Quay về Cổng Trường (Trang Chủ)</a>
        </div>
    </div>
</div>

<footer>
    🌸 &copy; 2026 HCM-UTE Anime Division | Giảng viên hướng dẫn: ThS. Nguyễn Hữu Trung 🌸
</footer>

</body>
</html>
