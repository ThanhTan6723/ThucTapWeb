package dao.client;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
	private static final String servername = "localhost";
	private static final int port = 3306;
	private static final String databaseName = "fruit";
	private static final String username = "root";
	private static final String password = "6723";

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

	public static void closeConnection(Connection c) {
		try {
			if (c != null) {
				c.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
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

		// Đóng kết nối
		closeConnection(c);

	}
}
