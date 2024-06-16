package controller.admin.log;

import dao.client.JDBCUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.time.LocalDateTime;
import java.util.List;

public class LogThread extends Task {
    private final Logger logger = LogManager.getLogger(LogThread.class);

    @Override
    public Integer call() throws Exception {
        List lstLog = getItems();
        try {
            if (lstLog != null && !lstLog.isEmpty()) {
                save(lstLog);
            }
        } catch (Exception e) {
            logger.error(e.toString(), e);
            return 0;
        }
        return 1;
    }

    public void save(List<Log> lst) {
        PreparedStatement ps = null;
        Connection con = null;
        try {
            con = JDBCUtil.getConnection();
            ps = con.prepareStatement("INSERT INTO Log (times_tamp, log_level, module, action_type, log_content, affected_table, beforeData, afterData) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)");
            for(Log item : lst){
                ps.setObject(1, LocalDateTime.now());
                ps.setString(2, item.getLogLevel().INFO.toString());
                ps.setString(3, "/controller/LoginControll");
                ps.setString(4, "LOGIN");
                ps.setString(5, "User logged in");
                ps.setString(6, item.getAccount().getTable());
                ps.setString(7, null); // No before data for login
                ps.setString(8, item.getAccount().getAfterData().toString()); // Using toString() for afterData
                ps.executeUpdate();
            }
        } catch (Exception ex) {
            logger.error(ex.getMessage(), ex);
        } finally {
            JDBCUtil.closeObject(ps);
            JDBCUtil.closeObject(con);
        }
    }
}
