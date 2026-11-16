<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xác Thực OTP Kích Hoạt Tài Khoản - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #0d6efd 0%, #6610f2 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .auth-card { width: 100%; max-width: 460px; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.25); }
        .otp-input { letter-spacing: 12px; font-size: 26px; font-weight: bold; text-align: center; }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card auth-card mx-auto border-0 p-4">
        <div class="text-center mb-3">
            <div class="rounded-circle bg-primary bg-opacity-10 d-inline-flex p-3 text-primary mb-2">
                <i class="fa fa-envelope-open-text fa-2x"></i>
            </div>
            <h3 class="fw-bold text-dark">Kích Hoạt Tài Khoản</h3>
            <p class="text-muted small">
                Mã xác thực OTP đã được gửi tới email:<br>
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
                <i class="fa fa-key me-1"></i> <strong>Mã OTP vừa sinh:</strong> <span class="badge bg-danger fs-6">${demoOtp}</span>
                <span class="d-block text-muted" style="font-size: 11px;">(Đã gửi email qua SMTP &amp; in ra console server)</span>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post">
            <input type="hidden" name="email" value="${email}">

            <div class="mb-4">
                <label class="form-label fw-semibold text-center d-block">Nhập mã OTP (6 chữ số)</label>
                <input type="text" name="otp" maxlength="6" class="form-control form-control-lg otp-input" placeholder="000000" required autofocus value="${demoOtp}">
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-bold shadow-sm">
                <i class="fa fa-check-circle me-1"></i> Xác Nhận Kích Hoạt
            </button>
        </form>

        <div class="border-top mt-4 pt-3 text-center">
            <a href="${pageContext.request.contextPath}/register" class="small text-muted text-decoration-none">
                <i class="fa fa-redo me-1"></i> Đăng ký lại bằng email khác
            </a>
            <span class="mx-2 text-muted">|</span>
            <a href="${pageContext.request.contextPath}/login" class="small text-primary text-decoration-none">
                Đăng nhập
            </a>
        </div>
    </div>
</div>
</body>
</html>
