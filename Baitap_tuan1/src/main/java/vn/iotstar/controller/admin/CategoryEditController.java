package vn.iotstar.controller.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = { "/admin/category/edit" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 5 * 5)
public class CategoryEditController extends HttpServlet {

    private final CategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id != null && !id.isEmpty()) {
            Category category = cateService.get(Integer.parseInt(id));
            req.setAttribute("category", category);
        }
        RequestDispatcher dispatcher = req.getRequestDispatcher("/views/admin/edit-category.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            idStr = req.getParameter("cateid");
        }
        int categoryid = Integer.parseInt(idStr);
        String categoryname = req.getParameter("catename");

        Category category = new Category();
        category.setCateId(categoryid);
        category.setCateName(categoryname);

        Category cateold = cateService.findById(categoryid);
        String fileold = (cateold != null) ? cateold.getIcon() : "default.png";

        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        try {
            Part part = req.getPart("icon");
            if (part == null) {
                part = req.getPart("images");
            }
            if (part != null && part.getSize() > 0) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                int index = filename.lastIndexOf(".");
                String ext = (index > 0) ? filename.substring(index + 1) : "png";
                String fname = System.currentTimeMillis() + "." + ext;
                part.write(uploadPath + File.separator + fname);
                category.setIcon(fname);
            } else {
                category.setIcon(fileold);
            }
        } catch (Exception e) {
            e.printStackTrace();
            category.setIcon(fileold);
        }

        cateService.update(category);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
