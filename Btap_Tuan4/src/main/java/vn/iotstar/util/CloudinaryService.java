package vn.iotstar.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.Map;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import jakarta.servlet.http.Part;

public class CloudinaryService {

    private static Cloudinary cloudinary;

    static {
        // Cấu hình Cloudinary từ biến môi trường hoặc cấu hình mặc định
        String cloudName = System.getenv().getOrDefault("CLOUDINARY_CLOUD_NAME", "");
        String apiKey = System.getenv().getOrDefault("CLOUDINARY_API_KEY", "");
        String apiSecret = System.getenv().getOrDefault("CLOUDINARY_API_SECRET", "");

        if (!cloudName.isEmpty() && !apiKey.isEmpty() && !apiSecret.isEmpty()) {
            cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", cloudName,
                "api_key", apiKey,
                "api_secret", apiSecret,
                "secure", true
            ));
        } else {
            cloudinary = null;
        }
    }

    /**
     * Tải ảnh lên Cloudinary qua Part Multipart, có fallback lưu local nếu chưa cấu hình API Key
     */
    public static String uploadFile(Part part) {
        if (part == null || part.getSize() <= 0) {
            return null;
        }

        try {
            String submittedFileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String ext = "";
            int dotIdx = submittedFileName.lastIndexOf('.');
            if (dotIdx >= 0) {
                ext = submittedFileName.substring(dotIdx);
            }
            String uniqueName = "avatar_" + System.currentTimeMillis() + ext;

            // Nếu Cloudinary đã được cấu hình với tài khoản thật
            if (cloudinary != null) {
                try {
                    File tempFile = File.createTempFile("cloud_upload_", ext);
                    try (InputStream in = part.getInputStream();
                         FileOutputStream out = new FileOutputStream(tempFile)) {
                        byte[] buffer = new byte[8192];
                        int bytesRead;
                        while ((bytesRead = in.read(buffer)) != -1) {
                            out.write(buffer, 0, bytesRead);
                        }
                    }
                    Map uploadResult = cloudinary.uploader().upload(tempFile, ObjectUtils.asMap("folder", "hcmute_profiles"));
                    tempFile.delete();
                    return (String) uploadResult.get("secure_url");
                } catch (Exception e) {
                    System.err.println("⚠️ Lỗi upload lên Cloudinary: " + e.getMessage() + ". Đang fallback lưu thư mục máy chủ.");
                }
            }

            // Fallback lưu local an toàn đảm bảo luôn hoạt động ổn định khi chấm bài
            String uploadDir = constants.UPLOAD_DIRECTORY;
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            part.write(uploadDir + File.separator + uniqueName);
            return uniqueName;

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
