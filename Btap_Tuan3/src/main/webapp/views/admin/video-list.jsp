<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Trị Videos (CRUD) - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .video-thumb-table { width: 100px; height: 60px; object-fit: cover; border-radius: 6px; }
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
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/video">Xem /video</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active fw-semibold" href="${pageContext.request.contextPath}/admin/videos">Quản Lý Videos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-semibold" href="${pageContext.request.contextPath}/admin/categories">Quản Lý Category</a>
                </li>
            </ul>
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">Đăng Xuất</a>
            </div>
        </div>
    </div>
</nav>

<div class="container py-4">
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <div>
                <h4 class="mb-0 text-primary fw-bold">
                    <i class="fa fa-film me-2"></i>Danh Sách Video (Bảng Videos - 1-n Users)
                </h4>
                <small class="text-muted">Thực hiện đầy đủ chức năng CRUD &amp; Upload Multipart</small>
            </div>
            <a href="${pageContext.request.contextPath}/admin/video/add" class="btn btn-success fw-semibold">
                <i class="fa fa-plus-circle me-1"></i> Thêm Video Mới
            </a>
        </div>

        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0 text-center">
                    <thead class="table-dark text-nowrap">
                        <tr>
                            <th style="width: 100px;">Mã Video</th>
                            <th style="width: 120px;">Poster</th>
                            <th class="text-start">Tiêu đề &amp; Mô tả</th>
                            <th style="width: 140px;">Người đăng (User)</th>
                            <th style="width: 120px;">Category</th>
                            <th style="width: 100px;">Lượt xem</th>
                            <th style="width: 100px;">Trạng thái</th>
                            <th style="width: 150px;">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty videos}">
                                <c:forEach var="v" items="${videos}">
                                    <tr>
                                        <td class="fw-bold text-secondary">${v.videoId}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty v.poster && v.poster.startsWith('http')}">
                                                    <img src="${v.poster}" alt="${v.title}" class="video-thumb-table shadow-sm">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/image?fname=${v.poster}" alt="${v.title}" class="video-thumb-table shadow-sm">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-start">
                                            <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="fw-bold text-decoration-none text-dark d-block">
                                                ${v.title}
                                            </a>
                                            <span class="text-muted small" style="display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden;">
                                                ${v.description}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge bg-light text-dark border">
                                                <i class="fa fa-user me-1 text-primary"></i> ${v.user != null ? v.user.username : 'nhatminh'}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge bg-info-subtle text-info-emphasis border">
                                                ${v.category != null ? v.category.categoryname : 'N/A'}
                                            </span>
                                        </td>
                                        <td><span class="badge bg-secondary">${v.views}</span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${v.active == 1}">
                                                    <span class="badge bg-success">Hiển thị</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">Ẩn</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="btn-group btn-group-sm">
                                                <a href="${pageContext.request.contextPath}/video/detail?id=${v.videoId}" class="btn btn-outline-info" title="Xem & Phát Video">
                                                    <i class="fa fa-play"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/video/edit?id=${v.videoId}" class="btn btn-outline-warning" title="Chỉnh sửa">
                                                    <i class="fa fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/video/delete?id=${v.videoId}" class="btn btn-outline-danger" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa video này?');">
                                                    <i class="fa fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-muted py-4">Chưa có video nào trong hệ thống.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
