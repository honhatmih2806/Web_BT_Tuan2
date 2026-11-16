package vn.iotstar.service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import vn.iotstar.model.Category;
import vn.iotstar.service.impl.CategoryServiceImpl;

public class CategoryServiceTest {

    private CategoryService categoryService;

    @BeforeEach
    void setUp() {
        categoryService = new CategoryServiceImpl();
    }

    @Test
    @DisplayName("Kiểm tra lấy danh sách danh mục (getAll)")
    void testGetAllCategories() {
        List<Category> list = categoryService.getAll();
        assertNotNull(list);
        assertFalse(list.isEmpty(), "Danh sách danh mục không được rỗng");
    }

    @Test
    @DisplayName("Kiểm tra thêm mới và tìm kiếm danh mục (CRUD Insert & Search)")
    void testInsertAndSearch() {
        String cateName = "Đồng hồ thông minh " + System.currentTimeMillis();
        Category c = new Category(cateName, "smartwatch.png");
        categoryService.insert(c);

        List<Category> searchRes = categoryService.search(cateName);
        assertNotNull(searchRes);
        assertFalse(searchRes.isEmpty());
        assertEquals(cateName, searchRes.get(0).getName());
    }

    @Test
    @DisplayName("Kiểm tra cập nhật danh mục (CRUD Edit)")
    void testEditCategory() {
        List<Category> list = categoryService.getAll();
        assertFalse(list.isEmpty());
        Category first = list.get(0);
        int id = first.getId();

        String updatedName = first.getName() + " (Đã cập nhật)";
        Category toUpdate = new Category(id, updatedName, "updated.png");
        categoryService.edit(toUpdate);

        Category after = categoryService.get(id);
        assertNotNull(after);
        assertEquals(updatedName, after.getName());
    }
}
