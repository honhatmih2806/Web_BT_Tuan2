package vn.iotstar.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import org.apache.commons.io.IOUtils;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.isEmpty()) {
            fileName = "default.png";
        }

        File file = new File(Constant.DIR + File.separator + fileName);
        resp.setContentType("image/jpeg");

        if (file.exists()) {
            try (FileInputStream in = new FileInputStream(file)) {
                IOUtils.copy(in, resp.getOutputStream());
            }
        } else {
            // Nếu file trên đĩa chưa có, trả về 1 SVG ảnh placeholder đẹp
            resp.setContentType("image/svg+xml");
            String svg = "<svg xmlns='http://www.w3.org/2000/svg' width='160' height='120' viewBox='0 0 160 120'>"
                    + "<rect width='160' height='120' fill='#fce4ec'/>"
                    + "<text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' fill='#d81b60' font-size='14' font-family='sans-serif'>📦 " + fileName + "</text>"
                    + "</svg>";
            resp.getWriter().write(svg);
        }
    }
}
