package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.entity.Video;

public interface IVideoDao {
    void insert(Video video);
    void update(Video video);
    void delete(String videoId) throws Exception;
    Video findById(String videoId);
    List<Video> findAll();
    List<Video> findTop10Latest();
    List<Video> findByUserId(int userId, int page, int pageSize);
    int countByUserId(int userId);
    List<Video> findAll(int page, int pageSize);
    int count();
    void increaseViews(String videoId);
    List<Video> searchByTitle(String keyword);
}
