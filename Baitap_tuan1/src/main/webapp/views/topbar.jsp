<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/home">
            🎓 HCM-UTE Shopping Service
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/home">Trang Chủ</a>
                </li>
                <c:if test="${sessionScope.account != null && sessionScope.account.roleid == 1}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/home">Admin Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-warning fw-semibold" href="${pageContext.request.contextPath}/admin/category/list">
                            📁 Quản Lý Danh Mục (CRUD)
                        </a>
                    </li>
                </c:if>
            </ul>

            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center">
                <c:choose>
                    <c:when test="${sessionScope.account == null}">
                        <li class="nav-item">
                            <a class="btn btn-outline-light me-2 btn-sm" href="${pageContext.request.contextPath}/login">Đăng Nhập</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-light text-primary btn-sm fw-semibold" href="${pageContext.request.contextPath}/register">Đăng Ký</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item me-3 text-white">
                            <span>Xin chào, <strong><c:out value="${sessionScope.account.fullName}"/></strong></span>
                            <span class="badge bg-warning text-dark ms-1">
                                <c:choose>
                                    <c:when test="${sessionScope.account.roleid == 1}">Admin</c:when>
                                    <c:when test="${sessionScope.account.roleid == 2}">Manager</c:when>
                                    <c:otherwise>Member</c:otherwise>
                                </c:choose>
                            </span>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/logout">Đăng Xuất</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
