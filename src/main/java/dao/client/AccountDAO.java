package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Account;

public class AccountDAO extends AbsDAO<Account> {

    public Account findByEmail(String email) {
        String sql = "SELECT * FROM Accounts WHERE email = ?";
        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setId(rs.getInt("id"));
                account.setName(rs.getString("name"));
                account.setEmail(rs.getString("email"));
                account.setPassword(rs.getString("password"));
                account.setIsAdmin(rs.getInt("isAdmin"));
                return account;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int insert(Account acc) {
        return super.insert(acc);
    }

    public ArrayList<Account> selectAll() {
        ArrayList<Account> result = new ArrayList<Account>();
        try {
            // 1.connect to database
            Connection connect = JDBCUtil.getConnection();

            // 2.create object statement
            String sql = "Select * From Accounts";
            PreparedStatement preSt = connect.prepareStatement(sql);

            // 3.excute function sql
            ResultSet rs = preSt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String telephone = rs.getString("phonenumber");
                int isAdmin = rs.getInt("isAdmin");

                Account cus = new Account(id, name, password, email, telephone, isAdmin);
                result.add(cus);
            }
            JDBCUtil.closeConnection(connect);

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return result;
    }

    public Account selectByName(Account t) {
        Account res = null;
        try {
            // 1.connect to database
            Connection connect = JDBCUtil.getConnection();

            // 2.create object statement
            String sql = "Select * From Customers Where name=?";
            PreparedStatement preSt = connect.prepareStatement(sql);
            preSt.setString(1, t.getName());
            ;

            // 3.excute function sql
            ResultSet rs = preSt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String telephone = rs.getString("phonenumber");
                int isAdmin = rs.getInt("isAdmin");

                Account cus = new Account(id, name, password, email, telephone, isAdmin);
                System.out.println(cus);
            }
            JDBCUtil.closeConnection(connect);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return res;
    }

    @Override
    public Account login(Account acc) {
        Account account = null;
        try {
            Connection connect = JDBCUtil.getConnection();

            String sql = "Select * From Accounts Where name=? And password=?";

            PreparedStatement preSt = connect.prepareStatement(sql);
            preSt.setString(1, acc.getName());
            preSt.setString(2, acc.getPassword());

            // 3.excute function sql
            ResultSet rs = preSt.executeQuery();
            super.login(acc);

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String telephone = rs.getString("phonenumber");
                int isAdmin = rs.getInt("isAdmin");

                account = new Account(id, name, password, email, telephone, isAdmin);
                System.out.println(acc);
            }
//			JDBCUtil.closeConnection(connect);

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return account;
    }


    public static Account checkLogin(String username, String pass) {
        Account acc = null;
        try {
            // 1.connect to database
            Connection connect = JDBCUtil.getConnection();

            // 2.create object statement
            String sql = "Select * From Accounts Where name=? And password=?";

            PreparedStatement preSt = connect.prepareStatement(sql);
            preSt.setString(1, username);
            preSt.setString(2, pass);

            // 3.excute function sql
            ResultSet rs = preSt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String telephone = rs.getString("phonenumber");
                int isAdmin = rs.getInt("isAdmin");

                acc = new Account(id, name, password, email, telephone, isAdmin);
                System.out.println(acc);
            }
//			JDBCUtil.closeConnection(connect);

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return acc;
    }

    public static int insertAccount(Account t) {
        int res = 0;
        try {
            Connection connection = JDBCUtil.getConnection();

            String sql = "INSERT INTO Accounts(name,password,email,phonenumber,isAdmin)" + "VALUES(?,?,?,?,?)";

            PreparedStatement prSt = connection.prepareStatement(sql);

            prSt.setString(1, t.getName());
            prSt.setString(2, t.getPassword());
            prSt.setString(3, t.getEmail());
            prSt.setString(4, t.getTelephone());
            prSt.setInt(5, t.getIsAdmin());
//			prSt.setInt(6, t.getIsDeleted());

            res = prSt.executeUpdate();

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return res;
    }

    public int delete(Account t) {
        int res = 0;
        try {
            Connection connect = JDBCUtil.getConnection();

            String sql = "DETELE From " + "Where name=?";

            PreparedStatement prSt = connect.prepareStatement(sql);
            prSt.setString(1, t.getName());

            res = prSt.executeUpdate();

            JDBCUtil.closeConnection(connect);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return res;
    }

        public int update(Account t) {
        int res = 0;
        try {
            Connection connect = JDBCUtil.getConnection();

            String sql = "UPDATE Accounts " + "SET" + " password=?" + "WHERE email=?";

            PreparedStatement prSt = connect.prepareStatement(sql);
            prSt.setString(1, t.getPassword());
            prSt.setString(2, t.getEmail());

            res = prSt.executeUpdate();

            JDBCUtil.closeConnection(connect);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return res;
    }

    public static int updateProfile(Account t) {
        int res = 0;
        try {
            Connection connect = JDBCUtil.getConnection();

            String sql = "UPDATE Accounts " + "SET" + " name=?, email=?, phonenumber=? " + "WHERE id=?";

            PreparedStatement prSt = connect.prepareStatement(sql);
            prSt.setString(1, t.getName());
            prSt.setString(2, t.getEmail());
            prSt.setString(3, t.getTelephone());
            prSt.setInt(4, t.getId());

            res = prSt.executeUpdate();

            JDBCUtil.closeConnection(connect);

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }

        return res;
    }

    public static boolean checkUserName(String userName) {
        boolean res = false;

        try {
            Connection connect = JDBCUtil.getConnection();

            String sql = "SELECT * FROM Accounts WHERE name=?";
            PreparedStatement prSt = connect.prepareStatement(sql);
            prSt.setString(1, userName);
//			prSt.setString(2, email);
//			prSt.setString(3, telephone);

            ResultSet rs = prSt.executeQuery();
//			System.out.println(rs);
            while (rs.next()) {
                res = true;
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return res;
    }

    public static boolean checkEmail(String email) {
        boolean res = false;

        try {
            Connection connect = JDBCUtil.getConnection();

            String sql = "SELECT * FROM Accounts WHERE email=?";
            PreparedStatement prSt = connect.prepareStatement(sql);
            prSt.setString(1, email);

            ResultSet rs = prSt.executeQuery();

            while (rs.next()) {
                res = true;
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return res;
    }

    public static boolean checkPass(String pass) {
        boolean res = false;
        try {
            Connection connect = JDBCUtil.getConnection();

            String sql = "SELECT * FROM Accounts WHERE password=?";
            PreparedStatement prSt = connect.prepareStatement(sql);
            prSt.setString(1, pass);

            System.out.println(sql);
            ResultSet rs = prSt.executeQuery();

            while (rs.next()) {
                res = true;
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return res;

    }

    public static Account getAccountById(int id) {
        try {
            // 1.connect to database
            Connection connect = JDBCUtil.getConnection();

            // 2.create object statement
            String sql = "Select * From Accounts Where id=?";
            PreparedStatement preSt = connect.prepareStatement(sql);
            preSt.setInt(1, id);

            // 3.excute function sql
            ResultSet rs = preSt.executeQuery();

            while (rs.next()) {
                int accId = rs.getInt("id");
                String name = rs.getString("name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String telephone = rs.getString("phonenumber");
                int isAdmin = rs.getInt("isAdmin");

                return new Account(accId, name, password, email, telephone, isAdmin);
            }
//			JDBCUtil.closeConnection(connect);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public static Account getAccount(String name, String pass) {
        String sql = "select * from Accounts where name=? and password=?";
        try {
            Connection connect = JDBCUtil.getConnection();

            PreparedStatement st = connect.prepareStatement(sql);
            st.setString(1, name);
            st.setString(2, pass);

            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("name");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String telephone = rs.getString("phonenumber");
                int isAdmin = rs.getInt("isAdmin");

                return new Account(id, username, password, email, telephone, isAdmin);
            }
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println(e);
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.println(checkUserName("thanhtan"));
        AccountDAO acc = new AccountDAO();
        System.out.println(acc.selectAll());
        System.out.println(checkLogin("capy","123"));

    }
}
