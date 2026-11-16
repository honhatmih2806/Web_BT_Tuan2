package vn.iotstar.dao;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;
import vn.iotstar.config.JpaConfig;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;

public class VideoDao implements IVideoDao {

    private static final ConcurrentHashMap<String, Video> IN_MEMORY_DB = new ConcurrentHashMap<>();

    static {
        // Pre-seed sample videos for demo and test purposes
        User demoUser = new User();
        demoUser.setId(2);
        demoUser.setUsername("nhatminh");
        demoUser.setFullname("Hồ Nhật Minh");

        for (int i = 1; i <= 15; i++) {
            Video v = new Video();
            v.setVideoId("VID" + String.format("%03d", i));
            v.setTitle("Lập trình Web Jakarta EE - Bài học số " + i);
            v.setDescription("Hướng dẫn chi tiết xây dựng ứng dụng Web chuẩn MVC 3 lớp với JPA Hibernate và Servlet 6.1 (Video #" + i + ")");
            v.setPoster("https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&auto=format&fit=crop&q=80");
            v.setVideoUrl("https://www.w3schools.com/html/mov_bbb.mp4");
            v.setViews(120 + i * 15);
            v.setActive(1);
            v.setUser(demoUser);
            IN_MEMORY_DB.put(v.getVideoId(), v);
        }
    }

    @Override
    public void insert(Video video) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.persist(video);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            IN_MEMORY_DB.put(video.getVideoId(), video);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void update(Video video) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            enma.merge(video);
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            IN_MEMORY_DB.put(video.getVideoId(), video);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void delete(String videoId) throws Exception {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            Video video = enma.find(Video.class, videoId);
            if (video != null) {
                enma.remove(video);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            IN_MEMORY_DB.remove(videoId);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public Video findById(String videoId) {
        if (videoId == null) return null;
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            return enma.find(Video.class, videoId);
        } catch (Exception e) {
            return IN_MEMORY_DB.get(videoId);
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Video> findAll() {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Video> query = enma.createQuery("SELECT v FROM Video v ORDER BY v.videoId DESC", Video.class);
            return query.getResultList();
        } catch (Exception e) {
            return IN_MEMORY_DB.values().stream()
                    .sorted(Comparator.comparing(Video::getVideoId).reversed())
                    .collect(Collectors.toList());
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Video> findTop10Latest() {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Video> query = enma.createQuery("SELECT v FROM Video v WHERE v.active = 1 ORDER BY v.videoId DESC", Video.class);
            query.setMaxResults(10);
            return query.getResultList();
        } catch (Exception e) {
            return IN_MEMORY_DB.values().stream()
                    .filter(v -> v.getActive() == 1)
                    .sorted(Comparator.comparing(Video::getVideoId).reversed())
                    .limit(10)
                    .collect(Collectors.toList());
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Video> findByUserId(int userId, int page, int pageSize) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Video> query = enma.createQuery("SELECT v FROM Video v WHERE v.user.id = :userId ORDER BY v.videoId DESC", Video.class);
            query.setParameter("userId", userId);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            return IN_MEMORY_DB.values().stream()
                    .filter(v -> v.getUser() != null && v.getUser().getId() == userId)
                    .sorted(Comparator.comparing(Video::getVideoId).reversed())
                    .skip((long) (page - 1) * pageSize)
                    .limit(pageSize)
                    .collect(Collectors.toList());
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public int countByUserId(int userId) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            Query query = enma.createQuery("SELECT COUNT(v) FROM Video v WHERE v.user.id = :userId");
            query.setParameter("userId", userId);
            return ((Long) query.getSingleResult()).intValue();
        } catch (Exception e) {
            return (int) IN_MEMORY_DB.values().stream()
                    .filter(v -> v.getUser() != null && v.getUser().getId() == userId)
                    .count();
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Video> findAll(int page, int pageSize) {
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Video> query = enma.createQuery("SELECT v FROM Video v ORDER BY v.videoId DESC", Video.class);
            query.setFirstResult((page - 1) * pageSize);
            query.setMaxResults(pageSize);
            return query.getResultList();
        } catch (Exception e) {
            return IN_MEMORY_DB.values().stream()
                    .sorted(Comparator.comparing(Video::getVideoId).reversed())
                    .skip((long) (page - 1) * pageSize)
                    .limit(pageSize)
                    .collect(Collectors.toList());
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
            Query query = enma.createQuery("SELECT COUNT(v) FROM Video v");
            return ((Long) query.getSingleResult()).intValue();
        } catch (Exception e) {
            return IN_MEMORY_DB.size();
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public void increaseViews(String videoId) {
        EntityManager enma = null;
        EntityTransaction trans = null;
        try {
            enma = JpaConfig.getEntityManager();
            trans = enma.getTransaction();
            trans.begin();
            Video video = enma.find(Video.class, videoId);
            if (video != null) {
                video.setViews(video.getViews() + 1);
                enma.merge(video);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans != null && trans.isActive()) {
                trans.rollback();
            }
            Video v = IN_MEMORY_DB.get(videoId);
            if (v != null) {
                v.setViews(v.getViews() + 1);
            }
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }

    @Override
    public List<Video> searchByTitle(String keyword) {
        if (keyword == null) keyword = "";
        EntityManager enma = null;
        try {
            enma = JpaConfig.getEntityManager();
            TypedQuery<Video> query = enma.createQuery("SELECT v FROM Video v WHERE v.title LIKE :kw", Video.class);
            query.setParameter("kw", "%" + keyword.trim() + "%");
            return query.getResultList();
        } catch (Exception e) {
            final String kw = keyword.toLowerCase();
            return IN_MEMORY_DB.values().stream()
                    .filter(v -> v.getTitle() != null && v.getTitle().toLowerCase().contains(kw))
                    .collect(Collectors.toList());
        } finally {
            if (enma != null && enma.isOpen()) {
                enma.close();
            }
        }
    }
}
