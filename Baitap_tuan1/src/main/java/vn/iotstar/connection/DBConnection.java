package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private final String serverName = getEnvOrDefault("DB_HOST", "localhost");
    private final String dbName = getEnvOrDefault("DB_NAME", "BanHang");
    private final String portNumber = getEnvOrDefault("DB_PORT", "1433");
    private final String instance = ""; // MSSQLSERVER LEAVE THIS ONE EMPTY IF SINGLE INSTANCE
    private final String userID = getEnvOrDefault("DB_USER", "sa");
    private final String password = getEnvOrDefault("DB_PASSWORD", "YourStrong@Passw0rd");

    public Connection getConnection() throws Exception {
        String url = "jdbc:sqlserver://" + serverName + ":" + portNumber
                + ";encrypt=false;trustServerCertificate=true;databaseName=" + dbName;
        if (instance != null && !instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance
                    + ";encrypt=false;trustServerCertificate=true;databaseName=" + dbName;
        }
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(url, userID, password);
    }

    private static String getEnvOrDefault(String key, String defaultValue) {
        String val = System.getenv(key);
        if (val == null || val.trim().isEmpty()) {
            val = System.getProperty(key);
        }
        return (val != null && !val.trim().isEmpty()) ? val : defaultValue;
    }
}
