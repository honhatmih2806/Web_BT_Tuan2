<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><sitemesh:write property="title">${pageTitle != null ? pageTitle : 'Admin Panel - HCMUTE'}</sitemesh:write></title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { min-height: 100vh; display: flex; flex-direction: column; background-color: #f4f6f9; }
        .admin-main { flex: 1 0 auto; }
        .admin-nav { background: #212529; }
        .admin-brand { font-size: 1.15rem; font-weight: bold; }
    </style>
    
    <sitemesh:write property="head">${pageHead}</sitemesh:write>
</head>
<body>

    <header>
        <nav class="navbar navbar-expand-lg navbar-dark admin-nav shadow-sm py-2">
            <div class="container-fluid px-4">
                <a class="navbar-brand admin-brand text-warning" href="${pageContext.request.contextPath}/admin/videos">
                    <i class="fa fa-shield-alt me-2"></i>HCMUTE Admin Portal (SiteMesh 3)
                </a>
                
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link text-white" href="${pageContext.request.contextPath}/home">
                                <i class="fa fa-arrow-left me-1"></i> Xem Trang Người Dùng
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/admin/videos">
                                <i class="fa fa-film me-1 text-primary"></i> Quản Lý Videos (CRUD)
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white fw-semibold" href="${pageContext.request.contextPath}/admin/categories">
                                <i class="fa fa-th-list me-1 text-success"></i> Quản Lý Categories
                            </a>
                        </li>
                    </ul>

                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item me-3 text-white small">
                            <i class="fa fa-user-circle me-1 text-warning"></i>
                            ${sessionScope.account != null ? sessionScope.account.username : 'Administrator'}
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm">
                                <i class="fa fa-sign-out-alt me-1"></i> Đăng Xuất
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <main class="admin-main py-4">
        <div class="container-fluid px-4">
            <sitemesh:write property="body">${pageBody}</sitemesh:write>
        </div>
    </main>

    <footer class="bg-dark text-muted py-3 mt-auto text-center small border-top">
        HCMUTE Administrator System • Quản lý giao diện bằng SiteMesh Decorator 3 &amp; Bootstrap 5
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
