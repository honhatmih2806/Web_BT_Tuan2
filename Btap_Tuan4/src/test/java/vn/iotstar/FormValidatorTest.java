package vn.iotstar;

import java.util.Map;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import vn.iotstar.util.FormValidator;

public class FormValidatorTest {

    @Test
    public void testValidateLogin() {
        // Valid
        Map<String, String> valid = FormValidator.validateLogin("valid_user", "password123");
        Assertions.assertTrue(valid.isEmpty());

        // Empty username
        Map<String, String> emptyUser = FormValidator.validateLogin("", "password123");
        Assertions.assertTrue(emptyUser.containsKey("username"));

        // Short password
        Map<String, String> shortPass = FormValidator.validateLogin("valid_user", "123");
        Assertions.assertTrue(shortPass.containsKey("password"));
    }

    @Test
    public void testValidateRegister() {
        // Valid
        Map<String, String> valid = FormValidator.validateRegister("valid_user", "user@hcmute.edu.vn", "password123", "Ho Nhat Minh", "0901234567");
        Assertions.assertTrue(valid.isEmpty());

        // Invalid email format
        Map<String, String> invalidEmail = FormValidator.validateRegister("valid_user", "invalid-email-format", "password123", "Ho Nhat Minh", "0901234567");
        Assertions.assertTrue(invalidEmail.containsKey("email"));

        // Invalid phone format
        Map<String, String> invalidPhone = FormValidator.validateRegister("valid_user", "user@test.com", "password123", "Ho Nhat Minh", "12345");
        Assertions.assertTrue(invalidPhone.containsKey("phone"));
    }

    @Test
    public void testValidateForgotPassword() {
        Assertions.assertTrue(FormValidator.validateForgotPassword("valid@gmail.com").isEmpty());
        Assertions.assertTrue(FormValidator.validateForgotPassword("not-an-email").containsKey("email"));
        Assertions.assertTrue(FormValidator.validateForgotPassword("").containsKey("email"));
    }

    @Test
    public void testValidateVideo() {
        Assertions.assertTrue(FormValidator.validateVideo("Video Title 01", "https://video.mp4").isEmpty());
        Assertions.assertTrue(FormValidator.validateVideo("", "https://video.mp4").containsKey("title"));
    }

    @Test
    public void testValidateProfile() {
        Assertions.assertTrue(FormValidator.validateProfile("Ho Nhat Minh", "0901234567", "newemail@gmail.com").isEmpty());
        Assertions.assertTrue(FormValidator.validateProfile("", "0901234567", "newemail@gmail.com").containsKey("fullname"));
        Assertions.assertTrue(FormValidator.validateProfile("Ho Nhat Minh", "0901234567", "bad-email").containsKey("email"));
    }
}
