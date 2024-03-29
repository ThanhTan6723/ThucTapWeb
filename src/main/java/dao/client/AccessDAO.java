package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Product;

public class AccessDAO {
	public static List<Product> searchByName(String txtSearch) {
		List<Product> list = new ArrayList<>();
		String query = "SELECT * FROM Products WHERE name LIKE ?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + txtSearch + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {
		}

		return list;
	}

	public static int getTotalProductSearch(String txtSearch) {
		String query = " select count(*) from products where  [name] like ?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + txtSearch + "%");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {

		}

		return 0;
	}

	public static List<Product> pagingProductSearch(int index, String txtSearch, String sort, String type) {
		List<Product> list = new ArrayList<>();
		String query = "select * from products  where  [name] like ? order by " + sort + " " + type
				+ " offset ? rows fetch next 12 rows only";

		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, "%" + txtSearch + "%");
			ps.setInt(2, (index - 1) * 12);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {

		}
		return list;
	}

	public static void main(String[] args) {
		AccessDAO a = new AccessDAO();
		List<Product> list = a.searchByName("pizza");
		for (Product product : list) {
			System.out.println(product.toString());
		}
	}
}
