package vn.iotstar.util;

import java.io.File;

public class constants {
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
