<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - HCMUTE Video Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .video-card { transition: transform 0.2s ease, box-shadow 0.2s ease; border-radius: 12px; overflow: hidden; border: none; }
        .video-card:hover { transform: translateY(-4px); box-shadow: 0 10px 25px rgba(0,0,0,0.12); }
        .video-poster-box { position: relative; height: 190px; background-color: #000; overflow: hidden; }
        .video-poster { width: 100%; height: 100%; object-fit: cover; opacity: 0.9; }
        .video-play-btn { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 48px; height: 48px; background: rgba(13, 110, 253, 0.85); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #fff; font-size: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.3); transition: transform 0.2s; }
        .video-card:hover .video-play-btn { transform: translate(-50%, -50%) scale(1.15); background: #dc3545; }
        .video-title-link { color: #212529; text-decoration: none; font-weight: 600; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; height: 48px; }
        .video-title-link:hover { color: #0d6efd; text-decoration: underline; }
    </style>
</head>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm py-3">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/home">
            <i class="fa fa-play-circle text-danger me-2"></i>HCMUTE VideoHub
        </a>
        <button class="navbar-toggler" type="button" data-bs-dismiss="collapse" data-bs-target="#navContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold" href="${pageContext.request.contextPath}/home">
                        <i class="fa fa-home me-1"></i> Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/video">
                        <i class="fa fa-film me-1"></i> Video Của Tôi (Phân Trang 6sp)
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/videos">
                        <i class="fa fa-cog me-1"></i> Quản Trị Videos (CRUD)
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/categories">
                        <i class="fa fa-th-list me-1"></i> Quản Lý Category
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle text-white fw-bold d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown">
                                <span class="badge bg-primary rounded-circle p-2 me-2">
                                    <i class="fa fa-user"></i>
                                </span>
                                ${sessionScope.account.fullname != null ? sessionScope.account.fullname : sessionScope.account.username}
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end shadow">
                                <li><span class="dropdown-item-text text-muted small"><i class="fa fa-envelope me-1"></i> ${sessionScope.account.email}</span></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/video"><i class="fa fa-film me-2"></i> Videos của tôi</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/video/add"><i class="fa fa-upload me-2"></i> Đăng Video mới</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="fa fa-sign-out-alt me-2"></i> Đăng Xuất</a></li>
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

<!-- Hero Banner -->
<div class="bg-primary text-white py-4 shadow-sm mb-4" style="background: linear-gradient(90deg, #0d6efd 0%, #052c65 100%);">
    <div class="container text-center py-2">
        <h2 class="fw-bold mb-2">🎓 Nền Tảng Video Đa Phương Tiện HCMUTE</h2>
        <p class="lead mb-3 fs-6 opacity-75">
            Bảo mật với mật khẩu băm BCrypt • Xác thực đăng ký &amp; Quên mật khẩu qua mã OTP Email • Phân trang Videos
        </p>
        <div class="d-flex justify-content-center gap-2">
            <a href="${pageContext.request.contextPath}/video" class="btn btn-warning fw-bold">
                <i class="fa fa-play-circle me-1"></i> Xem Danh Sách /video
            </a>
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-outline-light fw-semibold">
                <i class="fa fa-cloud-upload-alt me-1"></i> Upload Video Mới
            </a>
        </div>
    </div>
</div>

<!-- Top 10 Video Mới Nhất -->
<div class="container pb-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h4 class="fw-bold text-dark mb-0">
                <i class="fa fa-fire text-danger me-2"></i>Top 10 Video Mới Nhất
            </h4>
            <span class="text-muted small">Cập nhật liên tục từ cộng đồng sinh viên HCMUTE</span>
        </div>
        <a href="${pageContext.request.contextPath}/video" class="btn btn-outline-primary btn-sm fw-semibold">
            Xem tất cả <i class="fa fa-arrow-right ms-1"></i>
        </a>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-5 g-4">
        <c:forEach var="v" items="${top10Videos}">
            <div class="col">
                <div class="card h-100 video-card shadow-sm">
                    <div class="video-poster-box">
                        <c:choose>
                            <c:when test="${not empty v.poster && v.poster.startsWith('http')}">
                                <img src="${v.poster}" alt="${v.title}" class="video-poster">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/image?fname=${v.poster}" alt="${v.title}" class="video-poster">
                            </c:otherwise>
                        </c:choose>
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-play-btn" title="Phát Video">
                            <i class="fa fa-play"></i>
                        </a>
                    </div>
                    <div class="card-body p-3 d-flex flex-column">
                        <h6 class="card-title mb-2">
                            <!-- Bấm vào tiêu đề để xem chi tiết và play video -->
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title-link" title="${v.title}">
                                ${v.title}
                            </a>
                        </h6>
                        <div class="mt-auto d-flex justify-content-between align-items-center text-muted small pt-2 border-top">
                            <span><i class="fa fa-eye me-1"></i> ${v.views} lượt xem</span>
                            <span class="badge bg-light text-dark border">
                                <i class="fa fa-user me-1 text-primary"></i> ${v.user != null ? v.user.username : 'HCMUTE'}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<footer class="bg-dark text-white py-3 text-center border-top">
    <div class="container small text-muted">
        Đại học Sư phạm Kỹ thuật TP.HCM (HCMUTE) • Môn Lập trình Web PR330479 • Sinh viên: Hồ Nhật Minh
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
