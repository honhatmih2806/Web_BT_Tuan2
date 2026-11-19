<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${video.title} - HCMUTE Video Player</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .player-container { background-color: #000; border-radius: 12px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        .related-card { transition: background-color 0.2s; text-decoration: none; color: inherit; }
        .related-card:hover { background-color: #e9ecef; }
        .related-thumb { width: 120px; height: 75px; object-fit: cover; border-radius: 6px; }
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
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/home">Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/video">Tất Cả Video (6sp/trang)</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/videos">Quản Trị</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.account}">
                        <span class="text-white me-3 small">
                            <i class="fa fa-user-circle me-1 text-primary"></i> ${sessionScope.account.fullname}
                        </span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Đăng Xuất</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm">Đăng Nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="row g-4">
        <!-- Cột trái: Trình phát video & Thông tin chi tiết -->
        <div class="col-lg-8">
            <div class="player-container mb-3">
                <c:choose>
                    <c:when test="${not empty video.videoUrl && video.videoUrl.contains('youtube.com/embed')}">
                        <iframe width="100%" height="450" src="${video.videoUrl}?autoplay=1" title="${video.title}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                    </c:when>
                    <c:when test="${not empty video.videoUrl && video.videoUrl.startsWith('http')}">
                        <video controls autoplay class="w-100" style="max-height: 480px; object-fit: contain;">
                            <source src="${video.videoUrl}" type="video/mp4">
                            Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
                        </video>
                    </c:when>
                    <c:otherwise>
                        <video controls autoplay class="w-100" style="max-height: 480px; object-fit: contain;">
                            <source src="${pageContext.request.contextPath}/image?fname=${video.videoUrl}" type="video/mp4">
                            Trình duyệt của bạn không hỗ trợ thẻ video HTML5.
                        </video>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Tiêu đề & Thông tin Video -->
            <div class="card border-0 shadow-sm p-4 rounded-3 mb-4">
                <h3 class="fw-bold text-dark mb-2">${video.title}</h3>

                <div class="d-flex flex-wrap justify-content-between align-items-center pb-3 border-bottom text-muted small">
                    <div class="d-flex align-items-center gap-3">
                        <span><i class="fa fa-eye text-primary me-1"></i> <strong>${video.views}</strong> lượt xem</span>
                        <span><i class="fa fa-tag text-success me-1"></i> Mã Video: <strong>${video.videoId}</strong></span>
                        <c:if test="${video.category != null}">
                            <span class="badge bg-primary-subtle text-primary border">${video.category.categoryname}</span>
                        </c:if>
                    </div>
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/video/edit?id=${video.videoId}" class="btn btn-outline-secondary btn-sm">
                            <i class="fa fa-edit me-1"></i> Chỉnh sửa video
                        </a>
                    </div>
                </div>

                <!-- Thông tin tác giả & Mô tả -->
                <div class="d-flex align-items-center mt-3 mb-3">
                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-3" style="width: 48px; height: 48px; font-size: 20px;">
                        <i class="fa fa-user"></i>
                    </div>
                    <div>
                        <h6 class="mb-0 fw-bold">${video.user != null ? video.user.fullname : 'Giảng viên HCMUTE'}</h6>
                        <span class="text-muted small">${video.user != null ? video.user.email : 'web@hcmute.edu.vn'}</span>
                    </div>
                </div>

                <div class="bg-light p-3 rounded-3 mt-2">
                    <h6 class="fw-bold text-secondary mb-1">Mô tả video:</h6>
                    <p class="mb-0 text-dark" style="white-space: pre-line;">
                        ${video.description != null ? video.description : 'Chưa có thông tin mô tả chi tiết cho video này.'}
                    </p>
                </div>
            </div>
        </div>

        <!-- Cột phải: Video liên quan / đề xuất -->
        <div class="col-lg-4">
            <div class="card border-0 shadow-sm p-3 rounded-3">
                <h5 class="fw-bold text-dark mb-3">
                    <i class="fa fa-list-ul text-primary me-2"></i>Video Đề Xuất
                </h5>

                <div class="list-group list-group-flush">
                    <c:forEach var="rel" items="${relatedVideos}">
                        <a href="${pageContext.request.contextPath}/video/detail?id=${rel.videoId}" class="list-group-item list-group-item-action p-2 border-0 mb-2 rounded-2 related-card d-flex gap-2">
                            <c:choose>
                                <c:when test="${not empty rel.poster && rel.poster.startsWith('http')}">
                                    <img src="${rel.poster}" alt="${rel.title}" class="related-thumb">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/image?fname=${rel.poster}" alt="${rel.title}" class="related-thumb">
                                </c:otherwise>
                            </c:choose>
                            <div class="flex-grow-1 overflow-hidden">
                                <h6 class="mb-1 text-truncate fw-semibold text-dark small" title="${rel.title}">${rel.title}</h6>
                                <div class="text-muted" style="font-size: 11px;">
                                    <i class="fa fa-eye me-1"></i> ${rel.views} lượt xem
                                </div>
                                <div class="text-muted" style="font-size: 11px;">
                                    ${rel.user != null ? rel.user.username : 'HCMUTE'}
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
