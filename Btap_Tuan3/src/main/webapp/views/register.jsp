<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Tài Khoản - HCMUTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background: linear-gradient(135deg, #198754 0%, #055160 100%); min-height: 100vh; display: flex; align-items: center; justify-content: center; }
        .auth-card { width: 100%; max-width: 480px; border-radius: 16px; box-shadow: 0 15px 35px rgba(0,0,0,0.25); }
    </style>
</head>
<body>
<div class="container py-4">
    <div class="card auth-card mx-auto border-0 p-4">
        <div class="text-center mb-3">
            <span class="badge bg-success px-3 py-2 fs-6 rounded-pill mb-2">🎓 HCMUTE WEB PR330479</span>
            <h3 class="fw-bold text-dark mt-2">Đăng Ký Tài Khoản</h3>
            <p class="text-muted small">Hệ thống sẽ gửi mã OTP qua email để kích hoạt tài khoản</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger py-2 small" role="alert">
                <i class="fa fa-exclamation-circle me-1"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tên đăng nhập <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-user text-muted"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Ví dụ: nhatminh2806" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Email nhận OTP <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-envelope text-muted"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="Ví dụ: honhatmih2806@gmail.com" required>
                </div>
                <div class="form-text small text-muted">Mã kích hoạt 6 chữ số sẽ được gửi tới email này.</div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Họ và tên</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-id-card text-muted"></i></span>
                    <input type="text" name="fullname" class="form-control" placeholder="Hồ Nhật Minh">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Số điện thoại</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-phone text-muted"></i></span>
                    <input type="text" name="phone" class="form-control" placeholder="0901234567">
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-lock text-muted"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu an toàn" required>
                </div>
                <div class="form-text small text-muted">Mật khẩu được băm bảo mật bằng thuật toán BCrypt.</div>
            </div>

            <button type="submit" class="btn btn-success w-100 py-2 fw-bold shadow-sm mt-2">
                <i class="fa fa-paper-plane me-1"></i> Đăng Ký &amp; Nhận Mã OTP
            </button>
        </form>

        <div class="border-top mt-4 pt-3 text-center">
            <span class="text-muted small">Đã có tài khoản? </span>
            <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none">Đăng nhập</a>
        </div>
    </div>
</div>
</body>
</html>
