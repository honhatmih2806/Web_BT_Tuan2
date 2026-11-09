package vn.edu.hcmute.services.impl;

import java.util.List;
import vn.edu.hcmute.dao.UserDao;
import vn.edu.hcmute.dao.impl.UserDaoImpl;
import vn.edu.hcmute.models.UserModel;
import vn.edu.hcmute.services.UserService;

public class UserServiceImpl implements UserService {

    private final UserDao userDao = new UserDaoImpl();

    @Override
    public UserModel login(String username, String password) {
        if (username == null || username.trim().isEmpty() || password == null || password.isEmpty()) {
            return null;
        }
        return userDao.checkLogin(username, password);
    }

    @Override
    public UserModel get(String username) {
        if (username == null || username.trim().isEmpty()) {
            return null;
        }
        return userDao.findByUsername(username);
    }

    @Override
    public List<UserModel> getAll() {
        return userDao.getAll();
    }
}
