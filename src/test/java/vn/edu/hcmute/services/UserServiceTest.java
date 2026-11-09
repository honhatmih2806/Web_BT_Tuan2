package vn.edu.hcmute.services;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import vn.edu.hcmute.models.UserModel;
import vn.edu.hcmute.services.impl.UserServiceImpl;

public class UserServiceTest {

    private UserService userService;

    @BeforeEach
    void setUp() {
        userService = new UserServiceImpl();
    }

    @Test
    @DisplayName("Test 1: Đăng nhập thành công với tài khoản Admin")
    void testLoginSuccessAdmin() {
        UserModel user = userService.login("admin", "123456");
        assertNotNull(user, "User không được null khi thông tin đăng nhập đúng");
        assertEquals("admin", user.getUsername());
        assertEquals("ADMIN", user.getRole());
        assertEquals("ThS. Nguyễn Hữu Trung", user.getFullName());
    }

    @Test
    @DisplayName("Test 2: Đăng nhập thành công với tài khoản sinh viên thường")
    void testLoginSuccessStudent() {
        UserModel user = userService.login("sinhvien", "123");
        assertNotNull(user);
        assertEquals("sinhvien", user.getUsername());
        assertEquals("Lê Thị B", user.getFullName());
    }

    @Test
    @DisplayName("Test 3: Đăng nhập thất bại khi sai mật khẩu")
    void testLoginWrongPassword() {
        UserModel user = userService.login("admin", "wrong_password");
        assertNull(user, "User phải null khi nhập sai mật khẩu");
    }

    @Test
    @DisplayName("Test 4: Đăng nhập thất bại khi tài khoản không tồn tại")
    void testLoginNonExistentUser() {
        UserModel user = userService.login("unknown_user", "123456");
        assertNull(user, "User phải null khi tài khoản không tồn tại");
    }

    @Test
    @DisplayName("Test 5: Đăng nhập thất bại khi username hoặc password rỗng/null")
    void testLoginNullOrEmpty() {
        assertNull(userService.login("", "123"));
        assertNull(userService.login("admin", ""));
        assertNull(userService.login(null, "123"));
        assertNull(userService.login("admin", null));
    }
}
