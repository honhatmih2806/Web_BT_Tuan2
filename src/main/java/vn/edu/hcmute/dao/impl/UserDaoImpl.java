package vn.edu.hcmute.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import vn.edu.hcmute.dao.DBContext;
import vn.edu.hcmute.dao.UserDao;
import vn.edu.hcmute.models.UserModel;

public class UserDaoImpl implements UserDao {

    private static final Logger LOGGER = Logger.getLogger(UserDaoImpl.class.getName());

    // Dữ liệu dự phòng (Fallback mock data) khi chưa bật server database
    private static final List<UserModel> MOCK_USERS = new ArrayList<>();

    static {
        MOCK_USERS.add(new UserModel(1, "admin", "123456", "ThS. Nguyễn Hữu Trung", "trungnh@hcmute.edu.vn", "ADMIN"));
        MOCK_USERS.add(new UserModel(2, "user", "123", "Nguyễn Văn A", "vana@student.hcmute.edu.vn", "USER"));
        MOCK_USERS.add(new UserModel(3, "sinhvien", "123", "Lê Thị B", "thib@student.hcmute.edu.vn", "USER"));
    }

    @Override
    public UserModel checkLogin(String username, String password) {
        if (username == null || password == null) {
            return null;
        }

        // 1. Ưu tiên truy vấn trực tiếp từ Microsoft SQL Server 14.x
        String sql = "SELECT id, username, password, fullName, email, role FROM Users WHERE username = ? AND password = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username.trim());
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
            return null; // Có kết nối DB nhưng sai username/password
        } catch (Exception e) {
            LOGGER.log(Level.INFO, "SQL Server chưa sẵn sàng hoặc ngoại lệ (" + e.getMessage() + "). Sử dụng dữ liệu dự phòng.");
        }

        // 2. Dự phòng: Dùng mock data nếu SQL Server đang offline
        for (UserModel user : MOCK_USERS) {
            if (user.getUsername().equalsIgnoreCase(username.trim()) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    @Override
    public UserModel findByUsername(String username) {
        if (username == null) {
            return null;
        }

        String sql = "SELECT id, username, password, fullName, email, role FROM Users WHERE username = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username.trim());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }
            return null;
        } catch (Exception e) {
            LOGGER.log(Level.INFO, "SQL Server offline, dùng mock data: " + e.getMessage());
        }

        for (UserModel user : MOCK_USERS) {
            if (user.getUsername().equalsIgnoreCase(username.trim())) {
                return user;
            }
        }
        return null;
    }

    @Override
    public List<UserModel> getAll() {
        List<UserModel> list = new ArrayList<>();
        String sql = "SELECT id, username, password, fullName, email, role FROM Users";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(extractUserFromResultSet(rs));
            }
            return list;
        } catch (Exception e) {
            LOGGER.log(Level.INFO, "SQL Server offline, dùng mock data: " + e.getMessage());
        }

        return new ArrayList<>(MOCK_USERS);
    }

    private UserModel extractUserFromResultSet(ResultSet rs) throws Exception {
        UserModel user = new UserModel();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setFullName(rs.getString("fullName"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        return user;
    }
}
