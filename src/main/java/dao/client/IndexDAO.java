package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Account;
import model.Category;
import model.Product;
import model.Provider;

public class IndexDAO {
	public static List<Product> getTop8() {
		List<Product> list = new ArrayList<>();
		String query = "SELECT * FROM Products LIMIT 8;";
		try {
			Connection conn =  JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
<<<<<<< HEAD
                list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
                        new Category(rs.getInt(6))) );
=======
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getInt(7),rs.getDouble(8),rs.getDouble(9),AccountDAO.getAccountById(rs.getInt(1)),
						new Provider(rs.getInt(1)),rs.getString(12),rs.getString(13))
				);

>>>>>>> 00301fa2cb20cb3153f77321fea171646624712d
			}
		} catch (Exception e) {

		}

		return list;
	}
public static List<Product> getOutstandingProduct() {
<<<<<<< HEAD
	List<Product> list = new ArrayList<>();
	String query = "SELECT * FROM Products ORDER BY price DESC LIMIT 4;";
	try {
		Connection conn = JDBCUtil.getConnection();
		PreparedStatement ps = conn.prepareStatement(query);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
					new Category(rs.getInt(6))));
		}
=======

		List<Product> list = new ArrayList<>();
		String query = "SELECT * FROM Products ORDER BY price DESC LIMIT 4;";
		try {
			Connection conn =  JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getInt(7),rs.getDouble(8),rs.getDouble(9),AccountDAO.getAccountById(rs.getInt(1)),
						new Provider(rs.getInt(1)),rs.getString(12),rs.getString(13))
				);

>>>>>>> 00301fa2cb20cb3153f77321fea171646624712d
	} catch (SQLException ex) {
		throw new RuntimeException(ex);
	}

		return list;
	}

	public static List<Product> getNext4Product ( int amount){
		List<Product> list = new ArrayList<>();
		String query = "select * from Products where price>40 order by id limit 4 offset ?;";
		try {
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1, amount);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
<<<<<<< HEAD
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6))));
=======
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getInt(7),rs.getDouble(8),rs.getDouble(9),AccountDAO.getAccountById(rs.getInt(1)),
						new Provider(rs.getInt(1)),rs.getString(12),rs.getString(13))
				);

>>>>>>> 00301fa2cb20cb3153f77321fea171646624712d
			}
		} catch (Exception e) {

		}
		return list;

	}
	public static List<Product> listRandProduct () {
		List<Product> list = new ArrayList<>();
		String query = "select * from Products  ORDER BY RAND() LIMIT 3;";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
<<<<<<< HEAD
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6))));
=======
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getInt(7),rs.getDouble(8),rs.getDouble(9),AccountDAO.getAccountById(rs.getInt(1)),
						new Provider(rs.getInt(1)),rs.getString(12),rs.getString(13))
				);

>>>>>>> 00301fa2cb20cb3153f77321fea171646624712d
			}
		} catch (Exception e) {

		}
		return list;

}
	public static List<Product> listRand4Product () {
		List<Product> list = new ArrayList<>();
		String query = "select * from Products  ORDER BY RAND() LIMIT 4;";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
<<<<<<< HEAD
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6))));
=======
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getInt(7),rs.getDouble(8),rs.getDouble(9),AccountDAO.getAccountById(rs.getInt(1)),
						new Provider(rs.getInt(1)),rs.getString(12),rs.getString(13))
				);
>>>>>>> 00301fa2cb20cb3153f77321fea171646624712d
			}
		} catch (Exception e) {

		}
		return list;

}
	public static void main(String[] args){
		IndexDAO pd = new IndexDAO();
/*	List<Product> list = pd.getOutstandingProduct();
	for (Product product : list) {
		System.out.println(product.toString());
	}*/

/*	List<Product> list = pd.listRandProduct();
	for(Product product : list){
		System.out.println(product.toString());
	}*/
		System.out.println(getTop8());
	}

}
