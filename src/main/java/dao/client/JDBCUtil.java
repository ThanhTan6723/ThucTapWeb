package dao.client;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.*;

public class JDBCUtil {
    private static final String servername = "localhost";
    private static final int port = 3306;
    private static final String databaseName = "fruits";
    private static final String username = "root";
    private static final String password = "6723";
    static Logger logger = LogManager.getLogger(JDBCUtil.class);

    public static Connection getConnection() {
        Connection c = null;

        try {
            // Đăng ký Driver cho MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Tạo URL kết nối
            String url = "jdbc:mysql://" + servername + ":" + port + "/" + databaseName + "?useSSL=false";
            // Tạo kết nối
            c = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Kết nối thất bại");
        }

        return c;
    }

    public static void closeObject(Statement obj) {
        try {
            if (obj != null) {
                obj.close();
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage(), ex);
        }
    }

    public static void closeObject(ResultSet obj) {
        try {
            if (obj != null) {
                obj.close();
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage(), ex);
        }
    }

    public static void closeObject(Connection obj) {
        try {
            if (obj != null && !obj.isClosed()) {
                if (!obj.getAutoCommit()) {
                    obj.rollback();
                }
                obj.close();
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage(), ex);
        }
    }

    public static void printInfo(Connection c) {
        try {
            if (c != null) {
                DatabaseMetaData metaData = c.getMetaData();
                System.out.println(metaData.getDatabaseProductName());
                System.out.println(metaData.getDatabaseProductVersion());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Connection c = getConnection();
        System.out.println(c);

    }
}
