package vn.iotstar.util;

import java.io.File;

public class Constant {
    public static final String SESSION_USERNAME = "username";
    public static final String COOKIE_REMEMBER = "username";

    public static final class Path {
        public static final String LOGIN = "/views/login.jsp";
        public static final String REGISTER = "/views/register.jsp";
        public static final String HOME = "/views/home.jsp";
        public static final String ADMIN_HOME = "/views/admin/home.jsp";
        public static final String MANAGER_HOME = "/views/manager/home.jsp";
    }

    // Thư mục lưu trữ hình ảnh upload (Windows: E:\\upload hoặc Linux: /tmp/upload)
    public static final String DIR;

    static {
        String uploadDir;
        String os = System.getProperty("os.name").toLowerCase();
        if (os.contains("win")) {
            uploadDir = "E:\\upload";
        } else {
            uploadDir = "/tmp/upload";
        }
        File f = new File(uploadDir);
        if (!f.exists()) {
            f.mkdirs();
        }
        DIR = uploadDir;
    }
}
