<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - HCM-UTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

<jsp:include page="../topbar.jsp" />

<div class="container py-4">
    <div class="row">
        <div class="col-12">
            <div class="p-4 bg-white rounded shadow-sm border mb-4">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <h2 class="text-danger fw-bold"><i class="fa fa-shield-alt me-2"></i>Bảng Điều Khiển Quản Trị (Admin Dashboard)</h2>
                        <p class="text-muted mb-0">Xin chào quản trị viên: <strong>${sessionScope.account.fullName}</strong> (${sessionScope.account.email})</p>
                    </div>
                    <span class="badge bg-danger fs-6 p-2">Role ID = 1 (ADMIN)</span>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-4">
            <div class="card h-100 shadow-sm border">
                <div class="card-body">
                    <h5 class="card-title text-primary"><i class="fa fa-folder-open me-2"></i>Quản Lý Danh Mục (CRUD Category)</h5>
                    <p class="card-text text-muted">
                        Chức năng theo tài liệu <code>14_HD_Servlet_JDBC_CRUD.pdf</code>: Hiển thị danh sách, thêm danh mục mới, chỉnh sửa và xóa danh mục với ảnh đại diện.
                    </p>
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-primary">
                        Đi tới danh sách Danh Mục &rarr;
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-success ms-2">
                        + Thêm Mới
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-4">
            <div class="card h-100 shadow-sm border">
                <div class="card-body">
                    <h5 class="card-title text-success"><i class="fa fa-users me-2"></i>Phân Quyền &amp; Điều Hướng (/waiting)</h5>
                    <p class="card-text text-muted">
                        Hệ thống tự động nhận diện <code>roleid == 1</code> khi đăng nhập và điều hướng chính xác vào trang quản trị Admin.
                    </p>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger">
                        Đăng Xuất
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
