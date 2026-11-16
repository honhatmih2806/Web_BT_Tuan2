package vn.iotstar;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.EmailService;
import vn.iotstar.util.PasswordUtils;

public class UserServiceTest {

    private IUserService userService;

    @BeforeEach
    public void setUp() {
        userService = new UserServiceImpl();
    }

    @Test
    public void testBCryptHashing() {
        String plain = "SecretPassword123";
        String hashed = PasswordUtils.hashPassword(plain);

        Assertions.assertNotNull(hashed);
        Assertions.assertTrue(hashed.startsWith("$2a$") || hashed.startsWith("$2b$"));
        Assertions.assertTrue(PasswordUtils.checkPassword(plain, hashed));
        Assertions.assertFalse(PasswordUtils.checkPassword("WrongPassword", hashed));
    }

    @Test
    public void testRegisterAndOtpActivationFlow() throws Exception {
        String uniqueUser = "testuser_" + System.currentTimeMillis();
        String uniqueEmail = uniqueUser + "@test.com";

        User user = new User();
        user.setUsername(uniqueUser);
        user.setEmail(uniqueEmail);
        user.setFullname("Test User");
        user.setPassword("mypassword");

        // 1. Đăng ký -> sinh mã OTP, trạng thái status = 0
        boolean registered = userService.register(user);
        Assertions.assertTrue(registered, "Đăng ký phải thành công");

        // Không thể đăng nhập khi status = 0
        Assertions.assertThrows(Exception.class, () -> {
            userService.login(uniqueUser, "mypassword");
        }, "Chưa kích hoạt OTP không được phép đăng nhập");

        // 2. Lấy mã OTP vừa sinh
        String otp = EmailService.getLatestOtp(uniqueEmail);
        Assertions.assertNotNull(otp, "OTP phải tồn tại trong cache/email sender");
        Assertions.assertEquals(6, otp.length(), "OTP phải gồm 6 chữ số");

        // 3. Kích hoạt tài khoản bằng OTP
        boolean activated = userService.activateAccount(uniqueEmail, otp);
        Assertions.assertTrue(activated, "Kích hoạt bằng OTP hợp lệ phải thành công");

        // 4. Đăng nhập thành công sau khi kích hoạt
        User loggedIn = userService.login(uniqueUser, "mypassword");
        Assertions.assertNotNull(loggedIn, "Đăng nhập phải thành công");
        Assertions.assertEquals(1, loggedIn.getStatus(), "Status phải là 1 (đã kích hoạt)");
    }

    @Test
    public void testForgotPasswordAndResetWithOtp() throws Exception {
        String uniqueUser = "forgot_" + System.currentTimeMillis();
        String uniqueEmail = uniqueUser + "@test.com";

        User user = new User();
        user.setUsername(uniqueUser);
        user.setEmail(uniqueEmail);
        user.setPassword("oldpassword");
        userService.register(user);
        String regOtp = EmailService.getLatestOtp(uniqueEmail);
        userService.activateAccount(uniqueEmail, regOtp);

        // Quên mật khẩu
        boolean forgotSent = userService.forgotPassword(uniqueEmail);
        Assertions.assertTrue(forgotSent);

        String resetOtp = EmailService.getLatestOtp(uniqueEmail);
        Assertions.assertNotNull(resetOtp);

        // Đặt lại mật khẩu mới
        boolean resetSuccess = userService.resetPassword(uniqueEmail, resetOtp, "newSecret999");
        Assertions.assertTrue(resetSuccess);

        // Đăng nhập với mật khẩu mới
        User updatedUser = userService.login(uniqueUser, "newSecret999");
        Assertions.assertNotNull(updatedUser);
    }
}
