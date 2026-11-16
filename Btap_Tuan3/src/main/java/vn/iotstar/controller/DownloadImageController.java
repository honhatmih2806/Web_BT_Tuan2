package vn.iotstar.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import vn.iotstar.util.constants;

@WebServlet(urlPatterns = { "/image", "/media" })
public class DownloadImageController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            servePlaceholder(resp);
            return;
        }

        File file = new File(constants.UPLOAD_DIRECTORY, fileName);
        if (!file.exists()) {
            file = new File(constants.DIR, fileName);
        }

        if (file.exists() && file.isFile()) {
            String lower = fileName.toLowerCase();
            if (lower.endsWith(".mp4")) {
                resp.setContentType("video/mp4");
            } else if (lower.endsWith(".png")) {
                resp.setContentType("image/png");
            } else if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) {
                resp.setContentType("image/jpeg");
            } else if (lower.endsWith(".gif")) {
                resp.setContentType("image/gif");
            } else {
                resp.setContentType("application/octet-stream");
            }

            resp.setContentLengthLong(file.length());
            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = resp.getOutputStream()) {
                IOUtils.copy(in, out);
            }
        } else {
            servePlaceholder(resp);
        }
    }

    private void servePlaceholder(HttpServletResponse resp) throws IOException {
        resp.setContentType("image/svg+xml;charset=UTF-8");
        String svg = "<svg xmlns='http://www.w3.org/2000/svg' width='400' height='260' viewBox='0 0 400 260'>"
                + "<rect width='100%' height='100%' fill='#0d6efd' />"
                + "<circle cx='200' cy='110' r='50' fill='#ffffff' opacity='0.2' />"
                + "<polygon points='190,90 220,110 190,130' fill='#ffffff' />"
                + "<text x='50%' y='200' fill='#ffffff' font-family='sans-serif' font-size='18' font-weight='bold' text-anchor='middle'>HCMUTE Video Media</text>"
                + "</svg>";
        resp.getWriter().write(svg);
    }
}
