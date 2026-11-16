<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên Mật Khẩu - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #fd7e14 0%, #d63384 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .auth-card { width: 100%; max-width: 440px; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.25); }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card auth-card mx-auto border-0 p-4">
        <div class="text-center mb-3">
            <div class="rounded-circle bg-warning bg-opacity-25 d-inline-flex p-3 text-warning mb-2">
                <i class="fa fa-unlock-alt fa-2x text-dark"></i>
            </div>
            <h3 class="fw-bold text-dark">Quên Mật Khẩu</h3>
            <p class="text-muted small">Nhập email của bạn để nhận mã xác nhận OTP đặt lại mật khẩu</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small" role="alert">
                <i class="fa fa-exclamation-circle me-1"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Email tài khoản</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-envelope text-muted"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="nhapemail@domain.com" required autofocus>
                </div>
            </div>

            <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark shadow-sm">
                <i class="fa fa-paper-plane me-1"></i> Gửi Mã OTP Qua Mail
            </button>
        </form>

        <div class="border-top mt-4 pt-3 text-center">
            <a href="${pageContext.request.contextPath}/login" class="text-decoration-none small text-secondary">
                <i class="fa fa-arrow-left me-1"></i> Quay lại Đăng nhập
            </a>
        </div>
    </div>
</div>
</body>
</html>
