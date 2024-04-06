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

	public static int getTotalProduct(int cid) {
		String query = "";
		switch (cid) {
		case 0:
			query = "select count(*) from products";
			break;
		case 1:
			query = "select count(*) from products where category_id in(1,4,7)";
			break;
		case 2:
			query = "select count(*) from products where category_id in(2,5,8)";
			break;
		case 3:
			query = "select count(*) from products where category_id in(3,6,9)";
			break;
		default:
			break;
		}
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}

		return 0;

	}

	public List<Product> searchByName(String keyword) {
		List<Product> list = new ArrayList<>();
		String query = "SELECT * FROM Products WHERE name LIKE ?";
		try {
			Connection connect = JDBCUtil.getConnection();
			PreparedStatement st = connect.prepareStatement(query);
			st.setString(1, "%" + keyword + "%");
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<Product> searchByPriceMinToMax(String priceMin, String priceMax) {
		List<Product> list = new ArrayList<>();
		String query = "select * from Products where [price] >= ? and [price]<=?";
		try {
			Connection connect = JDBCUtil.getConnection();
			PreparedStatement st = connect.prepareStatement(query);
			st.setString(1, priceMin);
			st.setString(2, priceMax);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {
		}
		return list;
	}

	public List<Product> searchByNameAndPrice(String keyword, String priceMin, String priceMax) {
		List<Product> productList = new ArrayList<>();

		// Kết nối cơ sở dữ liệu và thực hiện truy vấn
		try {
			Connection connect = JDBCUtil.getConnection();
			String query = "SELECT * FROM Products WHERE name LIKE ? AND price >= ? AND price <= ?";
			PreparedStatement statement = connect.prepareStatement(query);
			statement.setString(1, "%" + keyword + "%");
			statement.setString(2, priceMin);
			statement.setString(3, priceMax);

			ResultSet resultSet = statement.executeQuery();

			while (resultSet.next()) {
				int id = resultSet.getInt("id");
				String name = resultSet.getString("name");
				double price = resultSet.getDouble("price");
				String image = resultSet.getString("image");
				String description = resultSet.getString("description");
				Category category = OrderDAO.getCategory(resultSet.getInt("category_id"));

				Product product = new Product(id, name, price, image, description, category);
				productList.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			// Xử lý ngoại lệ hoặc thông báo lỗi nếu cần
		}

		return productList;
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

	public static List<Product> pagingProduct(int cid, String sort, String type) {
		List<Product> list = new ArrayList<>();
		String query = "";
		String orderByClause = "ORDER BY " + sort + " " + type; // Sắp xếp theo cột được chỉ định theo kiểu được yêu cầu

		switch (cid) {
		case 0:
			query = "SELECT * FROM Products " + orderByClause;
			break;
		case 1:
			query = "SELECT * FROM Products WHERE category_id IN(1) " + orderByClause;
			break;
		case 2:
			query = "SELECT * FROM Products WHERE category_id IN(2) " + orderByClause;
			break;
		case 3:
			query = "SELECT * FROM Products WHERE category_id IN(3) " + orderByClause;
			break;
		case 4:
			query = "SELECT * FROM Products WHERE oldPrice > price " + orderByClause;
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
	public int getTotalProduct(){
		String query = "select count(*) from Products";
		try{
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				return  rs.getInt(1);
			}
		}catch (Exception e){

		}
		return 0;
	}
	public static List<Product> pagingProduct(int index){
		List<Product> list = new ArrayList<>();
		String query = "select * from Products order by id limit 8 offset ?;";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			ps.setInt(1,(index-1)*8);
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
//		List<Product> list1 = pd.getSellProduct();
//		for (Product product : list1) {
//			System.out.println(product.toString());
//		}
//		System.out.println(pd.getTotalProduct(3));
//		System.out.println(pagingProduct(3, "price", "asc"));
//       System.out.println(pd.getListCategory());
//		updateProduct(new Product(4,"lẫu thái",190.00,null,"ngon nhức nách",new Category(2)));
//		insertProduct(new Product(0,"bánh bèo",170.00,"f1.jpg","ngon lắm",new Category(2)));
		ProductDAO pd = new ProductDAO();
/*		List<Product> list = ProductDAO.getListProducts();
		for (Product product : list) {
			System.out.println(product);
		}
		System.out.println(getListProducts());*/
//		System.out.println(pd.getProductById(4));
/*		int count = pd.getTotalProduct();
		System.out.println(count);*/
        List<Product> list = ProductDAO.pagingProduct(5);
		System.out.println(list);

	}

}
