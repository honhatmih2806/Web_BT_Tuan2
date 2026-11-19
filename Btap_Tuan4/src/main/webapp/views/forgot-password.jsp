<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quên Mật Khẩu - HCMUTE</title>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow-sm border-0 rounded-4 p-4">
                <div class="text-center mb-3">
                    <div class="rounded-circle bg-warning bg-opacity-25 d-inline-flex p-3 text-warning mb-2">
                        <i class="fa fa-unlock-alt fa-2x text-dark"></i>
                    </div>
                    <h4 class="fw-bold text-dark">Quên Mật Khẩu</h4>
                    <p class="text-muted small">Nhập email tài khoản để nhận mã OTP đặt lại mật khẩu</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small" role="alert">
                        <i class="fa fa-exclamation-circle me-1"></i> ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/forgot-password" method="post" class="needs-validation">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email tài khoản <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-envelope text-muted"></i></span>
                            <input type="email" name="email" class="form-control ${not empty fieldErrors.email ? 'is-invalid' : ''}" 
                                   placeholder="nhapemail@domain.com" value="${email}" required autofocus>
                        </div>
                        <c:if test="${not empty fieldErrors.email}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.email}</div>
                        </c:if>
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
    </div>
</div>

</body>
</html>
