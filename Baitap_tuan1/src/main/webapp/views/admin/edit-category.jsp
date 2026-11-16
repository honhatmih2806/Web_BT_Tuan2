<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập Nhật Danh Mục - HCM-UTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .card-edit { max-width: 600px; margin: 40px auto; border-radius: 12px; }
        .preview-img { width: 120px; height: 90px; object-fit: cover; border-radius: 8px; border: 2px solid #0d6efd; }
    </style>
</head>
<body class="bg-light">

<jsp:include page="../topbar.jsp" />

<div class="container">
    <div class="card card-edit shadow-sm border-0 p-4 bg-white">
        <h4 class="text-primary fw-bold mb-3">
            <i class="fa fa-edit me-2"></i>Chỉnh Sửa Danh Mục
        </h4>
        <p class="text-muted small mb-4">Cập nhật tên danh mục và thay đổi ảnh icon nếu muốn.</p>

        <!-- Form chỉnh sửa danh mục -->
        <form action="${pageContext.request.contextPath}/admin/category/edit" method="post" enctype="multipart/form-data">
            <!-- Hidden input lưu ID danh mục -->
            <input type="hidden" name="id" value="${category.id}" />

            <div class="mb-3">
                <label class="form-label fw-semibold">Mã danh mục (ID):</label>
                <input type="text" class="form-control bg-light" value="${category.id}" readonly />
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Tên danh mục:</label>
                <input type="text" class="form-control" name="catename" value="${category.name}" required autofocus />
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold d-block">Ảnh đại diện hiện tại:</label>
                <c:url value="/image?fname=${category.icon}" var="imgUrl" />
                <div class="mb-2">
                    <img src="${imgUrl}" alt="${category.name}" class="preview-img shadow-sm" />
                </div>
                <label class="form-label fw-semibold">Chọn ảnh mới (nếu muốn thay đổi):</label>
                <input type="file" class="form-control" name="icon" accept="image/*" />
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                    <i class="fa fa-save me-1"></i> Cập Nhật
                </button>
                <button type="reset" class="btn btn-outline-secondary">Khôi phục</button>
                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-link text-decoration-none ms-auto">
                    &larr; Quay lại danh sách
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
