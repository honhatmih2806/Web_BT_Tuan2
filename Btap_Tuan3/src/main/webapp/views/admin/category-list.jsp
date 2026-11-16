<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Category - JPA 3.0 &amp; Jakarta EE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .img-cate { width: 150px; height: 110px; object-fit: cover; border-radius: 8px; border: 1px solid #dee2e6; }
    </style>
</head>
<body class="bg-light">

<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<c:url value='/admin/categories'/>">
            🎓 HCM-UTE: CRUD Category với JPA 3.0
        </a>
        <div class="navbar-nav ms-auto">
            <a class="nav-link text-white fw-semibold" href="<c:url value='/admin/category/add'/>">
                <i class="fa fa-plus-circle me-1"></i> Add Category
            </a>
        </div>
    </div>
</nav>

<div class="container py-2">
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h4 class="mb-0 text-primary fw-bold">
                <i class="fa fa-list me-2"></i>Category Management (JPA Hibernate)
            </h4>
            <a href="<c:url value='/admin/category/add'/>" class="btn btn-success fw-semibold">
                <i class="fa fa-plus me-1"></i> Add Category
            </a>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle text-center mb-0">
                    <thead class="table-primary">
                        <tr>
                            <th style="width: 70px;">STT</th>
                            <th style="width: 180px;">Images</th>
                            <th class="text-start">Category name</th>
                            <th style="width: 140px;">Status</th>
                            <th style="width: 180px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty listcate}">
                                <c:forEach items="${listcate}" var="cate" varStatus="STT">
                                    <tr>
                                        <td class="fw-bold">${STT.index + 1}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty cate.images and (cate.images.startsWith('http://') or cate.images.startsWith('https://'))}">
                                                    <c:url value="${cate.images}" var="imgUrl"></c:url>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:url value="/image?fname=${cate.images}" var="imgUrl"></c:url>
                                                </c:otherwise>
                                            </c:choose>
                                            <img class="img-cate shadow-sm" src="${imgUrl}" alt="${cate.categoryname}" />
                                        </td>
                                        <td class="text-start fw-semibold text-dark">
                                            <c:out value="${cate.categoryname}" />
                                        </td>
                                        <td>
                                            <c:if test="${cate.status == 1}">
                                                <span class="badge bg-success">Hoạt động</span>
                                            </c:if>
                                            <c:if test="${cate.status != 1}">
                                                <span class="badge bg-secondary">Khóa</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-primary me-1">
                                                <i class="fa fa-edit"></i> Sửa
                                            </a>
                                            <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                                <i class="fa fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" class="text-muted py-4">Chưa có danh mục nào trong hệ thống!</td>
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
