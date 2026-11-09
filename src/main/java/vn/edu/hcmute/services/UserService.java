package vn.edu.hcmute.services;

import java.util.List;
import vn.edu.hcmute.models.UserModel;

public interface UserService {
    UserModel login(String username, String password);
    UserModel get(String username);
    List<UserModel> getAll();
}
