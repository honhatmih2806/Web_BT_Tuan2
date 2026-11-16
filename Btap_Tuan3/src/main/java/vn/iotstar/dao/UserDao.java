package vn.iotstar.dao;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.User;
import vn.iotstar.util.PasswordUtils;

public class UserDao implements IUserDao {

    // Bộ nhớ in-memory dự phòng tự động hoạt động khi CSDL SQL Server chưa bật
    private static final ConcurrentHashMap<Integer, User> IN_MEMORY_DB = new ConcurrentHashMap<>();
    private static final AtomicInteger ID_GENERATOR = new AtomicInteger(100);

    static {
        // Tài khoản quản trị mặc định (pass: 123456)
        User admin = new User();
        admin.setId(1);
        admin.setUsername("admin");
        admin.setEmail("admin@hcmute.edu.vn");
        admin.setFullname("Administrator");
        admin.setPassword(PasswordUtils.hashPassword("123456"));
        admin.setRoleid(1);
        admin.setStatus(1); // Đã kích hoạt
        IN_MEMORY_DB.put(1, admin);

        // Tài khoản người dùng mẫu (pass: 123456)
        User demo = new User();
        demo.setId(2);
        demo.setUsername("nhatminh");
        demo.setEmail("honhatmih2806@gmail.com");
        demo.setFullname("Hồ Nhật Minh");
        demo.setPassword(PasswordUtils.hashPassword("123456"));
        demo.setRoleid(3);
        demo.setStatus(1);
        IN_MEMORY_DB.put(2, demo);
    }

    @Override
    public void insert(User user) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.persist(user);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            // Fallback lưu vào in-memory store
            if (user.getId() == 0) {
                user.setId(ID_GENERATOR.incrementAndGet());
            }
            IN_MEMORY_DB.put(user.getId(), user);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void update(User user) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.merge(user);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            IN_MEMORY_DB.put(user.getId(), user);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void delete(int id) throws Exception {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            User user = enma.find(User.class, id);
            if (user != null) {
                enma.remove(user);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            IN_MEMORY_DB.remove(id);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public User findById(int id) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            return enma.find(User.class, id);
        } catch (Exception e) {
            return IN_MEMORY_DB.get(id);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public User findByUsername(String username) {
        if (username == null) return null;
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<User> query = enma.createQuery("SELECT u FROM User u WHERE u.username = :username", User.class);
            query.setParameter("username", username.trim());
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            for (User u : IN_MEMORY_DB.values()) {
                if (username.trim().equalsIgnoreCase(u.getUsername())) {
                    return u;
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
    public User findByEmail(String email) {
        if (email == null) return null;
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<User> query = enma.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class);
            query.setParameter("email", email.trim());
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            for (User u : IN_MEMORY_DB.values()) {
                if (email.trim().equalsIgnoreCase(u.getEmail())) {
                    return u;
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
    public User findByCode(String code) {
        if (code == null) return null;
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<User> query = enma.createQuery("SELECT u FROM User u WHERE u.code = :code", User.class);
            query.setParameter("code", code.trim());
            List<User> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);
        } catch (Exception e) {
            for (User u : IN_MEMORY_DB.values()) {
                if (code.trim().equals(u.getCode())) {
                    return u;
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
    public List<User> findAll() {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<User> query = enma.createQuery("SELECT u FROM User u", User.class);
            return query.getResultList();
        } catch (Exception e) {
            return new ArrayList<>(IN_MEMORY_DB.values());
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public boolean checkExistEmail(String email) {
        return findByEmail(email) != null;
    }

    @Override
    public boolean checkExistUsername(String username) {
        return findByUsername(username) != null;
    }
}
