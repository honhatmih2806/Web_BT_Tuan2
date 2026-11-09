package vn.edu.hcmute.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import vn.edu.hcmute.models.UserModel;
import vn.edu.hcmute.services.UserService;
import vn.edu.hcmute.services.impl.UserServiceImpl;

@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // Hiển thị giao diện đăng nhập login.jsp
        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        // Lấy thông tin từ form
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        // Gọi tầng Service để xử lý kiểm tra đăng nhập
        UserModel user = userService.login(username, password);

        if (user != null) {
            // Đăng nhập thành công -> lưu session và chuyển hướng vào url (/home)
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            // Đăng nhập thất bại -> chuyển hướng vào url (/error)
            resp.sendRedirect(req.getContextPath() + "/error");
        }
    }
}
