<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - HCM-UTE Shopping Service</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

<jsp:include page="topbar.jsp" />

<div class="container py-4">
    <div class="p-5 mb-4 bg-white rounded-3 shadow-sm border">
        <div class="container-fluid py-2">
            <h1 class="display-6 fw-bold text-primary">TRƯỜNG ĐẠI HỌC SƯ PHẠM KỸ THUẬT TP.HCM</h1>
            <p class="col-md-10 fs-5 text-muted">
                Bài tập Tuần 1: Kiến trúc 3 tầng và mô hình MVC trong Java Web (Servlet, JDBC &amp; CRUD Category).
            </p>
            <c:choose>
                <c:when test="${sessionScope.account != null}">
                    <div class="alert alert-success">
                        <i class="fa fa-user-check me-2"></i>
                        Chào mừng bạn trở lại, <strong><c:out value="${sessionScope.account.fullName}"/></strong>!
                        (Vai trò:
                        <c:choose>
                            <c:when test="${sessionScope.account.roleid == 1}">Quản Trị Viên / Admin</c:when>
                            <c:when test="${sessionScope.account.roleid == 2}">Quản Lý / Manager</c:when>
                            <c:otherwise>Người Dùng / Member</c:otherwise>
                        </c:choose>)
                    </div>
                    <c:if test="${sessionScope.account.roleid == 1}">
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-warning fw-semibold">
                            📁 Đến Trang Quản Lý Danh Mục (Admin CRUD)
                        </a>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="d-flex gap-2">
                        <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/login">Đăng Nhập Ngay</a>
                        <a class="btn btn-outline-secondary btn-lg" href="${pageContext.request.contextPath}/register">Đăng Ký Tài Khoản</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
