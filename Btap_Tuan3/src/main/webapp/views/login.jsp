<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập - HCMUTE Video Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #0d6efd 0%, #002752 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .auth-card { width: 100%; max-width: 440px; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.25); }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card auth-card mx-auto border-0 p-4">
        <div class="text-center mb-4">
            <span class="badge bg-primary px-3 py-2 fs-6 rounded-pill mb-2">🎓 HCMUTE WEB PR330479</span>
            <h3 class="fw-bold text-dark mt-2">Đăng Nhập</h3>
            <p class="text-muted small">Hệ thống Quản lý Video & Xác thực OTP</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                <i class="fa fa-exclamation-circle me-1"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <c:if test="${param.message == 'activate_success'}">
            <div class="alert alert-success py-2">
                <i class="fa fa-check-circle me-1"></i> Tài khoản đã được kích hoạt thành công! Vui lòng đăng nhập.
            </div>
        </c:if>
        <c:if test="${param.message == 'reset_password_success'}">
            <div class="alert alert-success py-2">
                <i class="fa fa-check-circle me-1"></i> Đặt lại mật khẩu thành công! Vui lòng đăng nhập với mật khẩu mới.
            </div>
        </c:if>
        <c:if test="${param.message == 'logout_success'}">
            <div class="alert alert-info py-2">
                <i class="fa fa-info-circle me-1"></i> Bạn đã đăng xuất khỏi hệ thống an toàn.
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập hoặc Email</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-user text-muted"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Nhập username hoặc email" value="${username}" required autofocus>
                </div>
            </div>

            <div class="mb-3">
                <div class="d-flex justify-content-between align-items-center">
                    <label class="form-label fw-semibold mb-0">Mật khẩu</label>
                    <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none text-primary">Quên mật khẩu?</a>
                </div>
                <div class="input-group mt-1">
                    <span class="input-group-text"><i class="fa fa-lock text-muted"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                </div>
                <div class="form-text text-muted small">Mật khẩu được mã hóa an toàn với BCrypt.</div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                <i class="fa fa-sign-in-alt me-1"></i> Đăng Nhập
            </button>
        </form>

        <div class="border-top mt-4 pt-3 text-center">
            <p class="mb-1 text-muted small">Chưa có tài khoản?</p>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-success btn-sm fw-semibold">
                <i class="fa fa-user-plus me-1"></i> Đăng ký tài khoản mới (Xác thực OTP)
            </a>
        </div>

        <div class="mt-3 text-center">
            <a href="${pageContext.request.contextPath}/home" class="text-secondary small text-decoration-none">
                <i class="fa fa-arrow-left me-1"></i> Quay về Trang chủ
            </a>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
