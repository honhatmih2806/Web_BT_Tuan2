package vn.edu.hcmute.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Lớp kết nối Cơ sở dữ liệu Microsoft SQL Server (tương thích SQL Server 14.x / 2017+)
 * Hỗ trợ lấy cấu hình từ biến môi trường (Environment Variables) hoặc mặc định.
 */
public class DBContext {

    private static final Logger LOGGER = Logger.getLogger(DBContext.class.getName());

    // Cấu hình mặc định hoặc nhận từ biến môi trường (thích hợp cho Docker/Deploy)
    private static final String HOST = getEnvOrDefault("DB_HOST", "localhost");
    private static final String PORT = getEnvOrDefault("DB_PORT", "1433");
    private static final String DB_NAME = getEnvOrDefault("DB_NAME", "HCMUTE_WebDemo");
    private static final String USER = getEnvOrDefault("DB_USER", "sa");
    private static final String PASSWORD = getEnvOrDefault("DB_PASSWORD", "YourStrong@Passw0rd");

    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = String.format(
            "jdbc:sqlserver://%s:%s;databaseName=%s;encrypt=false;trustServerCertificate=true;characterEncoding=UTF-8;",
            HOST, PORT, DB_NAME
    );

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            LOGGER.log(Level.WARNING, "Không tìm thấy Driver SQL Server: " + DRIVER, e);
        }
    }

    /**
     * Mở và trả về đối tượng kết nối Connection tới SQL Server.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /**
     * Kiểm tra nhanh xem SQL Server có đang hoạt động và kết nối được không.
     */
    public static boolean isAvailable() {
        try (Connection conn = getConnection()) {
            return conn != null && !conn.isClosed();
        } catch (Exception e) {
            return false;
        }
    }

    private static String getEnvOrDefault(String key, String defaultValue) {
        String val = System.getenv(key);
        if (val == null || val.trim().isEmpty()) {
            val = System.getProperty(key);
        }
        return (val != null && !val.trim().isEmpty()) ? val : defaultValue;
    }
}
