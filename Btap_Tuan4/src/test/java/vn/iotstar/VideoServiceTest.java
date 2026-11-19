package vn.iotstar;

import java.util.List;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;
import vn.iotstar.service.IVideoService;
import vn.iotstar.service.impl.VideoServiceImpl;

public class VideoServiceTest {

    private IVideoService videoService;

    @BeforeEach
    public void setUp() {
        videoService = new VideoServiceImpl();
    }

    @Test
    public void testVideoCRUD() throws Exception {
        String vid = "TEST_VID_" + System.currentTimeMillis();

        Video video = new Video();
        video.setVideoId(vid);
        video.setTitle("Video Kiểm Thử Tự Động");
        video.setDescription("Mô tả video kiểm thử");
        video.setViews(10);
        video.setActive(1);

        // 1. Insert
        videoService.insert(video);
        Video retrieved = videoService.findById(vid);
        Assertions.assertNotNull(retrieved);
        Assertions.assertEquals("Video Kiểm Thử Tự Động", retrieved.getTitle());

        // 2. Update
        retrieved.setTitle("Video Cập Nhật Tiêu Đề");
        videoService.update(retrieved);
        Video updated = videoService.findById(vid);
        Assertions.assertEquals("Video Cập Nhật Tiêu Đề", updated.getTitle());

        // 3. Increase views
        int currentViews = updated.getViews();
        videoService.increaseViews(vid);
        Video viewed = videoService.findById(vid);
        Assertions.assertEquals(currentViews + 1, viewed.getViews());

        // 4. Delete
        videoService.delete(vid);
        Assertions.assertNull(videoService.findById(vid));
    }

    @Test
    public void testFindTop10Latest() {
        List<Video> top10 = videoService.findTop10Latest();
        Assertions.assertNotNull(top10);
        Assertions.assertTrue(top10.size() <= 10);
        for (Video v : top10) {
            Assertions.assertEquals(1, v.getActive(), "Chỉ lấy video active");
        }
    }

    @Test
    public void testPagination6ItemsPerPage() {
        // Kiểm thử phân trang 6 sản phẩm/video mỗi trang
        int pageSize = 6;
        List<Video> page1 = videoService.findAll(1, pageSize);
        Assertions.assertNotNull(page1);
        Assertions.assertTrue(page1.size() <= pageSize);
    }
}
