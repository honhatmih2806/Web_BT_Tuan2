<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Category (Edit Category) - JPA 3.0</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .card-form { max-width: 600px; margin: 40px auto; border-radius: 12px; }
        .preview-img { width: 150px; height: 110px; object-fit: cover; border-radius: 8px; border: 2px solid #0d6efd; }
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
            <i class="fa fa-edit me-2"></i>Cập Nhật Category (JPA Update)
        </h4>

        <!-- Form theo mẫu chuẩn trong bài giảng utexlms -->
        <form action="<c:url value="/admin/category/update"/>" method="post" enctype="multipart/form-data">
            <input type="hidden" name="categoryid" value="${cate.categoryid}">

            <div class="mb-3">
                <label class="form-label fw-semibold">Category ID:</label>
                <input type="text" class="form-control bg-light" value="${cate.categoryid}" readonly>
            </div>

            <div class="mb-3">
                <label for="categoryname" class="form-label fw-semibold">Category name:</label>
                <input type="text" class="form-control" id="categoryname" name="categoryname" value="${cate.categoryname}" required autofocus />
            </div>

            <div class="mb-3">
                <label for="images" class="form-label fw-semibold">Link images (URL):</label>
                <input type="text" class="form-control" id="images" name="images" value="${cate.images}" />
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold d-block">Ảnh hiện tại:</label>
                <c:choose>
                    <c:when test="${not empty cate.images and (cate.images.startsWith('http://') or cate.images.startsWith('https://'))}">
                        <c:url value="${cate.images}" var="imgUrl"></c:url>
                    </c:when>
                    <c:otherwise>
                        <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                    </c:otherwise>
                </c:choose>
                <img class="preview-img shadow-sm mb-2" src="${imgUrl}" alt="${cate.categoryname}" /><br>
                <label for="images1" class="form-label fw-semibold">Upload images mới (nếu muốn thay thế):</label>
                <input type="file" class="form-control" id="images1" name="images1" accept="image/*" />
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold d-block">Status:</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="ston" name="status" value="1" ${cate.status==1 ? 'checked' : ''}>
                    <label class="form-check-label text-success fw-semibold" for="ston">Hoạt động</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" id="stoff" name="status" value="0" ${cate.status!=1 ? 'checked' : ''}>
                    <label class="form-check-label text-danger fw-semibold" for="stoff">Khóa</label>
                </div>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-primary px-4 fw-semibold">
                    <i class="fa fa-save me-1"></i> Update
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
