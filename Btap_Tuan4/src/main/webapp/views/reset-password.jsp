<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lại Mật Khẩu - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #fd7e14 0%, #20c997 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .auth-card { width: 100%; max-width: 460px; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.25); }
        .otp-input { letter-spacing: 8px; font-weight: bold; text-align: center; }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card auth-card mx-auto border-0 p-4">
        <div class="text-center mb-3">
            <h3 class="fw-bold text-dark">Đặt Lại Mật Khẩu</h3>
            <p class="text-muted small">
                Nhập mã OTP đã gửi tới email:<br>
                <strong class="text-primary">${email}</strong>
            </p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small" role="alert">
                <i class="fa fa-exclamation-circle me-1"></i> ${error}
            </div>
        </c:if>

        <c:if test="${not empty demoOtp}">
            <div class="alert alert-warning py-2 small border-warning">
                <i class="fa fa-key me-1"></i> <strong>Mã OTP vừa gửi:</strong> <span class="badge bg-danger fs-6">${demoOtp}</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post">
            <input type="hidden" name="email" value="${email}">

            <div class="mb-3">
                <label class="form-label fw-semibold">Mã OTP (6 số)</label>
                <input type="text" name="otp" maxlength="6" class="form-control otp-input" placeholder="000000" required value="${demoOtp}">
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu mới</label>
                <input type="password" name="newPassword" class="form-control" placeholder="Nhập mật khẩu mới" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Xác nhận mật khẩu mới</label>
                <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
            </div>

            <button type="submit" class="btn btn-success w-100 py-2 fw-bold shadow-sm">
                <i class="fa fa-check me-1"></i> Cập Nhật Mật Khẩu Mới
            </button>
        </form>

        <div class="border-top mt-4 pt-3 text-center">
            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none small text-secondary">
                <i class="fa fa-arrow-left me-1"></i> Hủy &amp; Quay lại Đăng nhập
            </a>
        </div>
    </div>
</div>
</body>
</html>
