package vn.iotstar.dao;

import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.Category;

public class CategoryDao implements ICategoryDao {

    // Danh sách dự phòng khi chưa bật CSDL SQL Server
    private static final List<Category> MOCK_LIST = new ArrayList<>();

    static {
        MOCK_LIST.add(new Category(1, "Điện thoại & Phụ kiện", "phone.png", 1));
        MOCK_LIST.add(new Category(2, "Laptop & Thiết bị số", "laptop.png", 1));
        MOCK_LIST.add(new Category(3, "Thời trang & Mỹ phẩm", "fashion.png", 1));
        MOCK_LIST.add(new Category(4, "Sách & Văn phòng phẩm", "book.png", 1));
    }

    @Override
    public void insert(Category category) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.persist(category); // insert vào bảng
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            // Fallback lưu vào mock list
            int newId = MOCK_LIST.isEmpty() ? 1 : MOCK_LIST.get(MOCK_LIST.size() - 1).getCategoryid() + 1;
            category.setCategoryid(newId);
            MOCK_LIST.add(category);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void update(Category category) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.merge(category); // update vào bảng
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            // Fallback cập nhật mock list
            for (int i = 0; i < MOCK_LIST.size(); i++) {
                if (MOCK_LIST.get(i).getCategoryid() == category.getCategoryid()) {
                    MOCK_LIST.set(i, category);
                    break;
                }
            }
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void delete(int cateid) throws Exception {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            Category category = enma.find(Category.class, cateid);
            if (category != null) {
                enma.remove(category);
            } else {
                throw new Exception("Không tìm thấy Category với id = " + cateid);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            // Fallback xóa trong mock list
            MOCK_LIST.removeIf(c -> c.getCategoryid() == cateid);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public Category findById(int cateid) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            return enma.find(Category.class, cateid);
        } catch (Exception e) {
            for (Category c : MOCK_LIST) {
                if (c.getCategoryid() == cateid) {
                    return c;
                }
            }
            return null;
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public Category findByCategoryname(String name) throws Exception {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            String jpql = "SELECT c FROM Category c WHERE c.categoryname =:catename";
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catename", name);
            try {
                return query.getSingleResult();
            } catch (NoResultException nre) {
                return null;
            }
        } catch (Exception e) {
            for (Category c : MOCK_LIST) {
                if (c.getCategoryname().equalsIgnoreCase(name)) {
                    return c;
                }
            }
            return null;
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Category> findAll() {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>(MOCK_LIST);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Category> searchByName(String catname) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            String jpql = "SELECT c FROM Category c WHERE c.categoryname like :catname";
            TypedQuery<Category> query = enma.createQuery(jpql, Category.class);
            query.setParameter("catname", "%" + catname + "%");
            return query.getResultList();
        } catch (Exception e) {
            List<Category> res = new ArrayList<>();
            for (Category c : MOCK_LIST) {
                if (c.getCategoryname().toLowerCase().contains(catname.toLowerCase())) {
                    res.add(c);
                }
            }
            return res;
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Category> findAll(int page, int pagesize) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Category> query = enma.createNamedQuery("Category.findAll", Category.class);
            query.setFirstResult(page * pagesize);
            query.setMaxResults(pagesize);
            return query.getResultList();
        } catch (Exception e) {
            int fromIndex = Math.min(page * pagesize, MOCK_LIST.size());
            int toIndex = Math.min(fromIndex + pagesize, MOCK_LIST.size());
            return new ArrayList<>(MOCK_LIST.subList(fromIndex, toIndex));
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public int count() {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            String jpql = "SELECT count(c) FROM Category c";
            Query query = enma.createQuery(jpql);
            return ((Long) query.getSingleResult()).intValue();
        } catch (Exception e) {
            return MOCK_LIST.size();
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }
}
