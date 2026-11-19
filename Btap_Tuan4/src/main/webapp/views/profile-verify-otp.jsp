<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Xác Thực OTP Đổi Email - HCMUTE</title>
    <style>
        .otp-input { letter-spacing: 12px; font-size: 26px; font-weight: bold; text-align: center; }
    </style>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0 rounded-4 p-4">
                <div class="text-center mb-4">
                    <div class="rounded-circle bg-warning bg-opacity-10 d-inline-flex p-3 text-warning mb-2">
                        <i class="fa fa-envelope-circle-check fa-2x"></i>
                    </div>
                    <h4 class="fw-bold text-dark">Xác Thực Đổi Email</h4>
                    <p class="text-muted small">
                        Hệ thống đã gửi mã OTP xác nhận tới Email mới:<br>
                        <strong class="text-primary fs-6">${pendingEmail}</strong>
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
                        <div class="text-muted" style="font-size: 11px;">(Đã gửi email qua SMTP &amp; in console máy chủ)</div>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/profile/verify-email-otp" method="post">
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-center d-block">Nhập mã OTP 6 số để hoàn tất đổi Email</label>
                        <input type="text" name="otp" maxlength="6" class="form-control form-control-lg otp-input" placeholder="000000" required autofocus value="${demoOtp}">
                    </div>

                    <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark shadow-sm">
                        <i class="fa fa-check-circle me-1"></i> Xác Nhận Đổi Email
                    </button>
                </form>

                <div class="border-top mt-4 pt-3 text-center">
                    <a href="${pageContext.request.contextPath}/profile" class="text-decoration-none small text-secondary">
                        <i class="fa fa-arrow-left me-1"></i> Hủy bỏ &amp; Quay lại Hồ sơ
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
