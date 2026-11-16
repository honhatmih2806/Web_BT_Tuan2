package vn.iotstar.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import vn.iotstar.util.constants;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.isEmpty()) {
            fileName = "avatar.png";
        }

        File file = new File(constants.DIR + File.separator + fileName);

        if (file.exists() && file.isFile()) {
            resp.setContentType("image/jpeg");
            try (FileInputStream in = new FileInputStream(file)) {
                IOUtils.copy(in, resp.getOutputStream());
            }
        } else {
            // Placeholder SVG nếu ảnh không có trên đĩa
            resp.setContentType("image/svg+xml");
            String svg = "<svg xmlns='http://www.w3.org/2000/svg' width='200' height='150' viewBox='0 0 200 150'>"
                    + "<rect width='200' height='150' fill='#e3f2fd'/>"
                    + "<text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' fill='#1976d2' font-size='14' font-family='sans-serif'>📁 " + fileName + "</text>"
                    + "</svg>";
            resp.getWriter().write(svg);
        }
    }
}
