package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Product;

public class IndexDAO {
    public static List<Product> getTop8() {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products LIMIT 8;";
        try {
            Connection conn = JDBCUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
                        new Category(rs.getInt(6)))
                );

            }
        } catch (Exception e) {

        }

        return list;
    }

    public static List<Product> getOutstandingProduct() {

        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products ORDER BY price DESC LIMIT 4;";
        try {
            Connection conn = JDBCUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
                        new Category(rs.getInt(6)))
                );
            }
            return list;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static List<Product> getNext4Product(int amount) {
        List<Product> list = new ArrayList<>();
        String query = "select * from Products where price>40 order by id limit 4 offset ?;";
        try {
            Connection con = JDBCUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, amount);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
                        new Category(rs.getInt(6)))
                );
            }
        } catch (Exception e) {
        }
        return list;
    }

    public static List<Product> listRandProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Products  ORDER BY RAND() LIMIT 3;";
        try {
            Connection conn = JDBCUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
                        new Category(rs.getInt(6)))
                );

            }
        } catch (Exception e) {

        }
        return list;

    }

    public static List<Product> listRand4Product() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Products  ORDER BY RAND() LIMIT 4;";
        try {
            Connection conn = JDBCUtil.getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
                        new Category(rs.getInt(6)))
                );
            }
        } catch (Exception e) {

        }
        return list;

    }

	public static List<Product> getTop8() {
		List<Product> list = new ArrayList<>();
		String query = "SELECT * FROM Products ORDER BY price DESC LIMIT 8;";
		try {
			Connection conn =  JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
                list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
                        new Category(rs.getInt(6))) );

			}
		} catch (Exception e) {

		}
		return list;
	}
public static List<Product> getOutstandingProduct() {
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
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6))));

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
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getInt(7),rs.getDouble(8),rs.getDouble(9),AccountDAO.getAccountById(rs.getInt(1)),
						new Provider(rs.getInt(1)),rs.getString(12),rs.getString(13))
				);
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
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6))));


			}
		} catch (Exception e) {

		}
		return list;

}
	public static void main(String[] args){
		IndexDAO pd = new IndexDAO();
        System.out.println(getTop8());
    }

}
