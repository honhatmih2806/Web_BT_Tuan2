<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Danh Mục (Add Category) - JPA 3.0</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .card-form { max-width: 600px; margin: 40px auto; border-radius: 12px; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<c:url value='/admin/categories'/>">
            🎓 HCM-UTE: CRUD Category với JPA 3.0
        </a>
    </div>
</nav>

<div class="container">
    <div class="card card-form shadow-sm border-0 p-4 bg-white">
        <h4 class="text-primary fw-bold mb-3">
            <i class="fa fa-folder-plus me-2"></i>Thêm Mới Category (JPA Insert)
        </h4>

        <!-- Form theo mẫu chuẩn trong bài giảng utexlms -->
        <form action="<c:url value="/admin/category/insert"/>" method="post" enctype="multipart/form-data">
            <div class="mb-3">
                <label for="categoryname" class="form-label fw-semibold">Category name:</label>
                <input type="text" class="form-control" id="categoryname" name="categoryname" placeholder="Nhập tên category" required autofocus />
            </div>

            <div class="mb-3">
                <label for="images" class="form-label fw-semibold">Link images (URL):</label>
                <input type="text" class="form-control" id="images" name="images" placeholder="https://example.com/image.png (nếu có)" />
            </div>

            <div class="mb-3">
                <label for="images1" class="form-label fw-semibold">Upload images (File):</label>
                <input type="file" class="form-control" id="images1" name="images1" accept="image/*" />
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold d-block">Status:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="ston" name="status" value="1" checked>
                    <label class="form-check-label text-success fw-semibold" for="ston">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="stoff" name="status" value="0">
                    <label class="form-check-label text-danger fw-semibold" for="stoff">Khóa</label>
                </div>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                    <i class="fa fa-save me-1"></i> Insert
                </button>
                <button type="reset" class="btn btn-outline-secondary">Reset</button>
                <a href="<c:url value='/admin/categories'/>" class="btn btn-link text-decoration-none ms-auto">
                    &larr; Back to list
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
