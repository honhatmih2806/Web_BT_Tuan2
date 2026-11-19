package vn.iotstar.util;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

public class FormValidator {

    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[a-zA-Z0-9_]{3,30}$");
    private static final Pattern PHONE_PATTERN = Pattern.compile("^0[0-9]{9,10}$");

    /**
     * Validation Form Đăng Nhập
     */
    public static Map<String, String> validateLogin(String username, String password) {
        Map<String, String> errors = new HashMap<>();
        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Tên đăng nhập không được để trống!");
        } else if (username.trim().length() < 3) {
            errors.put("username", "Tên đăng nhập phải có ít nhất 3 ký tự!");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống!");
        } else if (password.length() < 6) {
            errors.put("password", "Mật khẩu phải có độ dài tối thiểu 6 ký tự!");
        }
        return errors;
    }

    /**
     * Validation Form Đăng Ký Tài Khoản
     */
    public static Map<String, String> validateRegister(String username, String email, String password, String fullname, String phone) {
        Map<String, String> errors = new HashMap<>();

        if (username == null || username.trim().isEmpty()) {
            errors.put("username", "Tên đăng nhập không được để trống!");
        } else if (!USERNAME_PATTERN.matcher(username.trim()).matches()) {
            errors.put("username", "Tên đăng nhập chỉ gồm chữ cái, số và dấu gạch dưới (3 - 30 ký tự)!");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống!");
        } else if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            errors.put("email", "Định dạng email không hợp lệ (ví dụ: user@example.com)!");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Mật khẩu không được để trống!");
        } else if (password.length() < 6) {
            errors.put("password", "Mật khẩu phải có ít nhất 6 ký tự!");
        }

        if (fullname != null && !fullname.trim().isEmpty() && fullname.trim().length() < 2) {
            errors.put("fullname", "Họ và tên phải có ít nhất 2 ký tự!");
        }

        if (phone != null && !phone.trim().isEmpty() && !PHONE_PATTERN.matcher(phone.trim()).matches()) {
            errors.put("phone", "Số điện thoại phải bắt đầu bằng 0 và có 10-11 chữ số!");
        }

        return errors;
    }

    /**
     * Validation Form Quên Mật Khẩu
     */
    public static Map<String, String> validateForgotPassword(String email) {
        Map<String, String> errors = new HashMap<>();
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email không được để trống!");
        } else if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            errors.put("email", "Email không đúng định dạng!");
        }
        return errors;
    }

    /**
     * Validation Form Video (Insert / Edit)
     */
    public static Map<String, String> validateVideo(String title, String videoUrl) {
        Map<String, String> errors = new HashMap<>();
        if (title == null || title.trim().isEmpty()) {
            errors.put("title", "Tiêu đề video không được để trống!");
        } else if (title.trim().length() < 3 || title.trim().length() > 300) {
            errors.put("title", "Tiêu đề video phải từ 3 đến 300 ký tự!");
        }
        return errors;
    }

    /**
     * Validation Form Cập Nhật Profile
     */
    public static Map<String, String> validateProfile(String fullname, String phone, String newEmail) {
        Map<String, String> errors = new HashMap<>();
        if (fullname == null || fullname.trim().isEmpty()) {
            errors.put("fullname", "Họ và tên không được để trống!");
        }

        if (newEmail == null || newEmail.trim().isEmpty()) {
            errors.put("email", "Email không được để trống!");
        } else if (!EMAIL_PATTERN.matcher(newEmail.trim()).matches()) {
            errors.put("email", "Email không hợp lệ!");
        }

        if (phone != null && !phone.trim().isEmpty() && !PHONE_PATTERN.matcher(phone.trim()).matches()) {
            errors.put("phone", "Số điện thoại phải bắt đầu bằng 0 và gồm 10-11 số!");
        }

        return errors;
    }
}
