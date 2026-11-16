<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard - HCM-UTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-light">

<jsp:include page="../topbar.jsp" />

<div class="container py-4">
    <div class="p-4 bg-white rounded shadow-sm border mb-4">
        <div class="d-flex align-items-center justify-content-between">
            <div>
                <h2 class="text-primary fw-bold"><i class="fa fa-briefcase me-2"></i>Bảng Điều Khiển Quản Lý (Manager Dashboard)</h2>
                <p class="text-muted mb-0">Xin chào quản lý: <strong>${sessionScope.account.fullName}</strong> (${sessionScope.account.email})</p>
            </div>
            <span class="badge bg-primary fs-6 p-2">Role ID = 2 (MANAGER)</span>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
