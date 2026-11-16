package vn.iotstar.entity;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "users")
@NamedQueries({
    @NamedQuery(name = "User.findAll", query = "SELECT u FROM User u"),
    @NamedQuery(name = "User.findByUsername", query = "SELECT u FROM User u WHERE u.username = :username"),
    @NamedQuery(name = "User.findByEmail", query = "SELECT u FROM User u WHERE u.email = :email")
})
public class User implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "email", columnDefinition = "nvarchar(200) not null", unique = true)
    private String email;

    @Column(name = "username", columnDefinition = "nvarchar(100) not null", unique = true)
    private String username;

    @Column(name = "fullname", columnDefinition = "nvarchar(200) null")
    private String fullname;

    @Column(name = "password", columnDefinition = "nvarchar(255) not null")
    private String password;

    @Column(name = "avatar", columnDefinition = "nvarchar(500) null")
    private String avatar;

    @Column(name = "roleid")
    private int roleid = 3; // 1: Admin, 2: Manager, 3: User

    @Column(name = "phone", columnDefinition = "nvarchar(50) null")
    private String phone;

    @Column(name = "status")
    private int status = 0; // 0: Chờ kích hoạt OTP, 1: Đã kích hoạt

    @Column(name = "code", columnDefinition = "nvarchar(50) null")
    private String code; // Mã OTP kích hoạt hoặc OTP quên mật khẩu

    @Column(name = "created_date")
    private Date createdDate;

    // Quan hệ 1 - N với bảng Videos (1 user sở hữu nhiều videos)
    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Video> videos = new ArrayList<>();

    public Video addVideo(Video video) {
        if (videos == null) {
            videos = new ArrayList<>();
        }
        videos.add(video);
        video.setUser(this);
        return video;
    }

    public Video removeVideo(Video video) {
        if (videos != null) {
            videos.remove(video);
            video.setUser(null);
        }
        return video;
    }

    // Getters and Setters explicitly provided
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }
}
