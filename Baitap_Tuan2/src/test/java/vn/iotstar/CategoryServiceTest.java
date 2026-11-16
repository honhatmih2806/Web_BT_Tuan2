package vn.iotstar;

import static org.junit.jupiter.api.Assertions.*;

import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import vn.iotstar.entity.Category;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;

public class CategoryServiceTest {

    private ICategoryService categoryService;

    @BeforeEach
    void setUp() {
        categoryService = new CategoryServiceImpl();
    }

    @Test
    @DisplayName("Test JPA: Lấy toàn bộ danh sách Category")
    void testFindAll() {
        List<Category> list = categoryService.findAll();
        assertNotNull(list);
        assertFalse(list.isEmpty(), "Danh sách categories không được rỗng");
    }

    @Test
    @DisplayName("Test JPA: Thêm mới Category và tìm kiếm theo tên")
    void testInsertAndSearch() {
        String testName = "JPA Test Category " + System.currentTimeMillis();
        Category c = new Category(testName, "test.png", 1);
        categoryService.insert(c);

        List<Category> searchResults = categoryService.searchByName("JPA Test");
        assertNotNull(searchResults);
        assertFalse(searchResults.isEmpty());
    }

    @Test
    @DisplayName("Test JPA: Cập nhật Category")
    void testUpdate() {
        List<Category> list = categoryService.findAll();
        assertFalse(list.isEmpty());
        Category first = list.get(0);
        int id = first.getCategoryid();

        String newName = first.getCategoryname() + " (Updated)";
        Category toUpdate = new Category(id, newName, first.getImages(), 1);
        categoryService.update(toUpdate);

        Category after = categoryService.findById(id);
        assertNotNull(after);
        assertEquals(newName, after.getCategoryname());
    }
}
