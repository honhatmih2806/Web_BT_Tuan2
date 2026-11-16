<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục (CRUD Category) - HCM-UTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .img-thumb-cate { width: 90px; height: 70px; object-fit: cover; border-radius: 8px; border: 1px solid #ddd; }
    </style>
</head>
<body class="bg-light">

<jsp:include page="../topbar.jsp" />

<div class="container py-4">
    <div class="card shadow-sm border-0 rounded-3">
        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
            <h4 class="mb-0 text-primary fw-bold">
                <i class="fa fa-list me-2"></i>Danh Sách Danh Mục (Category List)
            </h4>
            <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success fw-semibold">
                <i class="fa fa-plus-circle me-1"></i> Thêm Danh Mục Mới
            </a>
        </div>

        <div class="card-body">
            <!-- Form tìm kiếm danh mục -->
            <form action="${pageContext.request.contextPath}/admin/category/list" method="get" class="row g-2 mb-4">
                <div class="col-md-5">
                    <div class="input-group">
                        <input type="text" class="form-control" name="keyword" placeholder="Tìm kiếm theo tên danh mục..." value="${param.keyword}">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fa fa-search"></i> Tìm kiếm
                        </button>
                    </div>
                </div>
                <c:if test="${not empty param.keyword}">
                    <div class="col-md-2">
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary">
                            Xóa bộ lọc
                        </a>
                    </div>
                </c:if>
            </form>

            <div class="table-responsive">
                <table class="table table-hover table-bordered align-middle text-center">
                    <thead class="table-primary">
                        <tr>
                            <th style="width: 70px;">STT</th>
                            <th style="width: 140px;">Hình Ảnh</th>
                            <th class="text-start">Tên Danh Mục</th>
                            <th style="width: 180px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty cateList}">
                                <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                    <tr>
                                        <td class="fw-bold">${STT.index + 1}</td>
                                        <td>
                                            <c:url value="/image?fname=${cate.icon}" var="imgUrl" />
                                            <img src="${imgUrl}" alt="${cate.name}" class="img-thumb-cate shadow-sm" />
                                        </td>
                                        <td class="text-start fw-semibold text-dark">
                                            <c:out value="${cate.name}" />
                                        </td>
                                        <td>
                                            <c:url value="/admin/category/edit?id=${cate.id}" var="editUrl" />
                                            <c:url value="/admin/category/delete?id=${cate.id}" var="delUrl" />
                                            <a href="${editUrl}" class="btn btn-sm btn-outline-primary me-1">
                                                <i class="fa fa-edit"></i> Sửa
                                            </a>
                                            <a href="${delUrl}" class="btn btn-sm btn-outline-danger" onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục này?');">
                                                <i class="fa fa-trash"></i> Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-muted py-4">Chưa có danh mục nào trong hệ thống!</td>
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
