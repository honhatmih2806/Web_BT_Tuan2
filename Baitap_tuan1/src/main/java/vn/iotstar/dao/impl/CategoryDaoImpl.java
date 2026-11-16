package vn.iotstar.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import vn.iotstar.connection.DBConnection;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.model.Category;

public class CategoryDaoImpl extends DBConnection implements CategoryDao {

    // Danh sách dự phòng khi SQL Server chưa được bật
    private static final List<Category> MOCK_CATEGORIES = new ArrayList<>();

    static {
        MOCK_CATEGORIES.add(new Category(1, "Điện thoại & Phụ kiện", "phone.png"));
        MOCK_CATEGORIES.add(new Category(2, "Laptop & Máy vi tính", "laptop.png"));
        MOCK_CATEGORIES.add(new Category(3, "Thời trang & Mỹ phẩm", "fashion.png"));
        MOCK_CATEGORIES.add(new Category(4, "Sách & Văn phòng phẩm", "book.png"));
    }

    @Override
    public void insert(Category category) {
        String sql = "INSERT INTO Category(cate_name, icons) VALUES (?, ?)";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getIcon());
            ps.executeUpdate();
        } catch (Exception e) {
            int newId = MOCK_CATEGORIES.isEmpty() ? 1 : MOCK_CATEGORIES.get(MOCK_CATEGORIES.size() - 1).getId() + 1;
            category.setId(newId);
            MOCK_CATEGORIES.add(category);
        }
    }

    @Override
    public void edit(Category category) {
        String sql = "UPDATE Category SET cate_name = ?, icons = ? WHERE cate_id = ?";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, category.getName());
            ps.setString(2, category.getIcon());
            ps.setInt(3, category.getId());
            ps.executeUpdate();
        } catch (Exception e) {
            for (int i = 0; i < MOCK_CATEGORIES.size(); i++) {
                if (MOCK_CATEGORIES.get(i).getId() == category.getId()) {
                    MOCK_CATEGORIES.set(i, category);
                    break;
                }
            }
        }
    }

    @Override
    public void delete(int id) {
        String sql = "DELETE FROM Category WHERE cate_id = ?";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            MOCK_CATEGORIES.removeIf(c -> c.getId() == id);
        }
    }

    @Override
    public Category get(int id) {
        String sql = "SELECT * FROM Category WHERE cate_id = ?";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("cate_id"));
                    category.setName(rs.getString("cate_name"));
                    category.setIcon(rs.getString("icons"));
                    return category;
                }
            }
        } catch (Exception e) {
            for (Category c : MOCK_CATEGORIES) {
                if (c.getId() == id) {
                    return c;
                }
            }
        }
        return null;
    }

    @Override
    public Category get(String name) {
        String sql = "SELECT * FROM Category WHERE cate_name = ?";
        try (Connection con = super.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("cate_id"));
                    category.setName(rs.getString("cate_name"));
                    category.setIcon(rs.getString("icons"));
                    return category;
                }
            }
        } catch (Exception e) {
            for (Category c : MOCK_CATEGORIES) {
                if (c.getName().equalsIgnoreCase(name)) {
                    return c;
                }
            }
        }
        return null;
    }

    @Override
    public List<Category> getAll() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Category category = new Category();
                category.setId(rs.getInt("cate_id"));
                category.setName(rs.getString("cate_name"));
                category.setIcon(rs.getString("icons"));
                categories.add(category);
            }
            return categories;
        } catch (Exception e) {
            return new ArrayList<>(MOCK_CATEGORIES);
        }
    }

    @Override
    public List<Category> search(String keyword) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM Category WHERE cate_name LIKE ?";
        try (Connection conn = super.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Category category = new Category();
                    category.setId(rs.getInt("cate_id"));
                    category.setName(rs.getString("cate_name"));
                    category.setIcon(rs.getString("icons"));
                    categories.add(category);
                }
            }
            return categories;
        } catch (Exception e) {
            for (Category c : MOCK_CATEGORIES) {
                if (c.getName().toLowerCase().contains(keyword.toLowerCase())) {
                    categories.add(c);
                }
            }
            return categories;
        }
    }
}
