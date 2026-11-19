package vn.iotstar.util;

import java.io.File;

public class constants {
    // Thư mục lưu trữ hình ảnh upload (Windows: E:\\upload hoặc Linux: /tmp/upload)
    public static final String DIR;
    public static final String UPLOAD_DIRECTORY;
    public static final String DEFAULT_FILENAME = "default.file";

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
        UPLOAD_DIRECTORY = uploadDir;
    }
}
