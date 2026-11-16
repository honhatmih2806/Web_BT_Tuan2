<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Danh Mục Mới - HCM-UTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .card-add { max-width: 600px; margin: 40px auto; border-radius: 12px; }
    </style>
</head>
<body class="bg-light">

<jsp:include page="../topbar.jsp" />

<div class="container">
    <div class="card card-add shadow-sm border-0 p-4 bg-white">
        <h4 class="text-primary fw-bold mb-3">
            <i class="fa fa-folder-plus me-2"></i>Thêm Mới Danh Mục
        </h4>
        <p class="text-muted small mb-4">Nhập tên danh mục và tải lên ảnh biểu tượng icon đại diện.</p>

        <!-- Form thêm danh mục với enctype multipart/form-data -->
        <form action="${pageContext.request.contextPath}/admin/category/add" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên danh mục:</label>
                <input type="text" class="form-control" name="catename" placeholder="Vui lòng nhập tên danh mục (vd: Thiết bị gia dụng)" required autofocus />
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold">Ảnh đại diện (Icon):</label>
                <input type="file" class="form-control" name="icon" accept="image/*" />
                <div class="form-text">Định dạng hỗ trợ: PNG, JPG, JPEG, GIF, SVG.</div>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                    <i class="fa fa-save me-1"></i> Lưu Danh Mục
                </button>
                <button type="reset" class="btn btn-outline-secondary">Hủy</button>
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
