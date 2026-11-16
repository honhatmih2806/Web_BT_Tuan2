<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Tài Khoản - HCM-UTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .card-login { max-width: 440px; margin: 50px auto; border-radius: 14px; box-shadow: 0 10px 25px rgba(0,0,0,0.08); border: none; }
    </style>
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <div class="card card-login p-4 bg-white">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-primary">Đăng Nhập</h3>
            <p class="text-muted small">Hệ thống phân quyền &amp; kiến trúc 3 tầng</p>
        </div>

        <c:if test="${alert != null}">
            <div class="alert alert-danger py-2 small" role="alert">
                <i class="fa fa-exclamation-circle me-1"></i> ${alert}
            </div>
        </c:if>

        <c:if test="${param.success eq 'registered'}">
            <div class="alert alert-success py-2 small" role="alert">
                <i class="fa fa-check-circle me-1"></i> Đăng ký thành công! Hãy đăng nhập ngay.
            </div>
        </c:if>

        <!-- Form gửi POST request về /login -->
        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tài khoản (Username):</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Nhập username" required autofocus />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu (Password):</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Nhập password" required />
                </div>
            </div>

            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" name="remember" id="rememberMe">
                <label class="form-check-label" for="rememberMe">
                    Ghi nhớ đăng nhập (Remember Me)
                </label>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                Đăng Nhập
            </button>
        </form>

        <div class="text-center mt-3 small">
            Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" class="fw-bold">Đăng ký ngay</a>
        </div>

        <div class="mt-4 p-3 bg-light rounded small border">
            <strong class="d-block mb-1 text-secondary">Tài khoản thử nghiệm sẵn có:</strong>
            <div>👑 Admin: <code>admin</code> / <code>123456</code> (Vào trang Admin)</div>
            <div>👔 Manager: <code>manager</code> / <code>123456</code> (Vào trang Manager)</div>
            <div>👤 User: <code>user</code> / <code>123456</code> (Vào trang User)</div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
