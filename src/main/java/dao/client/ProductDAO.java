package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import model.*;

public class ProductDAO {

    public static List<Review> getListReviewsByProductId(int productId) {
        List<Review> list = new ArrayList<>();
        String query = "Select * from reviews where product_id = ?";
        try {
            Connection con = JDBCUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Review(rs.getInt(1), AccountDAO.getAccountById(rs.getInt(2)), ProductDAO.getProductById(rs.getInt(3)), rs.getInt(4), rs.getString(5), rs.getDate(6)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
				/*	public static List<Product> getListProductById(int categoryId) {
		String sql = "SELECT p.id AS product_id, p.name AS product_name, p.price, p.image, p.description, " +
				"p.category_id, p.weight, " +
				"b.id AS batch_id, b.name AS batch_name, b.manufacturingDate, b.expiryDate, b.dateOfImporting, " +
				"b.quantity, b.priceImport, " +
				"pr.id AS provider_id, pr.name AS provider_name, pr.address AS provider_address, " +
				"a.id AS admin_id, a.name AS admin_name " +
				"FROM Products p " +
				"LEFT JOIN Batch b ON p.id = b.product_id " +
				"LEFT JOIN Providers pr ON b.provider_id = pr.id " +
				"LEFT JOIN Accounts a ON b.adminCreate_id = a.id " +
				"WHERE p.category_id = ?";

		List<Product> productList = new ArrayList<>();
		try (Connection connection = JDBCUtil.getConnection();
			 PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

			preparedStatement.setInt(1, categoryId);
			ResultSet resultSet = preparedStatement.executeQuery();

			while (resultSet.next()) {
				// Tạo một đối tượng Category từ dữ liệu kết quả
				Category category = new Category(resultSet.getInt("category_id"));

				// Tạo một đối tượng Provider từ dữ liệu kết quả
				Provider provider = new Provider(resultSet.getInt("provider_id"), resultSet.getString("provider_name"), resultSet.getString("provider_address"));

				// Tạo một đối tượng Account từ dữ liệu kết quả
				Account adminCreate = new Account(resultSet.getInt("admin_id"), resultSet.getString("admin_name"));

				// Tạo một đối tượng Batch từ dữ liệu kết quả
				Batch batch = new Batch(
						resultSet.getInt("batch_id"),
						resultSet.getInt("product_id"),
						resultSet.getString("batch_name"),
						resultSet.getDate("manufacturingDate"),
						resultSet.getDate("expiryDate"),
						resultSet.getDate("dateOfImporting"),
						resultSet.getInt("quantity"),
						resultSet.getDouble("priceImport"),
						provider,
						adminCreate
				);

				// Kiểm tra xem sản phẩm đã tồn tại trong danh sách chưa
				boolean found = false;
				for (Product product : productList) {
					if (product.getId() == resultSet.getInt("product_id")) {
						// Đã tồn tại, thêm lô hàng vào danh sách của sản phẩm
						product.getBatches().add(batch);
						found = true;
						break;
					}
				}

				if (!found) {
					// Chưa tồn tại, tạo một đối tượng Product mới và thêm vào danh sách sản phẩm
					Product product = new Product(
							resultSet.getInt("product_id"),
							resultSet.getString("product_name"),
							resultSet.getDouble("price"),
							resultSet.getString("image"),
							resultSet.getString("description"),
							category,
							resultSet.getDouble("weight")
					);
					// Thêm lô hàng vào danh sách của sản phẩm
					product.getBatches().add(batch);
					productList.add(product);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return productList;
	}*/
/*public static Product getProductById(int pid) {
	String productSql = "SELECT * FROM Products WHERE id=?";
	String batchSql = "SELECT * FROM Batch WHERE product_id=?";
	String providerSql = "SELECT * FROM Providers WHERE id=?";

	try {
		Connection connect = JDBCUtil.getConnection();

		// Lấy thông tin sản phẩm từ cơ sở dữ liệu
		PreparedStatement productStatement = connect.prepareStatement(productSql);
		productStatement.setInt(1, pid);
		ResultSet productResultSet = productStatement.executeQuery();

		if (productResultSet.next()) {
			// Lấy thông tin cơ bản của sản phẩm từ ResultSet
			Product product = new Product(
					productResultSet.getInt(1),
					productResultSet.getString(2),
					productResultSet.getDouble(3),
					productResultSet.getString(4),
					productResultSet.getString(5),
					new Category(productResultSet.getInt(6)),
					productResultSet.getDouble(7),
					productResultSet.getDouble(8),null,null
			);

			// Lấy thông tin về Provider
			PreparedStatement providerStatement = connect.prepareStatement(providerSql);
			providerStatement.setInt(1, productResultSet.getInt(10));
			ResultSet providerResultSet = providerStatement.executeQuery();
			if (providerResultSet.next()) {
				// Tạo đối tượng Provider và thiết lập cho sản phẩm
				Provider provider = new Provider(
						providerResultSet.getInt(1),
						providerResultSet.getString(2),
						providerResultSet.getString(3)
				);
				product.setProvider(provider);
			}

			// Lấy danh sách các Batch tương ứng với sản phẩm
			PreparedStatement batchStatement = connect.prepareStatement(batchSql);
			batchStatement.setInt(1, pid);
			ResultSet batchResultSet = batchStatement.executeQuery();
			while (batchResultSet.next()) {
				// Tạo các đối tượng Batch và thêm vào danh sách
				Batch batch = new Batch(
						batchResultSet.getInt(1),
						batchResultSet.getInt(2),
						batchResultSet.getString(3),
						batchResultSet.getDate(4),
						batchResultSet.getDate(5),
						batchResultSet.getDate(6),
						batchResultSet.getInt(7),
						batchResultSet.getDouble(8)
				);
				product.addBatch(batch);
			}

			// Trả về sản phẩm đã được điền đầy đủ thông tin
			return product;
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}

	return null;
}*/

	public static List<Product> getSellProduct() {
		List<Product> list = new ArrayList<>();
		try {
			Connection connect = JDBCUtil.getConnection();

			String sql = "select top 4 * from Products order by price ";
			PreparedStatement st = connect.prepareStatement(sql);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getDouble(7)) );
			}
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
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
				return new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)), rs.getDouble(7));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return null;
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
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getDouble(7)) );
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

			while (rs.next()) {
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getDouble(7)) );
			}
		}catch (Exception e){

		}
		return list;
	 }
	public static List<Image> listImageProduct(int id) {
		List<Image> list = new ArrayList<>();
		String sql = "SELECT * FROM Images " +
				"INNER JOIN ProductImages ON Images.id = ProductImages.imageId WHERE ProductImages.productId = ?";
		try (Connection con = JDBCUtil.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				int imageId = rs.getInt("id");
				String imageUrl = rs.getString("imgAssetId");
				list.add(new Image(imageId, imageUrl));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			// Xử lý ngoại lệ một cách thích hợp, ví dụ: ghi log và/hoặc thông báo cho người dùng
		}
		return list;
	}
	public static String getCategoryById(int id ){
		String sql = "select name from Category where id=?";
		try {
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()){
				return rs.getString("name");
			}
		}catch (Exception e){

		}
		return null;
	}
	public static Category getCategoryById1(int id){
		String sql = "select * from Category where id=?";
		try {
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			while(rs.next()) {
				return new Category(rs.getInt(1), rs.getString(2));
			}
			} catch (SQLException ex) {
        }

		return null;
	}

	public static Provider getInforByIdProvider(int id){
		String sql = "select * from Providers where id=?";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()){
				return new Provider(rs.getInt(1),rs.getString(2),rs.getString(3));
			}

		}catch (Exception e){

		}
		return null;
	}

	public static List<Product> getListProducts() {
		List<Product> list = new ArrayList<>();
		String query = "       SELECT *\n" +
				"FROM Products\n" +
				"WHERE id IN (\n" +
				"    SELECT DISTINCT product_id\n" +
				"    FROM Batch\n" +
				"    WHERE expiryDate > CURDATE()\n" +
				");";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(query);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getDouble(7)) );
			}
		}catch (Exception e){

		}
		return list;
	}

    public static List<Provider> getListProvider(){
		List<Provider> providerList = new ArrayList<>();
		String sql = "select * from Providers";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				providerList.add(new Provider(rs.getInt(1),rs.getString(2),rs.getString(3)));
			}
		}catch (Exception e){

		}
		return providerList;
	}

	public static List<Product> getListExpiredProduct(){
		List<Product> list = new ArrayList<>();
		String sql = "SELECT * FROM Products WHERE expriredDay <= CURDATE() ORDER BY dateOfImporting ASC";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs= ps.executeQuery();
			while (rs.next()) {
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6)),rs.getDouble(7)) );
			}
		}catch (Exception e){

		}
		return list;
	}
	public static List<Batch> getListBatchById(int id) {
		List<Batch> list = new ArrayList<>();
		String sql = "SELECT b.id, b.product_id, b.name, b.manufacturingDate, b.expiryDate, b.dateOfImporting, " +
				"b.quantity, b.priceImport, p.id AS provider_id, p.name AS provider_name, p.address AS provider_address, " +
				"a.id AS admin_id, a.name AS admin_name " +
				"FROM Batch b " +
				"JOIN Providers p ON b.provider_id = p.id " +
				"JOIN Accounts a ON b.adminCreate_id = a.id " +
				"WHERE b.product_id = ? AND b.expiryDate > CURDATE()";
		try {
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				Provider provider = new Provider(rs.getInt("provider_id"), rs.getString("provider_name"), rs.getString("provider_address"));
				Account adminCreate = new Account(rs.getInt("admin_id"), rs.getString("admin_name")); // Giả sử Account có constructor với các tham số này
				Batch batch = new Batch(
						rs.getInt(1),
						rs.getInt(2),
						rs.getString(3),
						rs.getDate(4),
						rs.getDate(5),
						rs.getDate(6),
						rs.getInt(7),
						rs.getDouble(8),
						provider,
						adminCreate
				);
				list.add(batch);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	public static void removeProduct(int pid) {
		String query = "DELETE FROM Products WHERE id = ?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, pid);
			ps.executeUpdate();
		} catch (Exception e) {

		}
	}
	public static Batch getBatchById(int id){
		String sql = "select * from Batch where id = ?";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1,id);
			ResultSet rs = ps.executeQuery();
			if(rs.next()){
				return  new Batch(rs.getInt(1),rs.getInt(2),rs.getString(3),rs.getDate(4),rs.getDate(5),rs.getDate(6),rs.getInt(7),rs.getDouble(8),
						new Provider(rs.getInt(11)),new Account(rs.getInt(9)));
			}
		}catch (Exception e) {

		}
		return null;
	}

	public static void updateProductAndBatches(Product product, List<Batch> updatedBatches,int id) {
		String updateProductSQL = "UPDATE Products SET name = ?, price = ?, image = ?, description = ?, category_id = ?, weight = ? WHERE id = ?";
		String updateBatchSQL = "UPDATE Batch SET manufacturingDate = ?, expiryDate = ?, dateOfImporting = ?, quantity = ?, priceImport = ?, provider_id=? WHERE id = ?";

		try (Connection conn = JDBCUtil.getConnection();
			 PreparedStatement psProduct = conn.prepareStatement(updateProductSQL);
			 PreparedStatement psBatch = conn.prepareStatement(updateBatchSQL)) {
			conn.setAutoCommit(false);
			// Cập nhật thông tin sản phẩm
			psProduct.setString(1, product.getName());
			psProduct.setDouble(2, product.getPrice());
			psProduct.setString(3, product.getImage());
			psProduct.setString(4, product.getDescription());
			psProduct.setInt(5, product.getCategory().getId());
			psProduct.setDouble(6, product.getWeight());
			psProduct.setInt(7, product.getId());
			psProduct.executeUpdate();

			// Cập nhật thông tin các lô hàng
			for (Batch batch : updatedBatches) {
				// Kiểm tra xem trường provider của batch có null hay không
				System.out.println(batch);
				psBatch.setDate(1, new java.sql.Date(batch.getManufacturingDate().getTime()));
				psBatch.setDate(2, new java.sql.Date(batch.getExpiryDate().getTime()));
				psBatch.setDate(3, new java.sql.Date(batch.getDateOfImporting().getTime()));
				psBatch.setInt(4, batch.getQuantity());
				psBatch.setDouble(5, batch.getPriceImport());
				psBatch.setInt(6,batch.getProvider().getId());
				psBatch.setInt(7, id);
				psBatch.addBatch();
			}
			psBatch.executeBatch();

			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			// Rollback trong trường hợp có lỗi xảy ra
		}
	}
	public static Provider getProviderById(int providerId) {
		String sql = "SELECT * FROM Providers WHERE id = ?";
		Provider provider = null;

		try (Connection conn = JDBCUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, providerId);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				provider = new Provider(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getString("address")
				);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return provider;
	}


	public static Product getProductWithBatchesById(int id) {
		Product product = null;
		String productSql = "SELECT * FROM Products WHERE id=?";
		String batchSql = "SELECT b.id, b.name, b.manufacturingDate, b.expiryDate, b.dateOfImporting, " +
				"b.quantity, b.priceImport, p.id AS provider_id, p.name AS provider_name, p.address AS provider_address, " +
				"a.id AS admin_id, a.name AS admin_name " +
				"FROM Batch b " +
				"JOIN Providers p ON b.provider_id = p.id " +
				"JOIN Accounts a ON b.adminCreate_id = a.id " +
				"WHERE b.product_id = ? AND b.expiryDate > CURDATE()";

		Connection conn = null;
		PreparedStatement productStatement = null;
		PreparedStatement batchStatement = null;
		ResultSet productResultSet = null;
		ResultSet batchResultSet = null;

		try {
			conn = JDBCUtil.getConnection();

			// Lấy thông tin sản phẩm từ bảng Products
			productStatement = conn.prepareStatement(productSql);
			productStatement.setInt(1, id);
			productResultSet = productStatement.executeQuery();

			if (productResultSet.next()) {
				// Tạo đối tượng Product từ dữ liệu trong ResultSet
				product = new Product(
						productResultSet.getInt("id"),
						productResultSet.getString("name"),
						productResultSet.getDouble("price"),
						productResultSet.getString("image"),
						productResultSet.getString("description"),
						new Category(productResultSet.getInt("category_id")),
						productResultSet.getDouble("weight"),
						new ArrayList<>(), // Danh sách images sẽ được cập nhật sau
						new ArrayList<>() // Danh sách batches sẽ được cập nhật sau
				);

				// Lấy danh sách các Batch từ bảng Batch
				batchStatement = conn.prepareStatement(batchSql);
				batchStatement.setInt(1, id);
				batchResultSet = batchStatement.executeQuery();
				while (batchResultSet.next()) {
					// Tạo đối tượng Batch và thêm vào danh sách của Product
					Provider provider = new Provider(
							batchResultSet.getInt("provider_id"),
							batchResultSet.getString("provider_name"),
							batchResultSet.getString("provider_address")
					);
					Account adminCreate = new Account(
							batchResultSet.getInt("admin_id"),
							batchResultSet.getString("admin_name")
					);
					Batch batch = new Batch(
							batchResultSet.getInt("id"),
							id, // product_id
							batchResultSet.getString("name"),
							batchResultSet.getDate("manufacturingDate"),
							batchResultSet.getDate("expiryDate"),
							batchResultSet.getDate("dateOfImporting"),
							batchResultSet.getInt("quantity"),
							batchResultSet.getDouble("priceImport"),
							provider,
							adminCreate
					);
					product.addBatch(batch);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return product;
	}
     public static void main(String[] args) {

			System.out.println(getProductWithBatchesById(2));

			List<Batch> updatedBatches = new ArrayList<>();
			updatedBatches.add(new Batch(1, 1, "B001", new Date(110, 3, 10), new Date(110, 4, 10), new Date(110, 3, 12), 100, 12.34, new Provider(3, "cuimia", "cuimia")));
			updatedBatches.add(new Batch(4, 3, "B002", new Date(115, 3, 10), new Date(112, 4, 18), new Date(112, 0, 24), 500, 4.56, new Provider(3, "hehe", "hehe")));

			updateProductAndBatches(new Product(2,"hihi",12.00,"hehe","hehe",new Category(1,"hehe"),4.00),updatedBatches,4);
			System.out.println(getProductWithBatchesById(2));

			
	}

}

