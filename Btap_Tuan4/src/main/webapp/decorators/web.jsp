<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">${pageTitle != null ? pageTitle : 'HCMUTE Web Portal'}</sitemesh:write></title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom Decorator Styling -->
    <style>
        :root {
            --primary-color: #0d6efd;
            --secondary-color: #052c65;
        }
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background-color: #f8f9fa;
            font-family: system-ui, -apple-system, "Segoe UI", Roboto, sans-serif;
        }
        .main-content {
            flex: 1 0 auto;
        }
        .navbar-brand-badge {
            font-size: 0.75rem;
            letter-spacing: 1px;
            background: linear-gradient(45deg, #ffc107, #fd7e14);
            color: #000;
        }
        .footer-custom {
            flex-shrink: 0;
            background-color: #1a1e21;
            color: #adb5bd;
        }
        .avatar-nav {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
        }
    </style>
    
    <sitemesh:write property="head">${pageHead}</sitemesh:write>
</head>
<body>

    <!-- Header / Navbar Decorator -->
    <header>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-2">
            <div class="container">
                <a class="navbar-brand fw-bold text-primary d-flex align-items-center" href="${pageContext.request.contextPath}/home">
                    <i class="fa fa-play-circle text-danger fs-3 me-2"></i>
                    <span>HCMUTE VideoHub</span>
                    <span class="badge navbar-brand-badge ms-2 py-1 px-2 rounded-pill">Sitemesh 3</span>
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#sitemeshNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="sitemeshNavbar">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/home">
                                <i class="fa fa-home me-1"></i> Trang Chủ
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/video">
                                <i class="fa fa-film me-1"></i> Video Của Tôi (6sp/trang)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/profile">
                                <i class="fa fa-id-card me-1 text-warning"></i> Hồ Sơ Profile (OTP &amp; Cloudinary)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/videos">
                                <i class="fa fa-cog me-1"></i> Quản Trị Videos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fa fa-th-list me-1"></i> Category
                            </a>
                        </li>
                    </ul>

                    <ul class="navbar-nav ms-auto align-items-center">
                        <c:choose>
                            <c:when test="${not empty sessionScope.account}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle text-white fw-bold d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.account.avatar && sessionScope.account.avatar.startsWith('http')}">
                                                <img src="${sessionScope.account.avatar}" alt="Avatar" class="avatar-nav me-2">
                                            </c:when>
                                            <c:when test="${not empty sessionScope.account.avatar}">
                                                <img src="${pageContext.request.contextPath}/image?fname=${sessionScope.account.avatar}" alt="Avatar" class="avatar-nav me-2">
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-primary rounded-circle p-2 me-2">
                                                    <i class="fa fa-user"></i>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                        ${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-end shadow">
                                        <li>
                                            <span class="dropdown-item-text text-muted small">
                                                <i class="fa fa-envelope me-1"></i> ${sessionScope.account.email}
                                            </span>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item fw-semibold" href="${pageContext.request.contextPath}/profile">
                                                <i class="fa fa-user-edit me-2 text-primary"></i> Quản lý Hồ sơ &amp; Đổi Email
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/video">
                                                <i class="fa fa-film me-2 text-success"></i> Videos của tôi
                                            </a>
                                        </li>
                                        <li>
                                            <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/video/add">
                                                <i class="fa fa-upload me-2 text-warning"></i> Upload Video mới
                                            </a>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item text-danger fw-semibold" href="${pageContext.request.contextPath}/logout">
                                                <i class="fa fa-sign-out-alt me-2"></i> Đăng Xuất
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="nav-item">
                                    <a class="btn btn-outline-light btn-sm me-2 fw-semibold" href="${pageContext.request.contextPath}/login">
                                        <i class="fa fa-sign-in-alt me-1"></i> Đăng Nhập
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="btn btn-primary btn-sm fw-semibold" href="${pageContext.request.contextPath}/register">
                                        <i class="fa fa-user-plus me-1"></i> Đăng Ký (OTP)
                                    </a>
                                </li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Main Content Decorator Body -->
    <main class="main-content">
        <sitemesh:write property="body">${pageBody}</sitemesh:write>
    </main>

    <!-- Footer Decorator -->
    <footer class="footer-custom py-4 mt-auto border-top border-secondary">
        <div class="container text-center">
            <div class="row align-items-center">
                <div class="col-md-6 text-md-start mb-2 mb-md-0">
                    <span class="fw-bold text-white">🎓 Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE)</span><br>
                    <small>Môn học: Lập trình Web (WEBPR330479) • Bài tập Tuần 4</small>
                </div>
                <div class="col-md-6 text-md-end small">
                    <span>Sinh viên: <strong>Hồ Nhật Minh</strong> (honhatmih2806)</span><br>
                    <span>Giao diện Decorator chuẩn <strong>Bootstrap 5 &amp; SiteMesh 3</strong></span>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
