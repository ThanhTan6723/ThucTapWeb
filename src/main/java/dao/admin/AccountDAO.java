package dao.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dao.client.JDBCUtil;
import model.Account;

public class AccountDAO {
	public static List<Account> getListAccount() {
		ArrayList<Account> list = new ArrayList<>();
		String query = "select * from Accounts where isAdmin=0";
		try {
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Account(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getInt(6)));
			}
		} catch (Exception e) {

		}
		return list;
	}

	public static Account getAccountById(String uid) {
		String query = "select * from Accounts where id = ? ";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, uid);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return new Account(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
						rs.getInt(6));
			}
		} catch (Exception e) {
		}
		return null;
	}

	public static void removeAccount(int id) {
		String query = "DELETE FROM Accounts Where id = ?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			ps.executeUpdate();
		} catch (Exception e) {

		}
	}

	public static int updateAccount(String name) {
		int re = 0;
		String query = "update Accounts set isAdmin=? where name =?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, 1);
			ps.setString(2, name);
			re = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}

	public static void main(String[] args) {
		AccountDAO a = new AccountDAO();
		// removeAccount("1");
//		updateAccount(new Account(1, "maisuong", "maisuong", 0, "maisuong@gmail.com", "dian", "01453256"));
		List<Account> list = a.getListAccount();
		for (Account account : list) {
			System.out.println(account.toString());
		}

		System.out.println(updateAccount("thanhtan67"));;
	}
}
