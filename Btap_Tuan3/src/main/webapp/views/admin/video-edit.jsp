<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Video - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-warning text-dark py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="fa fa-edit me-2"></i>Cập Nhật Video: ${video.videoId}
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/admin/video/update" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="videoId" value="${video.videoId}">

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Mã Video (Không thể thay đổi)</label>
                                <input type="text" class="form-control bg-light" value="${video.videoId}" readonly>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Trạng thái</label>
                                <select name="active" class="form-select">
                                    <option value="1" ${video.active == 1 ? 'selected' : ''}>Hiển thị công khai (Active = 1)</option>
                                    <option value="0" ${video.active == 0 ? 'selected' : ''}>Tạm ẩn (Active = 0)</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tiêu đề Video</label>
                            <input type="text" name="title" class="form-control" value="${video.title}" required>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Người đăng tải (User)</label>
                                <select name="userId" class="form-select">
                                    <c:forEach var="u" items="${users}">
                                        <option value="${u.id}" ${video.user != null && video.user.id == u.id ? 'selected' : ''}>
                                            ${u.username} (${u.fullname})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Danh mục (Category)</label>
                                <select name="categoryId" class="form-select">
                                    <option value="">-- Không phân loại --</option>
                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.categoryid}" ${video.category != null && video.category.categoryid == c.categoryid ? 'selected' : ''}>
                                            ${c.categoryname}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mô tả video</label>
                            <textarea name="description" class="form-control" rows="3">${video.description}</textarea>
                        </div>

                        <!-- Poster -->
                        <div class="card bg-light border-0 p-3 mb-3 rounded-3">
                            <h6 class="fw-bold text-primary mb-2">Poster Hiện Tại</h6>
                            <div class="d-flex align-items-center gap-3 mb-2">
                                <c:choose>
                                    <c:when test="${not empty video.poster && video.poster.startsWith('http')}">
                                        <img src="${video.poster}" alt="Poster" style="width: 120px; height: 70px; object-fit: cover; border-radius: 6px;">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/image?fname=${video.poster}" alt="Poster" style="width: 120px; height: 70px; object-fit: cover; border-radius: 6px;">
                                    </c:otherwise>
                                </c:choose>
                                <div>
                                    <span class="text-muted small">Thay đổi file poster mới (nếu muốn):</span>
                                    <input type="file" name="posterFile" class="form-control form-control-sm mt-1" accept="image/*">
                                </div>
                            </div>
                            <input type="text" name="posterUrl" class="form-control form-control-sm" value="${video.poster}" placeholder="Hoặc dán URL poster">
                        </div>

                        <!-- Video URL / Upload -->
                        <div class="card bg-light border-0 p-3 mb-4 rounded-3">
                            <h6 class="fw-bold text-primary mb-2">Nguồn Video</h6>
                            <div class="mb-2">
                                <label class="form-label small text-muted">Upload file MP4 mới (tối đa 50MB):</label>
                                <input type="file" name="uploadVideoFile" class="form-control form-control-sm" accept="video/mp4,video/*">
                            </div>
                            <input type="text" name="videoUrl" class="form-control form-control-sm" value="${video.videoUrl}" placeholder="Hoặc dán URL Video">
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-outline-secondary">
                                <i class="fa fa-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-warning fw-bold px-4">
                                <i class="fa fa-save me-1"></i> Cập Nhật Video
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
