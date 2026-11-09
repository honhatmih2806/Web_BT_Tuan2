package vn.edu.hcmute.dao;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import vn.edu.hcmute.dao.impl.UserDaoImpl;
import vn.edu.hcmute.models.UserModel;

public class UserDaoTest {

    private UserDao userDao;

    @BeforeEach
    void setUp() {
        userDao = new UserDaoImpl();
    }

    @Test
    @DisplayName("Test DAO: Tìm kiếm người dùng theo username")
    void testFindByUsername() {
        UserModel user = userDao.findByUsername("user");
        assertNotNull(user);
        assertEquals("Nguyễn Văn A", user.getFullName());
    }

    @Test
    @DisplayName("Test DAO: Lấy toàn bộ danh sách người dùng")
    void testGetAllUsers() {
        List<UserModel> users = userDao.getAll();
        assertNotNull(users);
        assertTrue(users.size() >= 3, "Danh sách mẫu phải có ít nhất 3 người dùng");
    }
}
