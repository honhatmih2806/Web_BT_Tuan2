<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo Tài Khoản Mới - HCM-UTE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { background-color: #f4f7f6; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
        .card-register { max-width: 500px; margin: 40px auto; border-radius: 14px; box-shadow: 0 10px 25px rgba(0,0,0,0.08); border: none; }
    </style>
</head>
<body>

<jsp:include page="topbar.jsp" />

<div class="container">
    <div class="card card-register p-4 bg-white">
        <div class="text-center mb-4">
            <h3 class="fw-bold text-primary">Tạo Tài Khoản Mới</h3>
            <p class="text-muted small">Điền các thông tin bên dưới để đăng ký</p>
        </div>

        <c:if test="${alert != null}">
            <div class="alert alert-danger py-2 small" role="alert">
                <i class="fa fa-exclamation-circle me-1"></i> ${alert}
            </div>
        </c:if>

        <!-- Form gửi POST request về /register -->
        <form action="${pageContext.request.contextPath}/register" method="post">
            <div class="mb-3">
                <label class="form-label fw-semibold">Tài khoản (Username):</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-user"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Tên tài khoản (không dấu)" required />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Mật khẩu (Password):</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Email:</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-envelope"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="email@domain.com" required />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Họ và tên:</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-id-card"></i></span>
                    <input type="text" name="fullname" class="form-control" placeholder="Nguyễn Văn A" required />
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Số điện thoại:</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fa fa-phone"></i></span>
                    <input type="text" name="phone" class="form-control" placeholder="0901234567" />
                </div>
            </div>

            <button type="submit" class="btn btn-primary w-100 py-2 fw-semibold">
                Đăng Ký Tài Khoản
            </button>
        </form>

        <div class="text-center mt-3 small">
            Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" class="fw-bold">Đăng nhập tại đây</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
