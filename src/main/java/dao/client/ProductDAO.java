package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Category;
import model.Product;

public class ProductDAO {

	public static List<Product> getListProducts() {
		List<Product> list = new ArrayList<>();
		try {
			Connection connect = JDBCUtil.getConnection();

			String sql = "SELECT P.*, C.id AS category_id, C.name AS category_name FROM Products P INNER JOIN Category C ON P.category_id = C.id;";
			PreparedStatement st = connect.prepareStatement(sql);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				Product product = new Product();
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setPrice(rs.getDouble("price"));
				product.setImage(rs.getString("image"));
				product.setDescription(rs.getString("description"));

				Category category = new Category();
				category.setId(rs.getInt("category_id"));
				category.setName(rs.getString("category_name"));
				product.setCategory(category);
				list.add(product);

			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	public static Product getProductById(int pid) {
		String sql = "select * from Products where id=?";
		try {
			Connection connect = JDBCUtil.getConnection();
			PreparedStatement st = connect.prepareStatement(sql);
			st.setInt(1, pid);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				return new Product(rs.getInt(1), rs.getString(2), rs.getFloat(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6)));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println(e);
		}
		return null;

	}


	public static List<Product> getSellProduct() {
		List<Product> list = new ArrayList<>();
		try {
			Connection connect = JDBCUtil.getConnection();

			String sql = "select top 4 * from Products order by price ";
			PreparedStatement st = connect.prepareStatement(sql);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		return list;
	}

	public static List<Product> pagingProduct(int cid, int index, String sort, String type) {
		List<Product> list = new ArrayList<>();
		String query = "";
		int ind = (index - 1) * 8;
		String orderByClause = " ORDER BY " + sort + " " + type +" "+" LIMIT 8 OFFSET"+" "+ind;; // Sắp xếp theo cột được chỉ định theo kiểu được yêu cầu

		switch (cid) {
			case 0:
				query = "SELECT * FROM Products"+orderByClause;
				break;
			case 1:
				query = "SELECT * FROM Products WHERE category_id = 1"+orderByClause;
				break;
			case 2:
				query = "SELECT * FROM Products WHERE category_id = 2"+orderByClause;
				break;
			case 3:
				query = "SELECT * FROM Products WHERE category_id = 3"+orderByClause;
				break;
			case 4:
				query = "SELECT * FROM Products WHERE oldPrice > price";
				break;
			default:
				break;
		}
    	try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {
			// Xử lý ngoại lệ
		}
		return list;
	}
	public int getTotalProduct(int cid) {
		String query = "SELECT COUNT(*) FROM Products ";
		switch (cid) {
			case 0:
				break;
			case 1:
				query += "WHERE category_id = 1";
				break;
			case 2:
				query += "WHERE category_id = 2";
				break;
			case 3:
				query += "WHERE category_id = 3";
				break;

			default:
		}

		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
		}
		return 0;
	}

	public static void removeProduct(String pid) {
		String query = "DELETE FROM Products WHERE id = ?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, pid);
			ps.executeUpdate();
			ps.close();
		} catch (Exception e) {

		}
	}


	public static List<Category> getListCategory() {
		ArrayList<Category> list = new ArrayList<>();
		String query = "select* from Category ";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Category(rs.getInt(1), rs.getString(2)));
			}
		} catch (Exception e) {
		}
		return list;

	}

	public static void updateProduct(Product product) {
		String query = "UPDATE Products SET name = ?, price = ?, image = ?, description = ?, category_id = ? WHERE id = ?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1, product.getName());
			ps.setDouble(2, product.getPrice());
			ps.setString(3, product.getImage());
			ps.setString(4, product.getDescription());
			ps.setInt(5, product.getCategory().getId());
			ps.setInt(6, product.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void insertProduct(Product product) {
		String query = "insert INTO Products (id, name, price, image,description,category_id)\r\n"
				+ "values( ?, ?,?,?, ?,?)";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, product.getId());
			ps.setString(2, product.getName());
			ps.setDouble(3, product.getPrice());
			ps.setString(4, product.getImage());
			ps.setString(5, product.getDescription());
			ps.setInt(6, product.getCategory().getId());
			ps.executeUpdate();
		} catch (Exception e) {
		}
	}
     public static List<Product> relativeProduct(int id){
		List<Product> list = new ArrayList<>();
		String query = "select * from Products where category_id=?";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();

			while (rs.next()){
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		}catch (Exception e){

		}
		return list;
	 }

	public static void main(String[] args) {
//		removeProduct("2");
		List<Product> list1 = ProductDAO.pagingProduct(3, 2,"price", "asc");
		for (Product product : list1) {
			System.out.println(product.toString());
		}
/*		List<Product> list1 = ProductDAO.relativeProduct(1);
		for (Product product : list1) {
			System.out.println(product.toString());
		}*/
//		System.out.println(pd.getTotalProduct(3));
//       System.out.println(pd.getListCategory());
//		updateProduct(new Product(4,"lẫu thái",190.00,null,"ngon nhức nách",new Category(2)));
//		insertProduct(new Product(0,"bánh bèo",170.00,"f1.jpg","ngon lắm",new Category(2)));
/*		List<Product> list = ProductDAO.getListProducts();
		for (Product product : list) {
			System.out.println(product);
		}
		System.out.println(getListProducts());*/
//		System.out.println(pd.getProductById(4));
/*		int count = pd.getTotalProduct();
		System.out.println(count);*/
 /*       List<Product> list = ProductDAO.pagingProduct(1,8,"price","asc");
		System.out.println(list);
*/
	}

}
