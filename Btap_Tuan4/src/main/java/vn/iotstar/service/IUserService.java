package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.User;

public interface IUserService {
    boolean register(User user);
    boolean activateAccount(String email, String otp);
    User login(String username, String password) throws Exception;
    boolean forgotPassword(String email);
    boolean resetPassword(String email, String otp, String newPassword);
    User findById(int id);
    User findByUsername(String username);
    User findByEmail(String email);
    void update(User user);
    List<User> findAll();
}
