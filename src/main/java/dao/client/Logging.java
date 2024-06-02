package dao.client;

import model.Account;
import model.Log;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDateTime;

public class Logging {

    public static void login(Log log) {
        try (Connection conn = JDBCUtil.getConnection()) {
            String sql = "INSERT INTO Log (times_tamp, log_level, module, action_type, user_id, log_content, affected_table, beforeData, afterData) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setObject(1, LocalDateTime.now());
            ps.setString(2, "INFO");
            ps.setString(3, "/controller/LoginControll");
            ps.setString(4, "LOGIN");
            ps.setInt(5, (log.getAccount().getId()));
            ps.setString(6, "User logged in");
            ps.setString(7, log.getAccount().getTable());
            ps.setString(8, null); // No before data for login
            ps.setString(9, log.getAccount().toString()); // Using toString() for afterData

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void update(IModel model) {
        System.out.println("Table?->" + model.getTable()
                + "\n before: " + model.getBeforeData()
                + "\n after: " + model.getAfterData());
    }

    public static void insert(IModel model) {
        System.out.println("Table?->" + model.getTable()
                + "\n before: " + model.getBeforeData()
                + "\n after: " + model.getAfterData());
    }

    public static void delete(IModel model) {
        System.out.println("Table?->" + model.getTable()
                + "\n before: " + model.getBeforeData()
                + "\n after: " + model.getAfterData());
    }
}
