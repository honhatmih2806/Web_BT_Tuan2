package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.VideoServiceImpl;

@WebServlet(urlPatterns = { "/video" })
public class VideoUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoService videoService = new VideoServiceImpl();
    private static final int PAGE_SIZE = 6; // Yêu cầu đề bài: phân trang 6 sản phẩm/video mỗi trang

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("account") : null;

        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null) {
            try {
                page = Math.max(1, Integer.parseInt(pageStr));
            } catch (NumberFormatException ignored) {}
        }

        List<Video> videos;
        int totalItems;

        if (currentUser != null) {
            // Hiển thị tất cả video của user hiện tại với phân trang 6 video/trang
            videos = videoService.findByUserId(currentUser.getId(), page, PAGE_SIZE);
            totalItems = videoService.countByUserId(currentUser.getId());
            req.setAttribute("isUserScope", true);
        } else {
            // Nếu chưa đăng nhập, hiển thị tất cả video cộng đồng (phân trang 6sp/trang)
            videos = videoService.findAll(page, PAGE_SIZE);
            totalItems = videoService.count();
            req.setAttribute("isUserScope", false);
        }

        int totalPages = (int) Math.ceil((double) totalItems / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;

        req.setAttribute("videos", videos);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalItems", totalItems);

        req.getRequestDispatcher("/views/video/list.jsp").forward(req, resp);
    }
}
