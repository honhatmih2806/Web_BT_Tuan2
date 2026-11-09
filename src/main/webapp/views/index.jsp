<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🌸 UTE Anime Academy - Trang Chủ 🌸</title>
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
            font-size: 1.9rem;
            font-weight: 900;
            text-shadow: 2px 2px 0px #ffe4ec;
        }
        header p {
            color: #7b5294;
            font-size: 1rem;
            font-weight: 600;
            margin-top: 4px;
        }

        .container {
            position: relative;
            z-index: 2;
            max-width: 860px;
            margin: 35px auto;
            padding: 0 20px;
        }

        .anime-card {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 24px;
            border: 3px solid #ffccd5;
            padding: 35px;
            box-shadow: 0 15px 35px rgba(255, 154, 162, 0.25);
            backdrop-filter: blur(10px);
            position: relative;
        }

        .card-header-anime {
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 2px dashed #ffb6c1;
            padding-bottom: 14px;
            margin-bottom: 24px;
        }
        .card-header-anime h2 {
            color: #c2185b;
            font-size: 1.6rem;
            font-weight: 800;
        }
        .chibi-avatar {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #ff9a9e, #fecfef);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            border: 2px solid white;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        /* Profile User Card */
        .character-profile {
            background: linear-gradient(135deg, #fff5f8, #f5f0ff);
            border: 2px solid #e8cbf5;
            border-radius: 18px;
            padding: 24px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: 0 8px 16px rgba(186, 104, 200, 0.15);
        }
        .profile-avatar-big {
            width: 85px;
            height: 85px;
            background: linear-gradient(135deg, #f093fb, #f5576c);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.8rem;
            border: 4px solid white;
            box-shadow: 0 6px 15px rgba(245, 87, 108, 0.3);
            flex-shrink: 0;
        }
        .profile-info h3 {
            color: #d81b60;
            font-size: 1.4rem;
            font-weight: 800;
            margin-bottom: 6px;
        }
        .profile-tag {
            display: inline-block;
            background: #ab47bc;
            color: white;
            padding: 3px 12px;
            border-radius: 12px;
            font-size: 0.8rem;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .profile-info p {
            color: #555;
            font-size: 0.95rem;
            margin: 3px 0;
        }

        /* Nút phong cách Anime */
        .btn-anime {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: linear-gradient(45deg, #ff4081, #ff80ab);
            color: white;
            padding: 13px 32px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 1.1rem;
            font-weight: 800;
            box-shadow: 0 6px 20px rgba(255, 64, 129, 0.4);
            transition: all 0.25s ease;
            border: 2px solid #fff;
        }
        .btn-anime:hover {
            transform: translateY(-3px) scale(1.03);
            box-shadow: 0 10px 25px rgba(255, 64, 129, 0.5);
            background: linear-gradient(45deg, #f50057, #ff4081);
        }
        .btn-logout {
            background: linear-gradient(45deg, #78909c, #546e7a);
            box-shadow: 0 6px 15px rgba(84, 110, 122, 0.3);
        }
        .btn-logout:hover {
            background: linear-gradient(45deg, #546e7a, #37474f);
            box-shadow: 0 8px 20px rgba(84, 110, 122, 0.4);
        }

        /* Character cards list */
        .character-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 16px;
            margin-top: 18px;
        }
        .char-card {
            background: white;
            border-radius: 16px;
            border: 2px solid #ffccd5;
            padding: 16px;
            text-align: center;
            box-shadow: 0 4px 12px rgba(255, 182, 193, 0.2);
            transition: transform 0.2s;
        }
        .char-card:hover { transform: translateY(-4px); }
        .char-icon { font-size: 2.2rem; margin-bottom: 6px; }
        .char-name { font-weight: 800; color: #c2185b; font-size: 1.05rem; }
        .char-role { font-size: 0.8rem; color: #8e24aa; font-weight: 700; margin-bottom: 6px; }
        .char-acc {
            background: #fff0f5;
            border-radius: 8px;
            padding: 6px;
            font-size: 0.85rem;
            color: #444;
        }

        footer {
            position: relative;
            z-index: 2;
            text-align: center;
            color: #886599;
            font-size: 0.9rem;
            font-weight: 600;
            margin: 30px 0 20px;
        }
    </style>
</head>
<body>

<!-- Hiệu ứng Sakura bay lơ lửng -->
<div class="sakura-container">
    <div class="petal" style="left: 10%; width: 14px; height: 18px; animation-duration: 8s; animation-delay: 0s;"></div>
    <div class="petal" style="left: 25%; width: 16px; height: 20px; animation-duration: 11s; animation-delay: 2s;"></div>
    <div class="petal" style="left: 45%; width: 12px; height: 15px; animation-duration: 9s; animation-delay: 4s;"></div>
    <div class="petal" style="left: 65%; width: 18px; height: 22px; animation-duration: 13s; animation-delay: 1s;"></div>
    <div class="petal" style="left: 80%; width: 15px; height: 19px; animation-duration: 10s; animation-delay: 3s;"></div>
    <div class="petal" style="left: 92%; width: 13px; height: 16px; animation-duration: 12s; animation-delay: 5s;"></div>
</div>

<header>
    <div class="badge-anime">✨ HCM-UTE ANIME PROJECT ✨</div>
    <h1>🌸 HỌC VIỆN CÔNG NGHỆ UTE 🌸</h1>
    <p>Kiến Trúc 3 Tầng Siêu Đẳng (Jakarta EE 11 &amp; Tomcat 11.0)</p>
</header>

<div class="container">
    <div class="anime-card">
        <div class="card-header-anime">
            <div class="chibi-avatar">⛩️</div>
            <h2>Trang Chủ (index.jsp)</h2>
        </div>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <!-- Khi đã đăng nhập thành công -->
                <div class="character-profile">
                    <div class="profile-avatar-big">
                        <c:choose>
                            <c:when test="${sessionScope.user.role eq 'ADMIN'}">👑</c:when>
                            <c:otherwise>🌸</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="profile-info">
                        <div class="profile-tag">✦ LEVEL: <c:out value="${sessionScope.user.role}"/> ✦</div>
                        <h3>Kon'nichiwa, <c:out value="${sessionScope.user.fullName}"/> Senpai! (≧◡≦) ♡</h3>
                        <p><strong>Username:</strong> <code>@<c:out value="${sessionScope.user.username}"/></code></p>
                        <p><strong>Email:</strong> <c:out value="${sessionScope.user.email}"/></p>
                        <p><strong>Trạng thái:</strong> <span style="color: #2e7d32; font-weight: 700;">● Đã Đăng Nhập Thành Công (Online)</span></p>
                    </div>
                </div>

                <div style="text-align: center; margin-top: 20px;">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-anime btn-logout">
                        Sayonara (Đăng Xuất) 🚪
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Khi chưa đăng nhập -->
                <p style="font-size: 1.1rem; line-height: 1.7; text-align: center; margin-bottom: 20px;">
                    Okaeri! Chào mừng bạn đến với ứng dụng demo kiến trúc 3 tầng phong cách Anime! ✨<br>
                    Hãy click nút bên dưới để tiến vào sảnh đăng nhập học viện:
                </p>

                <div style="text-align: center; margin: 25px 0 35px;">
                    <!-- Yêu cầu: hiển thị trang login.jsp khi bấm vào link Login trên trang index.jsp -->
                    <a href="${pageContext.request.contextPath}/login" class="btn-anime">
                        ✨ Tiến Vào Đăng Nhập (Login Desu) 💖
                    </a>
                </div>

                <div style="border-top: 2px dashed #ffccd5; padding-top: 20px;">
                    <h4 style="color: #c2185b; margin-bottom: 12px; font-weight: 800; text-align: center;">
                        🌟 Danh Sách Nhân Vật Mẫu Sẵn Có (Mock Database) 🌟
                    </h4>
                    <div class="character-grid">
                        <div class="char-card">
                            <div class="char-icon">👨‍🏫</div>
                            <div class="char-name">ThS. Nguyễn Hữu Trung</div>
                            <div class="char-role">Grand Sensei (ADMIN)</div>
                            <div class="char-acc">
                                User: <strong>admin</strong><br>
                                Pass: <strong>123456</strong>
                            </div>
                        </div>
                        <div class="char-card">
                            <div class="char-icon">🧑‍💻</div>
                            <div class="char-name">Nguyễn Văn A</div>
                            <div class="char-role">Otaku Coder (USER)</div>
                            <div class="char-acc">
                                User: <strong>user</strong><br>
                                Pass: <strong>123</strong>
                            </div>
                        </div>
                        <div class="char-card">
                            <div class="char-icon">🎀</div>
                            <div class="char-name">Lê Thị B</div>
                            <div class="char-role">Magical Kouhai (USER)</div>
                            <div class="char-acc">
                                User: <strong>sinhvien</strong><br>
                                Pass: <strong>123</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer>
    🌸 &copy; 2026 HCM-UTE Anime Division | Giảng viên hướng dẫn: ThS. Nguyễn Hữu Trung 🌸
</footer>

</body>
</html>
