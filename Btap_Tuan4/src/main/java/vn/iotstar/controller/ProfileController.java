package vn.iotstar.controller;

import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.CloudinaryService;
import vn.iotstar.util.EmailService;
import vn.iotstar.util.FormValidator;

@WebServlet(urlPatterns = {
    "/profile",
    "/profile/update",
    "/profile/verify-email-otp"
})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 20    // 20MB
)
public class ProfileController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=please_login");
            return;
        }

        String path = req.getServletPath();

        if ("/profile/verify-email-otp".equals(path)) {
            String pendingEmail = (String) session.getAttribute("pendingNewEmail");
            req.setAttribute("pendingEmail", pendingEmail);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(pendingEmail));
            req.getRequestDispatcher("/views/profile-verify-otp.jsp").forward(req, resp);
            return;
        }

        // Tải lại thông tin mới nhất từ CSDL
        User freshUser = userService.findById(currentUser.getId());
        if (freshUser != null) {
            session.setAttribute("account", freshUser);
            req.setAttribute("user", freshUser);
        } else {
            req.setAttribute("user", currentUser);
        }

        req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();

        if ("/profile/verify-email-otp".equals(path)) {
            handleVerifyEmailOtp(req, resp, session, currentUser);
        } else {
            handleUpdateProfile(req, resp, session, currentUser);
        }
    }

    private void handleUpdateProfile(HttpServletRequest req, HttpServletResponse resp, HttpSession session, User currentUser)
            throws ServletException, IOException {
        
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");
        String newEmail = req.getParameter("email");

        // 1. Validation Form Cập nhật Profile
        Map<String, String> errors = FormValidator.validateProfile(fullname, phone, newEmail);
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("user", currentUser);
            req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
            return;
        }

        User userInDb = userService.findById(currentUser.getId());
        if (userInDb == null) {
            userInDb = currentUser;
        }

        userInDb.setFullname(fullname.trim());
        userInDb.setPhone(phone != null ? phone.trim() : null);

        // 2. Upload Avatar lên Cloudinary bằng Multipart
        try {
            Part avatarPart = req.getPart("avatarFile");
            if (avatarPart != null && avatarPart.getSize() > 0) {
                String uploadedUrl = CloudinaryService.uploadFile(avatarPart);
                if (uploadedUrl != null) {
                    userInDb.setAvatar(uploadedUrl);
                }
            }
        } catch (Exception e) {
            System.err.println("Lỗi upload avatar: " + e.getMessage());
        }

        // 3. Xử lý đổi Email -> Bắt buộc gửi mã OTP đến Email mới để xác nhận
        String currentEmail = userInDb.getEmail();
        newEmail = newEmail.trim().toLowerCase();

        if (!newEmail.equalsIgnoreCase(currentEmail)) {
            // Kiểm tra email mới có bị trùng với user khác không
            User existing = userService.findByEmail(newEmail);
            if (existing != null && existing.getId() != userInDb.getId()) {
                req.setAttribute("emailError", "Email này đã được sử dụng bởi một tài khoản khác!");
                req.setAttribute("user", userInDb);
                req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
                return;
            }

            // Sinh mã OTP 6 số
            String otp = EmailService.generateOtp();
            userInDb.setCode(otp);
            userService.update(userInDb);

            // Lưu email mới vào session chờ xác nhận OTP
            session.setAttribute("pendingNewEmail", newEmail);
            session.setAttribute("account", userInDb);

            // Gửi OTP đến email mới
            EmailService.sendOtpEmail(newEmail, otp, "Mã xác thực đổi Email tài khoản HCMUTE", "Xác nhận cập nhật Email mới");

            // Chuyển hướng đến màn hình nhập OTP xác thực email mới
            resp.sendRedirect(req.getContextPath() + "/profile/verify-email-otp?email=" + newEmail + "&sent=true");
            return;
        }

        // Nếu không đổi email, cập nhật thẳng và hoàn tất
        userService.update(userInDb);
        session.setAttribute("account", userInDb);
        resp.sendRedirect(req.getContextPath() + "/profile?message=update_success");
    }

    private void handleVerifyEmailOtp(HttpServletRequest req, HttpServletResponse resp, HttpSession session, User currentUser)
            throws ServletException, IOException {
        
        String enteredOtp = req.getParameter("otp");
        String pendingEmail = (String) session.getAttribute("pendingNewEmail");

        if (pendingEmail == null) {
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        User userInDb = userService.findById(currentUser.getId());
        if (userInDb == null) {
            userInDb = currentUser;
        }

        // So khớp mã OTP
        if (enteredOtp != null && enteredOtp.trim().equals(userInDb.getCode())) {
            // Xác nhận thành công -> Cập nhật email mới chính thức vào CSDL
            userInDb.setEmail(pendingEmail);
            userInDb.setCode(null); // Xóa mã OTP
            userService.update(userInDb);

            session.removeAttribute("pendingNewEmail");
            session.setAttribute("account", userInDb);

            resp.sendRedirect(req.getContextPath() + "/profile?message=email_change_success");
        } else {
            req.setAttribute("pendingEmail", pendingEmail);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(pendingEmail));
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn! Vui lòng thử lại.");
            req.getRequestDispatcher("/views/profile-verify-otp.jsp").forward(req, resp);
        }
    }
}
