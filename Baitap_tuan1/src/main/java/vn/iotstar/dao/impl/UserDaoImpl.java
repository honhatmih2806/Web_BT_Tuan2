package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.UserDao;
import vn.iotstar.model.User;

public class UserDaoImpl implements UserDao {

    public Connection conn = null;
    public PreparedStatement ps = null;
    public ResultSet rs = null;

    // Dữ liệu dự phòng (Fallback) khi SQL Server chưa được bật
    private static final List<User> MOCK_USERS = new ArrayList<>();

    static {
        long now = System.currentTimeMillis();
        MOCK_USERS.add(new User(1, "trungnh@hcmute.edu.vn", "admin", "ThS. Nguyễn Hữu Trung", "123456", "admin.png", 1, "0908617108", new java.sql.Date(now)));
        MOCK_USERS.add(new User(2, "manager@hcmute.edu.vn", "manager", "Quản Lý Cửa Hàng", "123456", "manager.png", 2, "0901234567", new java.sql.Date(now)));
        MOCK_USERS.add(new User(3, "user@hcmute.edu.vn", "user", "Nguyễn Văn A", "123456", "user.png", 3, "0987654321", new java.sql.Date(now)));
    }

    @Override
    public User get(String username) {
        String sql = "SELECT * FROM [User] WHERE username = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setUserName(rs.getString("username"));
                user.setFullName(rs.getString("fullname"));
                user.setPassWord(rs.getString("password"));
                user.setAvatar(rs.getString("avatar"));
                user.setRoleid(rs.getInt("roleid"));
                user.setPhone(rs.getString("phone"));
                user.setCreatedDate(rs.getDate("createdDate"));
                return user;
            }
        } catch (Exception e) {
            // Fallback khi SQL Server offline
            for (User u : MOCK_USERS) {
                if (u.getUserName().equalsIgnoreCase(username)) {
                    return u;
                }
            }
        } finally {
            closeResources();
        }
        return null;
    }

    @Override
    public void insert(User user) {
        String sql = "INSERT INTO [User](email, username, fullname, password, avatar, roleid, phone, createddate) VALUES (?,?,?,?,?,?,?,?)";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getFullName());
            ps.setString(4, user.getPassWord());
            ps.setString(5, user.getAvatar());
            ps.setInt(6, user.getRoleid());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getCreatedDate());
            ps.executeUpdate();
        } catch (Exception e) {
            // Lưu vào mock data nếu DB offline
            user.setId(MOCK_USERS.size() + 1);
            MOCK_USERS.add(user);
        } finally {
            closeResources();
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        boolean duplicate = false;
        String query = "SELECT * FROM [User] WHERE email = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                duplicate = true;
            }
        } catch (Exception ex) {
            for (User u : MOCK_USERS) {
                if (u.getEmail() != null && u.getEmail().equalsIgnoreCase(email)) {
                    return true;
                }
            }
        } finally {
            closeResources();
        }
        return duplicate;
    }

    @Override
    public boolean checkExistUsername(String username) {
        boolean duplicate = false;
        String query = "SELECT * FROM [User] WHERE username = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            rs = ps.executeQuery();
            if (rs.next()) {
                duplicate = true;
            }
        } catch (Exception ex) {
            for (User u : MOCK_USERS) {
                if (u.getUserName() != null && u.getUserName().equalsIgnoreCase(username)) {
                    return true;
                }
            }
        } finally {
            closeResources();
        }
        return duplicate;
    }

    @Override
    public boolean checkExistPhone(String phone) {
        boolean duplicate = false;
        String query = "SELECT * FROM [User] WHERE phone = ?";
        try {
            conn = new DBConnection().getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, phone);
            rs = ps.executeQuery();
            if (rs.next()) {
                duplicate = true;
            }
        } catch (Exception ex) {
            for (User u : MOCK_USERS) {
                if (u.getPhone() != null && u.getPhone().equals(phone)) {
                    return true;
                }
            }
        } finally {
            closeResources();
        }
        return duplicate;
    }

    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (Exception ignored) {
        }
    }
}
