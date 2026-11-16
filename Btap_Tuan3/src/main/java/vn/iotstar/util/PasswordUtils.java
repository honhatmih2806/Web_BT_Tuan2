package vn.iotstar.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {

    /**
     * Mã hóa mật khẩu plain text bằng thuật toán BCrypt với cost factor = 12
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu không được để trống");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12));
    }

    /**
     * Kiểm tra mật khẩu người dùng nhập vào với mật khẩu đã mã hóa trong CSDL
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        // Hỗ trợ kiểm tra hash BCrypt
        if (hashedPassword.startsWith("$2a$") || hashedPassword.startsWith("$2b$") || hashedPassword.startsWith("$2y$")) {
            try {
                return BCrypt.checkpw(plainPassword, hashedPassword);
            } catch (Exception e) {
                return false;
            }
        }
        // Fallback kiểm tra nếu mật khẩu cũ chưa mã hóa
        return plainPassword.equals(hashedPassword);
    }
}
