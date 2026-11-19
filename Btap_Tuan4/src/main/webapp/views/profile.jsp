<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ Sơ Người Dùng (Profile) - HCMUTE</title>
    <style>
        .profile-avatar-lg { width: 130px; height: 130px; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.15); }
    </style>
</head>
<body>

<div class="container py-4">
    <div class="row justify-content-center">
        <div class="col-lg-8">

            <!-- Thông báo trạng thái -->
            <c:if test="${param.message == 'update_success'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa fa-check-circle me-1"></i> Cập nhật thông tin hồ sơ cá nhân thành công!
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${param.message == 'email_change_success'}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fa fa-check-circle me-1"></i> Xác thực OTP thành công! Email tài khoản của bạn đã được cập nhật chính thức.
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            <c:if test="${not empty emailError}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fa fa-exclamation-triangle me-1"></i> ${emailError}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>

            <div class="card border-0 shadow-sm rounded-4 overflow-hidden mb-4">
                <div class="bg-primary text-white p-4" style="background: linear-gradient(135deg, #0d6efd 0%, #052c65 100%);">
                    <div class="d-flex flex-column flex-md-row align-items-center gap-4">
                        <div class="position-relative">
                            <c:choose>
                                <c:when test="${not empty user.avatar && user.avatar.startsWith('http')}">
                                    <img src="${user.avatar}" alt="Avatar" class="profile-avatar-lg">
                                </c:when>
                                <c:when test="${not empty user.avatar}">
                                    <img src="${pageContext.request.contextPath}/image?fname=${user.avatar}" alt="Avatar" class="profile-avatar-lg">
                                </c:when>
                                <c:otherwise>
                                    <div class="profile-avatar-lg bg-light text-primary d-flex align-items-center justify-content-center fs-1 fw-bold">
                                        <i class="fa fa-user"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                            <c:if test="${not empty user.avatar && user.avatar.contains('cloudinary')}">
                                <span class="badge bg-success position-absolute bottom-0 start-50 translate-middle-x rounded-pill shadow-sm" style="font-size: 11px;">
                                    <i class="fa fa-cloud me-1"></i> Cloudinary
                                </span>
                            </c:if>
                        </div>
                        <div class="text-center text-md-start">
                            <h3 class="fw-bold mb-1">${user.fullname != null ? user.fullname : user.username}</h3>
                            <p class="mb-1 opacity-75"><i class="fa fa-envelope me-1"></i> ${user.email}</p>
                            <div class="d-flex flex-wrap gap-2 justify-content-center justify-content-md-start">
                                <span class="badge bg-light text-dark border">
                                    <i class="fa fa-user-tag me-1 text-primary"></i> ${user.roleid == 1 ? 'Quản Trị Viên (Admin)' : 'Người Dùng (User)'}
                                </span>
                                <span class="badge bg-success bg-opacity-75">
                                    <i class="fa fa-check me-1"></i> Đã Kích Hoạt OTP
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4">
                    <h5 class="fw-bold text-dark mb-3 pb-2 border-bottom">
                        <i class="fa fa-user-cog text-primary me-2"></i>Chỉnh Sửa Thông Tin Cá Nhân
                    </h5>

                    <form action="${pageContext.request.contextPath}/profile/update" method="post" enctype="multipart/form-data" class="needs-validation">
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Tên đăng nhập (Username)</label>
                            <input type="text" class="form-control bg-light" value="${user.username}" readonly>
                            <div class="form-text text-muted small">Tên đăng nhập không thể thay đổi sau khi tạo.</div>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Họ và tên <span class="text-danger">*</span></label>
                            <input type="text" name="fullname" class="form-control ${not empty errors.fullname ? 'is-invalid' : ''}" value="${user.fullname}" required>
                            <c:if test="${not empty errors.fullname}">
                                <div class="invalid-feedback d-block">${errors.fullname}</div>
                            </c:if>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Số điện thoại</label>
                            <input type="text" name="phone" class="form-control ${not empty errors.phone ? 'is-invalid' : ''}" value="${user.phone}" placeholder="Ví dụ: 0901234567">
                            <c:if test="${not empty errors.phone}">
                                <div class="invalid-feedback d-block">${errors.phone}</div>
                            </c:if>
                        </div>

                        <div class="card bg-warning bg-opacity-10 border-warning p-3 mb-3 rounded-3">
                            <label class="form-label fw-bold text-dark mb-1">
                                <i class="fa fa-envelope-open-text me-1 text-warning"></i> Địa chỉ Email tài khoản <span class="text-danger">*</span>
                            </label>
                            <input type="email" name="email" class="form-control ${not empty errors.email ? 'is-invalid' : ''}" value="${user.email}" required>
                            <c:if test="${not empty errors.email}">
                                <div class="invalid-feedback d-block">${errors.email}</div>
                            </c:if>
                            <div class="form-text text-dark fw-semibold small mt-2">
                                <i class="fa fa-info-circle text-primary me-1"></i> Lưu ý quan trọng: Nếu bạn nhập Email mới, hệ thống sẽ tự động gửi mã OTP xác thực tới Email mới đó để bạn xác nhận trước khi cập nhật chính thức.
                            </div>
                        </div>

                        <div class="card bg-light border-0 p-3 mb-4 rounded-3">
                            <label class="form-label fw-bold text-primary mb-1">
                                <i class="fa fa-camera me-1"></i> Cập Nhật Ảnh Đại Diện (Multipart / Cloudinary)
                            </label>
                            <input type="file" name="avatarFile" class="form-control" accept="image/*">
                            <div class="form-text text-muted small mt-1">
                                Hỗ trợ upload ảnh JPG, PNG, GIF. Tự động đồng bộ lên nền tảng đám mây Cloudinary hoặc máy chủ.
                            </div>
                        </div>

                        <div class="d-flex justify-content-end gap-2">
                            <a href="${pageContext.request.contextPath}/home" class="btn btn-outline-secondary">Hủy bỏ</a>
                            <button type="submit" class="btn btn-primary fw-bold px-4">
                                <i class="fa fa-save me-1"></i> Lưu Cập Nhật
                            </button>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>
