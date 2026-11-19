package vn.iotstar.config;

import java.util.HashMap;
import java.util.Map;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.PersistenceContext;

@PersistenceContext
public class JpaConfig {

    private static EntityManagerFactory factory;

    public static synchronized EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            Map<String, Object> props = new HashMap<>();

            String host = System.getenv("DB_HOST");
            String port = System.getenv("DB_PORT");
            String db = System.getenv("DB_NAME");
            String user = System.getenv("DB_USER");
            String pass = System.getenv("DB_PASSWORD");

            if (host != null || port != null || db != null) {
                String finalHost = (host != null && !host.isEmpty()) ? host : "localhost";
                String finalPort = (port != null && !port.isEmpty()) ? port : "1433";
                String finalDb = (db != null && !db.isEmpty()) ? db : "webst2";
                String url = String.format("jdbc:sqlserver://%s:%s;encrypt=false;trustServerCertificate=true;databaseName=%s",
                        finalHost, finalPort, finalDb);
                props.put("jakarta.persistence.jdbc.url", url);
            }
            if (user != null && !user.isEmpty()) {
                props.put("jakarta.persistence.jdbc.user", user);
            }
            if (pass != null && !pass.isEmpty()) {
                props.put("jakarta.persistence.jdbc.password", pass);
            }

            factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql", props);
        }
        return factory.createEntityManager();
    }

    public static synchronized void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
