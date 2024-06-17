package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import model.*;

public class ProductDAO {

    private static final String INSERT_REVIEW_SQL = "INSERT INTO Reviews (name_commenter, phonenumber_commenter, product_id, rating, comment,image, date_created) VALUES (?, ?, ?, ?, ?,?,?)";

    public static void saveReview(Review review) {
        try (Connection connection = JDBCUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_REVIEW_SQL)) {
            preparedStatement.setString(1, review.getNameCommenter());
            preparedStatement.setString(2, review.getPhoneNumberCommenter());
            preparedStatement.setInt(3, review.getProductEvaluated().getId());
            preparedStatement.setInt(4, review.getRating());
            preparedStatement.setString(5, review.getComment());
            preparedStatement.setString(6, review.getImage());
            preparedStatement.setString(7, review.getDateCreated());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static Map<Integer, Integer> getReviewStatistics(int productId) {
        Map<Integer, Integer> statistics = new HashMap<>();
        String query = "SELECT rating, COUNT(*) AS count FROM reviews WHERE product_id = ? GROUP BY rating";

        try (Connection conn = JDBCUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    statistics.put(rs.getInt("rating"), rs.getInt("count"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return statistics;
    }

    public static List<Review> getListReviewsByProductId(int productId) {
        List<Review> list = new ArrayList<>();
        String query = "SELECT * FROM reviews WHERE product_id = ? ORDER BY date_created DESC";
        try {
            Connection con = JDBCUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, productId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Review(rs.getInt(1), rs.getString(2), rs.getString(3), ProductDAO.getProductById(rs.getInt(4)), rs.getInt(5), rs.getString(6), rs.getString(7), rs.getString(8)));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

  public static List<Product> getSellProduct() {
		List<Product> list = new ArrayList<>();
		try {
			Connection connect = JDBCUtil.getConnection();

			String sql = "select top 4 * from Products order by price ";
			PreparedStatement st = connect.prepareStatement(sql);
			ResultSet rs = st.executeQuery();

			while (rs.next()) {
				list.add( new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						new Category(rs.getInt(6))) );
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
						new Category(rs.getInt(6)));
			}
		} catch (SQLException e) {
			// TODO: handle exception
			System.out.println(e);
		}

		return null;
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
						new Category(rs.getInt(6))) );
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
						new Category(rs.getInt(6))) );
			}
		}catch (Exception e){

		}
		return list;
	}
	public static List<Batch> getListBatchById(int id) {
		List<Batch> list = new ArrayList<>();
		String sql = "SELECT b.id, b.name, b.manufacturingDate, b.expiryDate, b.dateOfImporting, " +
				"b.quantity,b.currentQuantity, b.priceImport, p.id AS provider_id, p.name AS provider_name, p.address AS provider_address, " +
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
				Account adminCreate = new Account(); // Giả sử Account có constructor với các tham số này
				adminCreate.setId(rs.getInt("admin_id"));
				adminCreate.setName(rs.getString("admin_name"));
				Batch batch = new Batch(
						rs.getInt(1),
						rs.getString(2),
						rs.getDate(3),
						rs.getDate(4),
						rs.getDate(5),
						rs.getInt(6),
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
				return  new Batch(rs.getInt(1),rs.getString(2),rs.getDate(3),rs.getDate(4),rs.getDate(5),rs.getInt(6),rs.getInt(7),rs.getDouble(8),
						new Provider(rs.getInt(9)),new Account(rs.getInt(10)));
			}
		}catch (Exception e) {

		}
		return null;
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
				"b.quantity, b.currentQuantity, b.priceImport, p.id AS provider_id, p.name AS provider_name, p.address AS provider_address, " +
				"a.id AS admin_id, a.name AS admin_name " +
				"FROM Batch b " +
				"JOIN Providers p ON b.provider_id = p.id " +
				"JOIN Accounts a ON b.adminCreate_id = a.id " +
				"WHERE b.product_id = ? AND b.expiryDate > CURDATE()";

		try (
				Connection conn = JDBCUtil.getConnection();
				PreparedStatement productStatement = conn.prepareStatement(productSql);
				PreparedStatement batchStatement = conn.prepareStatement(batchSql);
		) {
			// Lấy thông tin sản phẩm từ bảng Products
			productStatement.setInt(1, id);
			try (ResultSet productResultSet = productStatement.executeQuery()) {
				if (productResultSet.next()) {
					// Tạo đối tượng Product từ dữ liệu trong ResultSet
					product = new Product(
							productResultSet.getInt("id"),
							productResultSet.getString("name"),
							productResultSet.getDouble("price"),
							productResultSet.getString("image"),
							productResultSet.getString("description"),
							new Category(productResultSet.getInt("category_id")),
							new ArrayList<>(),
							new ArrayList<>()
					);

					// Lấy danh sách các Batch từ bảng Batch
					batchStatement.setInt(1, id);
					try (ResultSet batchResultSet = batchStatement.executeQuery()) {
						while (batchResultSet.next()) {
							// Tạo đối tượng Batch và thêm vào danh sách của Product
							Provider provider = new Provider(
									batchResultSet.getInt("provider_id"),
									batchResultSet.getString("provider_name"),
									batchResultSet.getString("provider_address")
							);
							Account adminCreate = new Account();
									adminCreate.setId(batchResultSet.getInt("admin_id"));
									adminCreate.setName(batchResultSet.getString("admin_name"));
							int quantity = batchResultSet.getInt("currentQuantity");
							Batch batch = new Batch(
									batchResultSet.getInt("id"),
									batchResultSet.getString("name"),
									batchResultSet.getDate("manufacturingDate"),
									batchResultSet.getDate("expiryDate"),
									batchResultSet.getDate("dateOfImporting"),
									batchResultSet.getInt("quantity"),
									batchResultSet.getInt("currentQuantity"),
									batchResultSet.getDouble("priceImport"),
									provider,
									adminCreate
							);
							product.addBatch(batch);
						}
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return product;
	}
	public static List<Product> pagingProduct(int cid, String sort, String type) {
		List<Product> list = new ArrayList<>();
		String query = "";
		String orderByClause = " ORDER BY " + sort + " " + type +" ";
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
						new Category(rs.getInt(6))) );
			}
		} catch (Exception e) {
			// Xử lý ngoại lệ
		}
		return list;
	}

public static List<Product> getFilteredProducts(Integer categoryId, Integer idProvider, Double startPrice, Double endPrice) {
	List<Product> list = new ArrayList<>();
	StringBuilder query = new StringBuilder("SELECT DISTINCT p.* FROM Products p ");
	query.append("JOIN Batch b ON p.id = b.product_id ");
	query.append("JOIN Providers pr ON b.provider_id = pr.id ");
	query.append("JOIN Category c ON p.category_id = c.id ");
	query.append("WHERE 1=1 ");

	if (categoryId != null) {
		query.append("AND c.id = ? ");
	}
	if (idProvider != null) {
		query.append("AND pr.id = ? ");
	}
	if (startPrice != null && endPrice != null) {
		query.append("AND p.price BETWEEN ? AND ? ");
	}
	query.append("ORDER BY p.name");

	try {
		Connection con = JDBCUtil.getConnection();
		PreparedStatement ps = con.prepareStatement(query.toString());

		int parameterIndex = 1;

		if (categoryId != null) {
			ps.setInt(parameterIndex++, categoryId);
		}
		if (idProvider != null) {
			ps.setInt(parameterIndex++, idProvider);
		}
		if (startPrice != null && endPrice != null) {
			ps.setDouble(parameterIndex++, startPrice);
			ps.setDouble(parameterIndex++, endPrice);
		}

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
					new Category(rs.getInt(6))));
		}
	} catch (Exception e) {
		// Xử lý exception
		e.printStackTrace();
	}
	return list;
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
						new Category(rs.getInt(6))) );
			}
		}catch (Exception e){

		}
		return list;
	}
	public static void updateProductAndBatches(Product product, List<Batch> updatedBatches,int id) {
		String updateProductSQL = "UPDATE Products SET name = ?, price = ?, image = ?, description = ?, category_id = ?  WHERE id = ?";
		String updateBatchSQL = "UPDATE Batch SET manufacturingDate = ?, expiryDate = ?, dateOfImporting = ?, quantity = ?,currentQuantity=?, priceImport = ?, provider_id=? WHERE id = ?";

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
			psProduct.setInt(6, product.getId());
			psProduct.executeUpdate();

			// Cập nhật thông tin các lô hàng
			for (Batch batch : updatedBatches) {
				psBatch.setDate(1, new java.sql.Date(batch.getManufacturingDate().getTime()));
				psBatch.setDate(2, new java.sql.Date(batch.getExpiryDate().getTime()));
				psBatch.setDate(3, new java.sql.Date(batch.getDateOfImporting().getTime()));
				psBatch.setInt(4, batch.getQuantity());
				psBatch.setInt(5,batch.getCurrentQuantity());
				psBatch.setDouble(6, batch.getPriceImport());
				psBatch.setInt(7,batch.getProvider().getId());
				psBatch.setInt(8, id);
				psBatch.addBatch();
			}
			psBatch.executeBatch();

			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			// Rollback trong trường hợp có lỗi xảy ra
		}
	}
	public static List<Provider> getListProviderByIdP(int id) {
		List<Provider> list = new ArrayList<>();
		String sql = "SELECT DISTINCT p.id, p.name, p.address " +
				"FROM Providers p " +
				"JOIN Batch b ON p.id = b.provider_id " +
				"WHERE b.product_id = ?";
		try {
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Provider(rs.getInt("id"), rs.getString("name"), rs.getString("address")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public static Discount getDiscountByCode(String code) {
		String sql = "SELECT * FROM Discounts WHERE code=?";
		try {
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, code);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				Discount discount = new Discount();
				discount.setId(rs.getInt("id"));
				discount.setCode(rs.getString("code"));
				discount.setDiscountType(rs.getString("discount_type"));
				discount.setProductId(rs.getInt("product_id"));
				discount.setCategoryId(rs.getInt("category_id"));
				discount.setDiscountValue(rs.getDouble("discount_value"));
				discount.setStartDate(rs.getDate("start_date"));
				discount.setEndDate(rs.getDate("end_date"));
				return discount;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	public static void main(String[] args) {
		List<Product> list = ProductDAO.getFilteredProducts(null,1,10.0,50.0);
		for (Product p : list){
			System.out.println(p.toString());
		}
	}

}