package vn.iotstar.controller;

import java.io.IOException;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.EmailService;
import vn.iotstar.util.FormValidator;

@WebServlet(urlPatterns = {
    "/login",
    "/logout",
    "/register",
    "/verify-otp",
    "/forgot-password",
    "/reset-password"
})
public class AuthController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        switch (path) {
            case "/login":
                req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
                break;

            case "/logout":
                HttpSession session = req.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                resp.sendRedirect(req.getContextPath() + "/login?message=logout_success");
                break;

            case "/register":
                req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
                break;

            case "/verify-otp":
                String emailVerify = req.getParameter("email");
                req.setAttribute("email", emailVerify);
                req.setAttribute("demoOtp", EmailService.getLatestOtp(emailVerify));
                req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
                break;

            case "/forgot-password":
                req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
                break;

            case "/reset-password":
                String emailReset = req.getParameter("email");
                req.setAttribute("email", emailReset);
                req.setAttribute("demoOtp", EmailService.getLatestOtp(emailReset));
                req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        switch (path) {
            case "/login":
                handleLogin(req, resp);
                break;

            case "/register":
                handleRegister(req, resp);
                break;

            case "/verify-otp":
                handleVerifyOtp(req, resp);
                break;

            case "/forgot-password":
                handleForgotPassword(req, resp);
                break;

            case "/reset-password":
                handleResetPassword(req, resp);
                break;

            default:
                resp.sendRedirect(req.getContextPath() + "/login");
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Form Validation Login
        Map<String, String> errors = FormValidator.validateLogin(username, password);
        if (!errors.isEmpty()) {
            req.setAttribute("fieldErrors", errors);
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
            return;
        }

        try {
            User user = userService.login(username, password);
            HttpSession session = req.getSession(true);
            session.setAttribute("account", user);

            if (user.getRoleid() == 1) {
                resp.sendRedirect(req.getContextPath() + "/admin/videos");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("username", username);
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");

        // Form Validation Register
        Map<String, String> errors = FormValidator.validateRegister(username, email, password, fullname, phone);
        if (!errors.isEmpty()) {
            req.setAttribute("fieldErrors", errors);
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setFullname(fullname != null ? fullname.trim() : username);
        user.setPassword(password);
        user.setPhone(phone);
        user.setRoleid(3);

        boolean success = userService.register(user);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/verify-otp?email=" + email.trim() + "&sent=true");
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc Email đã tồn tại trong hệ thống!");
            req.setAttribute("username", username);
            req.setAttribute("email", email);
            req.setAttribute("fullname", fullname);
            req.setAttribute("phone", phone);
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }

    private void handleVerifyOtp(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");

        if (otp == null || otp.trim().length() != 6) {
            req.setAttribute("email", email);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(email));
            req.setAttribute("error", "Mã OTP phải gồm đúng 6 chữ số!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
            return;
        }

        boolean activated = userService.activateAccount(email, otp);
        if (activated) {
            resp.sendRedirect(req.getContextPath() + "/login?message=activate_success");
        } else {
            req.setAttribute("email", email);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(email));
            req.setAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
            req.getRequestDispatcher("/views/verify-otp.jsp").forward(req, resp);
        }
    }

    private void handleForgotPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");

        // Form Validation Forgot Password
        Map<String, String> errors = FormValidator.validateForgotPassword(email);
        if (!errors.isEmpty()) {
            req.setAttribute("fieldErrors", errors);
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
            return;
        }

        boolean sent = userService.forgotPassword(email);
        if (sent) {
            resp.sendRedirect(req.getContextPath() + "/reset-password?email=" + email.trim() + "&sent=true");
        } else {
            req.setAttribute("error", "Email không tồn tại trong hệ thống!");
            req.setAttribute("email", email);
            req.getRequestDispatcher("/views/forgot-password.jsp").forward(req, resp);
        }
    }

    private void handleResetPassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String otp = req.getParameter("otp");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        if (otp == null || otp.trim().length() != 6) {
            req.setAttribute("email", email);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(email));
            req.setAttribute("error", "Mã OTP phải gồm đúng 6 chữ số!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (newPassword == null || newPassword.length() < 6) {
            req.setAttribute("email", email);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(email));
            req.setAttribute("error", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("email", email);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(email));
            req.setAttribute("error", "Mật khẩu xác nhận không khớp!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
            return;
        }

        boolean success = userService.resetPassword(email, otp, newPassword);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/login?message=reset_password_success");
        } else {
            req.setAttribute("email", email);
            req.setAttribute("demoOtp", EmailService.getLatestOtp(email));
            req.setAttribute("error", "Mã OTP không hợp lệ!");
            req.getRequestDispatcher("/views/reset-password.jsp").forward(req, resp);
        }
    }
}
