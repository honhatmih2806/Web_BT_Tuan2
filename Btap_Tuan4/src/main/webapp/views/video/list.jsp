<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Video (Phân Trang 6 video/trang) - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .video-card { transition: transform 0.2s ease, box-shadow 0.2s ease; border-radius: 12px; overflow: hidden; border: none; }
        .video-card:hover { transform: translateY(-4px); box-shadow: 0 10px 25px rgba(0,0,0,0.12); }
        .video-poster-box { position: relative; height: 210px; background-color: #000; overflow: hidden; }
        .video-poster { width: 100%; height: 100%; object-fit: cover; }
        .video-play-btn { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); width: 50px; height: 50px; background: rgba(13, 110, 253, 0.9); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #fff; font-size: 22px; transition: transform 0.2s; }
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
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/home">
                        <i class="fa fa-home me-1"></i> Trang Chủ
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active fw-semibold" href="${pageContext.request.contextPath}/video">
                        <i class="fa fa-film me-1"></i> Video Phân Trang (6 video/trang)
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/videos">
                        <i class="fa fa-cog me-1"></i> Quản Trị Videos
                    </a>
                </li>
            </ul>

            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <span class="text-white me-3 small">
                            <i class="fa fa-user-circle me-1 text-primary"></i> ${sessionScope.account.fullname}
                        </span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                            <i class="fa fa-sign-out-alt me-1"></i> Đăng Xuất
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-light btn-sm me-2">Đăng Nhập</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-sm">Đăng Ký (OTP)</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
        <div>
            <h3 class="fw-bold text-dark mb-1">
                <i class="fa fa-video text-primary me-2"></i>
                <c:choose>
                    <c:when test="${isUserScope}">
                        Videos Của Bạn (${sessionScope.account.username})
                    </c:when>
                    <c:otherwise>
                        Tất Cả Videos Tuyển Chọn
                    </c:otherwise>
                </c:choose>
            </h3>
            <p class="text-muted small mb-0">Hiển thị danh sách được phân trang chuẩn <strong>6 video mỗi trang</strong></p>
        </div>
        <div>
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-success fw-semibold shadow-sm">
                <i class="fa fa-plus-circle me-1"></i> Upload Video Mới
            </a>
        </div>
    </div>

    <!-- Grid 6 video / trang -->
    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4 mb-5">
        <c:forEach var="v" items="${videos}">
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
                        <!-- Nút play chuyển sang trang detail phát video -->
                        <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-play-btn" title="Phát video">
                            <i class="fa fa-play"></i>
                        </a>
                    </div>
                    <div class="card-body p-3 d-flex flex-column">
                        <h5 class="card-title mb-2">
                            <!-- Bấm vào tiêu đề để xem chi tiết và play video -->
                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="video-title-link" title="${v.title}">
                                ${v.title}
                            </a>
                        </h5>
                        <p class="card-text text-muted small flex-grow-1" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">
                            ${v.description != null ? v.description : 'Không có mô tả cho video này.'}
                        </p>
                        <div class="d-flex justify-content-between align-items-center pt-2 border-top text-muted small">
                            <span><i class="fa fa-eye me-1"></i> ${v.views} lượt xem</span>
                            <span class="badge bg-secondary-subtle text-secondary border">
                                ID: ${v.videoId}
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- Phân trang Pagination -->
    <c:if test="${totalPages > 1}">
        <nav aria-label="Phân trang video" class="d-flex justify-content-center">
            <ul class="pagination pagination-lg">
                <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/video?page=${currentPage - 1}" aria-label="Trước">
                        <span aria-hidden="true">&laquo; Trang trước</span>
                    </a>
                </li>
                <c:forEach begin="1" end="${totalPages}" var="p">
                    <li class="page-item ${p == currentPage ? 'active' : ''}">
                        <a class="page-link" href="${pageContext.request.contextPath}/video?page=${p}">${p}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="${pageContext.request.contextPath}/video?page=${currentPage + 1}" aria-label="Sau">
                        <span aria-hidden="true">Trang sau &raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
        <div class="text-center text-muted small mt-2">
            Đang xem trang <strong>${currentPage}</strong> trên tổng số <strong>${totalPages}</strong> trang (Tổng cộng ${totalItems} video)
        </div>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
