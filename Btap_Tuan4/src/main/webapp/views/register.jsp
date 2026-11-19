<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Ký Tài Khoản - HCMUTE</title>
</head>
<body>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-sm border-0 rounded-4 p-4">
                <div class="text-center mb-3">
                    <span class="badge bg-success px-3 py-2 fs-6 rounded-pill mb-2">🎓 HCMUTE WEB PR330479</span>
                    <h3 class="fw-bold text-dark mt-2">Đăng Ký Tài Khoản</h3>
                    <p class="text-muted small">Cấu hình Sitemesh 3 &amp; Validation Form Chặt Chẽ</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger py-2 small" role="alert">
                        <i class="fa fa-exclamation-circle me-1"></i> ${error}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation">
                    <div class="mb-3">
                        <label class="form-label fw-semibold">Tên đăng nhập (Username) <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-user text-muted"></i></span>
                            <input type="text" name="username" class="form-control ${not empty fieldErrors.username ? 'is-invalid' : ''}" 
                                   placeholder="Ví dụ: nhatminh2806" value="${username}" required minlength="3">
                        </div>
                        <c:if test="${not empty fieldErrors.username}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.username}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Email nhận OTP <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-envelope text-muted"></i></span>
                            <input type="email" name="email" class="form-control ${not empty fieldErrors.email ? 'is-invalid' : ''}" 
                                   placeholder="Ví dụ: honhatmih2806@gmail.com" value="${email}" required>
                        </div>
                        <c:if test="${not empty fieldErrors.email}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.email}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Họ và tên</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-id-card text-muted"></i></span>
                            <input type="text" name="fullname" class="form-control ${not empty fieldErrors.fullname ? 'is-invalid' : ''}" 
                                   placeholder="Hồ Nhật Minh" value="${fullname}">
                        </div>
                        <c:if test="${not empty fieldErrors.fullname}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.fullname}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Số điện thoại</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-phone text-muted"></i></span>
                            <input type="text" name="phone" class="form-control ${not empty fieldErrors.phone ? 'is-invalid' : ''}" 
                                   placeholder="0901234567" value="${phone}">
                        </div>
                        <c:if test="${not empty fieldErrors.phone}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.phone}</div>
                        </c:if>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold">Mật khẩu <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fa fa-lock text-muted"></i></span>
                            <input type="password" name="password" class="form-control ${not empty fieldErrors.password ? 'is-invalid' : ''}" 
                                   placeholder="Mật khẩu ít nhất 6 ký tự" required minlength="6">
                        </div>
                        <c:if test="${not empty fieldErrors.password}">
                            <div class="text-danger small mt-1"><i class="fa fa-times-circle me-1"></i>${fieldErrors.password}</div>
                        </c:if>
                        <div class="form-text small text-muted">Mật khẩu được băm bảo mật bằng thuật toán BCrypt.</div>
                    </div>

                    <button type="submit" class="btn btn-success w-100 py-2 fw-bold shadow-sm mt-2">
                        <i class="fa fa-paper-plane me-1"></i> Đăng Ký &amp; Nhận Mã OTP
                    </button>
                </form>

                <div class="border-top mt-4 pt-3 text-center">
                    <span class="text-muted small">Đã có tài khoản? </span>
                    <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-decoration-none">Đăng nhập ngay</a>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
