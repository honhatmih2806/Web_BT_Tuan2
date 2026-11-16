package vn.iotstar.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import vn.iotstar.model.User;
import vn.iotstar.service.impl.UserServiceImpl;

public class UserServiceTest {

    private UserService userService;

    @BeforeEach
    void setUp() {
        userService = new UserServiceImpl();
    }

    @Test
    @DisplayName("Kiểm tra đăng nhập thành công với Admin")
    void testLoginAdminSuccess() {
        User user = userService.login("admin", "123456");
        assertNotNull(user);
        assertEquals("admin", user.getUserName());
        assertEquals(1, user.getRoleid());
        assertEquals("ThS. Nguyễn Hữu Trung", user.getFullName());
    }

    @Test
    @DisplayName("Kiểm tra đăng nhập sai mật khẩu")
    void testLoginWrongPassword() {
        User user = userService.login("admin", "wrong_password");
        assertNull(user);
    }

    @Test
    @DisplayName("Kiểm tra kiểm tra trùng lặp email và username")
    void testCheckExist() {
        assertTrue(userService.checkExistEmail("trungnh@hcmute.edu.vn"));
        assertTrue(userService.checkExistUsername("admin"));
        assertFalse(userService.checkExistUsername("not_found_user_xyz"));
    }

    @Test
    @DisplayName("Kiểm tra đăng ký tài khoản mới")
    void testRegisterNewUser() {
        String testUser = "testuser_" + System.currentTimeMillis();
        String testEmail = testUser + "@gmail.com";
        boolean res = userService.register(testUser, "123456", testEmail, "Test User", "0900000000");
        assertTrue(res);
        assertTrue(userService.checkExistUsername(testUser));
    }
}
