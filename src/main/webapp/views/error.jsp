<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>💔 Gomenasai! Lỗi Đăng Nhập - UTE Anime Academy 💔</title>
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

        /* Hiệu ứng cánh hoa rơi nhẹ */
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
            background: linear-gradient(45deg, #e91e63, #ff5252);
            color: white;
            padding: 4px 14px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 800;
            letter-spacing: 1px;
            margin-bottom: 8px;
            box-shadow: 0 4px 10px rgba(233, 30, 99, 0.4);
        }
        header h1 {
            color: #c2185b;
            font-size: 1.8rem;
            font-weight: 900;
            text-shadow: 2px 2px 0px #ffe4ec;
        }

        .container {
            position: relative;
            z-index: 2;
            max-width: 520px;
            margin: 45px auto;
            padding: 0 20px;
        }

        .anime-card {
            background: rgba(255, 255, 255, 0.92);
            border-radius: 24px;
            border: 3px solid #ff80ab;
            padding: 35px 30px;
            box-shadow: 0 15px 35px rgba(255, 64, 129, 0.25);
            backdrop-filter: blur(10px);
            text-align: center;
        }

        .chibi-crying {
            font-size: 3.8rem;
            margin-bottom: 8px;
            animation: shake 1.5s infinite;
        }
        @keyframes shake {
            0%, 100% { transform: rotate(0deg); }
            25% { transform: rotate(-5deg); }
            75% { transform: rotate(5deg); }
        }

        .anime-card h2 {
            color: #d81b60;
            font-size: 1.6rem;
            font-weight: 900;
            margin-bottom: 12px;
        }

        .kaomoji {
            font-size: 1.25rem;
            font-weight: 800;
            color: #e91e63;
            margin-bottom: 16px;
        }

        .alert-anime-error {
            background: #fff0f3;
            border: 2px dashed #ff4081;
            border-radius: 16px;
            padding: 16px;
            color: #b71c1c;
            font-weight: 700;
            font-size: 1rem;
            margin-bottom: 22px;
        }

        .desc-text {
            color: #616161;
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 26px;
        }

        .actions {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .btn-retry {
            display: inline-block;
            background: linear-gradient(45deg, #ff4081, #ff80ab);
            color: white;
            padding: 13px 28px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 800;
            font-size: 1.05rem;
            box-shadow: 0 6px 18px rgba(255, 64, 129, 0.4);
            transition: all 0.25s ease;
            border: 2px solid white;
        }
        .btn-retry:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 22px rgba(255, 64, 129, 0.5);
            background: linear-gradient(45deg, #f50057, #ff4081);
        }

        .btn-home {
            display: inline-block;
            background: #ede7f6;
            color: #6a1b9a;
            padding: 11px 28px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 800;
            font-size: 0.95rem;
            transition: all 0.25s ease;
            border: 2px solid #d1c4e9;
        }
        .btn-home:hover {
            background: #d1c4e9;
            color: #4a148c;
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
    <div class="petal" style="left: 20%; width: 14px; height: 18px; animation-duration: 9s;"></div>
    <div class="petal" style="left: 55%; width: 16px; height: 20px; animation-duration: 12s; animation-delay: 2s;"></div>
    <div class="petal" style="left: 80%; width: 13px; height: 17px; animation-duration: 10s; animation-delay: 1s;"></div>
</div>

<header>
    <div class="badge-anime">⚠️ CẢNH BÁO / WARNING ⚠️</div>
    <h1>🌸 HỌC VIỆN CÔNG NGHỆ UTE 🌸</h1>
</header>

<div class="container">
    <div class="anime-card">
        <div class="chibi-crying">💔(╥﹏╥)💔</div>
        <h2>Thông Báo Lỗi (error.jsp)</h2>
        <div class="kaomoji">Gomenasai, Senpai! Đăng nhập thất bại rồi...</div>

        <div class="alert-anime-error">
            <c:choose>
                <c:when test="${not empty errorMessage}">
                    <c:out value="${errorMessage}"/>
                </c:when>
                <c:otherwise>
                    Đăng nhập không thành công! Tên nhân vật hoặc mật mã chưa chính xác.
                </c:otherwise>
            </c:choose>
        </div>

        <p class="desc-text">
            Baka! Có thể bạn đã gõ nhầm mật mã ma thuật rồi. Hãy kiểm tra lại bảng tài khoản mẫu và thử lại nhé! (｡•́︿•̀｡)
        </p>

        <div class="actions">
            <a href="${pageContext.request.contextPath}/login" class="btn-retry">
                ✨ Thử Đăng Nhập Lại (Ganbatte!) 🚀
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn-home">
                🌸 Quay Về Cổng Trường (Trang Chủ)
            </a>
        </div>
    </div>
</div>

<footer>
    🌸 &copy; 2026 HCM-UTE Anime Division | Giảng viên hướng dẫn: ThS. Nguyễn Hữu Trung 🌸
</footer>

</body>
</html>
