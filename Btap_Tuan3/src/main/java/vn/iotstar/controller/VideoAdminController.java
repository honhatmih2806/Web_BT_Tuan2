package vn.iotstar.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.service.impl.VideoServiceImpl;
import vn.iotstar.util.constants;

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 50,      // 50MB
    maxRequestSize = 1024 * 1024 * 100   // 100MB
)
@WebServlet(urlPatterns = {
    "/admin/videos",
    "/admin/video/add",
    "/admin/video/insert",
    "/admin/video/edit",
    "/admin/video/update",
    "/admin/video/delete"
})
public class VideoAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final IVideoService videoService = new VideoServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();
    private final IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();

        if (url.contains("/admin/videos")) {
            List<Video> list = videoService.findAll();
            req.setAttribute("videos", list);
            req.getRequestDispatcher("/views/admin/video-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/add")) {
            req.setAttribute("categories", categoryService.findAll());
            req.setAttribute("users", userService.findAll());
            req.getRequestDispatcher("/views/admin/video-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/edit")) {
            String id = req.getParameter("id");
            Video video = videoService.findById(id);
            req.setAttribute("video", video);
            req.setAttribute("categories", categoryService.findAll());
            req.setAttribute("users", userService.findAll());
            req.getRequestDispatcher("/views/admin/video-edit.jsp").forward(req, resp);
        } else if (url.contains("/admin/video/delete")) {
            String id = req.getParameter("id");
            try {
                videoService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/videos");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        String url = req.getRequestURI();

        if (url.contains("/admin/video/insert")) {
            handleInsert(req, resp);
        } else if (url.contains("/admin/video/update")) {
            handleUpdate(req, resp);
        }
    }

    private void handleInsert(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("videoId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String videoUrl = req.getParameter("videoUrl");
        String activeStr = req.getParameter("active");
        int active = "1".equals(activeStr) ? 1 : 0;

        String categoryIdStr = req.getParameter("categoryId");
        String userIdStr = req.getParameter("userId");

        if (videoId == null || videoId.trim().isEmpty()) {
            videoId = "VID" + System.currentTimeMillis();
        }

        Video video = new Video();
        video.setVideoId(videoId.trim());
        video.setTitle(title);
        video.setDescription(description);
        video.setActive(active);
        video.setViews(0);

        // Xử lý Upload Poster
        String posterFileName = handleUploadPart(req, "posterFile");
        if (posterFileName != null && !posterFileName.isEmpty()) {
            video.setPoster(posterFileName);
        } else {
            String posterUrl = req.getParameter("posterUrl");
            video.setPoster(posterUrl != null && !posterUrl.trim().isEmpty() ? posterUrl : "https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&auto=format&fit=crop&q=80");
        }

        // Xử lý Upload Video hoặc nhập Video URL
        String videoUploadedFile = handleUploadPart(req, "uploadVideoFile");
        if (videoUploadedFile != null && !videoUploadedFile.isEmpty()) {
            video.setVideoUrl(videoUploadedFile);
        } else if (videoUrl != null && !videoUrl.trim().isEmpty()) {
            video.setVideoUrl(videoUrl.trim());
        } else {
            video.setVideoUrl("https://www.w3schools.com/html/mov_bbb.mp4");
        }

        // Liên kết Category
        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                Category c = categoryService.findById(Integer.parseInt(categoryIdStr));
                video.setCategory(c);
            } catch (Exception ignored) {}
        }

        // Liên kết User (1 - n)
        HttpSession session = req.getSession(false);
        User sessionUser = (session != null) ? (User) session.getAttribute("account") : null;
        if (userIdStr != null && !userIdStr.isEmpty()) {
            try {
                User u = userService.findById(Integer.parseInt(userIdStr));
                video.setUser(u);
            } catch (Exception ignored) {}
        } else if (sessionUser != null) {
            video.setUser(sessionUser);
        } else {
            // Gán cho user mặc định nếu có
            User defaultUser = userService.findByUsername("nhatminh");
            video.setUser(defaultUser);
        }

        videoService.insert(video);
        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String videoId = req.getParameter("videoId");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String videoUrl = req.getParameter("videoUrl");
        String activeStr = req.getParameter("active");
        int active = "1".equals(activeStr) ? 1 : 0;

        String categoryIdStr = req.getParameter("categoryId");
        String userIdStr = req.getParameter("userId");

        Video video = videoService.findById(videoId);
        if (video != null) {
            video.setTitle(title);
            video.setDescription(description);
            video.setActive(active);

            // Upload Poster mới nếu có
            String posterFileName = handleUploadPart(req, "posterFile");
            if (posterFileName != null && !posterFileName.isEmpty()) {
                video.setPoster(posterFileName);
            } else {
                String posterUrl = req.getParameter("posterUrl");
                if (posterUrl != null && !posterUrl.trim().isEmpty()) {
                    video.setPoster(posterUrl.trim());
                }
            }

            // Upload Video mới nếu có
            String videoUploadedFile = handleUploadPart(req, "uploadVideoFile");
            if (videoUploadedFile != null && !videoUploadedFile.isEmpty()) {
                video.setVideoUrl(videoUploadedFile);
            } else if (videoUrl != null && !videoUrl.trim().isEmpty()) {
                video.setVideoUrl(videoUrl.trim());
            }

            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                try {
                    Category c = categoryService.findById(Integer.parseInt(categoryIdStr));
                    video.setCategory(c);
                } catch (Exception ignored) {}
            }

            if (userIdStr != null && !userIdStr.isEmpty()) {
                try {
                    User u = userService.findById(Integer.parseInt(userIdStr));
                    video.setUser(u);
                } catch (Exception ignored) {}
            }

            videoService.update(video);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/videos");
    }

    private String handleUploadPart(HttpServletRequest req, String partName) {
        try {
            Part part = req.getPart(partName);
            if (part != null && part.getSize() > 0) {
                String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                if (submittedFileName != null && !submittedFileName.isEmpty()) {
                    String ext = "";
                    int i = submittedFileName.lastIndexOf('.');
                    if (i >= 0) {
                        ext = submittedFileName.substring(i);
                    }
                    String savedFileName = System.currentTimeMillis() + ext;
                    String uploadPath = constants.UPLOAD_DIRECTORY;
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    part.write(uploadPath + File.separator + savedFileName);
                    return savedFileName;
                }
            }
        } catch (Exception ignored) {}
        return null;
    }
}
