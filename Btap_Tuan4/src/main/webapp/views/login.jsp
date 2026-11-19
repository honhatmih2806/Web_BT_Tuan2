<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - HCMUTE</title>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm border-0 rounded-4 p-4">
                <div class="text-center mb-4">
                    <span class="badge bg-primary px-3 py-2 fs-6 rounded-pill mb-2">🎓 HCMUTE WEB PR330479</span>
                    <h3 class="fw-bold text-dark mt-2">Đăng Nhập</h3>
                    <p class="text-muted small">Cấu hình Sitemesh 3 &amp; Validation Form</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show py-2" role="alert">
                        <i class="fa fa-exclamation-circle me-1"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${param.message == 'activate_success'}">
                    <div class="alert alert-success py-2 small">
                        <i class="fa fa-check-circle me-1"></i> Tài khoản đã được kích hoạt thành công! Vui lòng đăng nhập.
                    </div>
                </c:if>
                <c:if test="${param.message == 'reset_password_success'}">
                    <div class="alert alert-success py-2 small">
                        <i class="fa fa-check-circle me-1"></i> Đặt lại mật khẩu thành công!
                    </div>
                </c:if>
                <c:if test="${param.message == 'logout_success'}">
                    <div class="alert alert-info py-2 small">
                        <i class="fa fa-info-circle me-1"></i> Đã đăng xuất khỏi hệ thống an toàn.
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên đăng nhập hoặc Email <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-user text-muted"></i></span>
                            <input type="text" name="username" class="form-control ${not empty fieldErrors.username ? 'is-invalid' : ''}" 
                                   placeholder="Nhập username hoặc email" value="${username}" required autofocus>
                        </div>
                        <c:if test="${not empty fieldErrors.username}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.username}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between align-items-center">
                            <label class="form-label fw-semibold mb-0">Mật khẩu <span class="text-danger">*</span></label>
                            <a href="${pageContext.request.contextPath}/forgot-password" class="small text-decoration-none text-primary">Quên mật khẩu?</a>
                        </div>
                        <div class="input-group mt-1">
                            <span class="input-group-text"><i class="fa fa-lock text-muted"></i></span>
                            <input type="password" name="password" class="form-control ${not empty fieldErrors.password ? 'is-invalid' : ''}" 
                                   placeholder="Nhập mật khẩu" required minlength="6">
                        </div>
                        <c:if test="${not empty fieldErrors.password}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.password}</div>
                        </c:if>
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
            </div>
        </div>
    </div>
</div>

</body>
</html>
