package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.VideoServiceImpl;

@WebServlet(urlPatterns = { "/video/detail" })
public class VideoDetailController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoService videoService = new VideoServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("id");
        if (videoId == null || videoId.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Tăng lượt xem cho video
        videoService.increaseViews(videoId.trim());

        // Lấy thông tin chi tiết video
        Video video = videoService.findById(videoId.trim());
        if (video == null) {
            resp.sendRedirect(req.getContextPath() + "/home?error=video_not_found");
            return;
        }

        // Lấy danh sách video đề xuất (top videos)
        List<Video> relatedVideos = videoService.findTop10Latest();

        req.setAttribute("video", video);
        req.setAttribute("relatedVideos", relatedVideos);
        req.getRequestDispatcher("/views/video/detail.jsp").forward(req, resp);
    }
}
