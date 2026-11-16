<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Video Mới (Multipart Upload) - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 rounded-3">
                <div class="card-header bg-primary text-white py-3">
                    <h5 class="mb-0 fw-bold">
                        <i class="fa fa-plus-circle me-2"></i>Thêm Mới Video (Upload File Multipart)
                    </h5>
                </div>
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/admin/video/insert" method="post" enctype="multipart/form-data">
                        
                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Mã Video (VideoId)</label>
                                <input type="text" name="videoId" class="form-control" placeholder="Để trống hệ thống sẽ tự sinh (ví dụ: VID101)">
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Trạng thái hiển thị</label>
                                <select name="active" class="form-select">
                                    <option value="1" selected>Hiển thị công khai (Active = 1)</option>
                                    <option value="0">Tạm ẩn (Active = 0)</option>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tiêu đề Video <span class="text-danger">*</span></label>
                            <input type="text" name="title" class="form-control" placeholder="Nhập tiêu đề video" required>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Người đăng tải (User - Mối liên hệ 1-N)</label>
                                <select name="userId" class="form-select">
                                    <c:forEach var="u" items="${users}">
                                        <option value="${u.id}">${u.username} (${u.fullname})</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-semibold">Danh mục (Category)</label>
                                <select name="categoryId" class="form-select">
                                    <option value="">-- Không phân loại --</option>
                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.categoryid}">${c.categoryname}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Mô tả video</label>
                            <textarea name="description" class="form-control" rows="3" placeholder="Nhập mô tả chi tiết nội dung video..."></textarea>
                        </div>

                        <!-- Upload Poster -->
                        <div class="card bg-light border-0 p-3 mb-3 rounded-3">
                            <h6 class="fw-bold text-primary mb-2"><i class="fa fa-image me-1"></i> Ảnh Poster Video</h6>
                            <div class="mb-2">
                                <label class="form-label small text-muted">Chọn file ảnh từ máy tính (Multipart):</label>
                                <input type="file" name="posterFile" class="form-control" accept="image/*">
                            </div>
                            <div>
                                <label class="form-label small text-muted">Hoặc dán URL ảnh trực tuyến:</label>
                                <input type="text" name="posterUrl" class="form-control" placeholder="https://images.unsplash.com/...">
                            </div>
                        </div>

                        <!-- Upload Video / Video URL -->
                        <div class="card bg-light border-0 p-3 mb-4 rounded-3">
                            <h6 class="fw-bold text-primary mb-2"><i class="fa fa-video me-1"></i> Nguồn Video Phát</h6>
                            <div class="mb-2">
                                <label class="form-label small text-muted">Chọn file Video tải lên từ máy tính (MP4, tối đa 50MB):</label>
                                <input type="file" name="uploadVideoFile" class="form-control" accept="video/mp4,video/*">
                            </div>
                            <div>
                                <label class="form-label small text-muted">Hoặc dán đường dẫn Video/YouTube Embed:</label>
                                <input type="text" name="videoUrl" class="form-control" placeholder="https://www.w3schools.com/html/mov_bbb.mp4">
                            </div>
                        </div>

                        <div class="d-flex justify-content-between">
                            <a href="${pageContext.request.contextPath}/admin/videos" class="btn btn-outline-secondary">
                                <i class="fa fa-arrow-left me-1"></i> Quay lại
                            </a>
                            <button type="submit" class="btn btn-success fw-bold px-4">
                                <i class="fa fa-save me-1"></i> Lưu Video
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
