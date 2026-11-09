package vn.edu.hcmute.dao;

import java.util.List;
import vn.edu.hcmute.models.UserModel;

public interface UserDao {
    UserModel checkLogin(String username, String password);
    UserModel findByUsername(String username);
    List<UserModel> getAll();
}
