package vn.iotstar.service.impl;

import java.sql.Date;
import java.util.List;
import vn.iotstar.dao.IUserDao;
import vn.iotstar.dao.UserDao;
import vn.iotstar.entity.User;
import vn.iotstar.service.IUserService;
import vn.iotstar.util.EmailService;
import vn.iotstar.util.PasswordUtils;

public class UserServiceImpl implements IUserService {

    private final IUserDao userDao = new UserDao();

    @Override
    public boolean register(User user) {
        if (user == null || user.getUsername() == null || user.getEmail() == null || user.getPassword() == null) {
            return false;
        }

        // Kiểm tra xem username hoặc email đã tồn tại hay chưa
        if (userDao.checkExistUsername(user.getUsername()) || userDao.checkExistEmail(user.getEmail())) {
            return false;
        }

        // Mã hóa mật khẩu bằng BCrypt
        user.setPassword(PasswordUtils.hashPassword(user.getPassword()));

        // Sinh mã OTP 6 số để kích hoạt tài khoản
        String otp = EmailService.generateOtp();
        user.setCode(otp);
        user.setStatus(0); // Trạng thái chưa kích hoạt
        user.setCreatedDate(new Date(System.currentTimeMillis()));

        // Lưu vào CSDL
        userDao.insert(user);

        // Gửi email OTP
        EmailService.sendOtpEmail(user.getEmail(), otp, "Mã kích hoạt tài khoản HCMUTE", "Kích hoạt tài khoản mới");

        return true;
    }

    @Override
    public boolean activateAccount(String email, String otp) {
        if (email == null || otp == null) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) {
            user = userDao.findByUsername(email.trim());
        }
        if (user == null) return false;

        // So khớp mã OTP
        if (otp.trim().equals(user.getCode())) {
            user.setStatus(1); // Đã kích hoạt
            user.setCode(null); // Xóa OTP đã sử dụng
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public User login(String username, String password) throws Exception {
        if (username == null || password == null) {
            throw new Exception("Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu");
        }

        User user = userDao.findByUsername(username.trim());
        if (user == null) {
            user = userDao.findByEmail(username.trim());
        }

        if (user == null) {
            throw new Exception("Tài khoản không tồn tại");
        }

        // Kiểm tra mật khẩu mã hóa BCrypt
        if (!PasswordUtils.checkPassword(password, user.getPassword())) {
            throw new Exception("Mật khẩu không chính xác");
        }

        // Kiểm tra trạng thái tài khoản đã kích hoạt OTP chưa
        if (user.getStatus() != 1) {
            throw new Exception("Tài khoản chưa được kích hoạt qua mã OTP email! Vui lòng xác thực trước khi đăng nhập.");
        }

        return user;
    }

    @Override
    public boolean forgotPassword(String email) {
        if (email == null || email.trim().isEmpty()) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) {
            user = userDao.findByUsername(email.trim());
        }
        if (user == null) return false;

        // Sinh mã OTP đặt lại mật khẩu
        String otp = EmailService.generateOtp();
        user.setCode(otp);
        userDao.update(user);

        // Gửi mã OTP qua email
        EmailService.sendOtpEmail(user.getEmail(), otp, "Mã xác thực quên mật khẩu HCMUTE", "Đặt lại mật khẩu");
        return true;
    }

    @Override
    public boolean resetPassword(String email, String otp, String newPassword) {
        if (email == null || otp == null || newPassword == null) return false;
        User user = userDao.findByEmail(email.trim());
        if (user == null) {
            user = userDao.findByUsername(email.trim());
        }
        if (user == null) return false;

        // Kiểm tra OTP
        if (otp.trim().equals(user.getCode())) {
            user.setPassword(PasswordUtils.hashPassword(newPassword));
            user.setCode(null); // Xóa OTP sau khi đổi mật khẩu
            userDao.update(user);
            return true;
        }
        return false;
    }

    @Override
    public User findById(int id) {
        return userDao.findById(id);
    }

    @Override
    public User findByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public User findByEmail(String email) {
        return userDao.findByEmail(email);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    @Override
    public List<User> findAll() {
        return userDao.findAll();
    }
}
