package com.civicfix.config;

public final class DatabaseConfig {

    private DatabaseConfig() {
    }

    public static String getJdbcUrl() {
        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String name = System.getenv("DB_NAME");

        if (isBlank(host) || isBlank(port) || isBlank(name)) {
            return "jdbc:h2:mem:civicfix_db;DB_CLOSE_DELAY=-1;MODE=MySQL";
        }

        return "jdbc:mysql://" + host + ":" + port + "/" + name
                + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    }

    public static String getUsername() {
        String user = System.getenv("DB_USER");
        return isBlank(user) ? "sa" : user;
    }

    public static String getPassword() {
        String pass = System.getenv("DB_PASSWORD");
        return isBlank(pass) ? "" : pass;
    }

    public static String getDriverClassName() {
        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String name = System.getenv("DB_NAME");
        return isBlank(host) || isBlank(port) || isBlank(name)
                ? "org.h2.Driver"
                : "com.mysql.cj.jdbc.Driver";
    }

    public static String getHibernateDialect() {
        String host = System.getenv("DB_HOST");
        String port = System.getenv("DB_PORT");
        String name = System.getenv("DB_NAME");
        return isBlank(host) || isBlank(port) || isBlank(name)
                ? "org.hibernate.dialect.H2Dialect"
                : "org.hibernate.dialect.MySQL8Dialect";
    }

    private static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
