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
                       ProductDAO.getCategoryById1(rs.getInt(6)));
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
                        new Category(rs.getInt(6))) );
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
        String sql = "SELECT b.id, b.product_id, b.name, b.manufacturingDate, b.expiryDate, b.dateOfImporting, " +
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
                Account adminCreate = new Account();
                adminCreate.setId(rs.getInt("admin_id"));
                adminCreate.setName(rs.getString("admin_name"));
                Batch batch = new Batch(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3),
                        rs.getDate(4),
                        rs.getDate(5),
                        rs.getDate(6),
                        rs.getInt(7),
                        rs.getInt(8),
                        rs.getDouble(9),
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
                return  new Batch(rs.getInt(1),rs.getInt(2),rs.getString(3),rs.getDate(4),rs.getDate(5),rs.getDate(6),rs.getInt(7),rs.getInt(8),rs.getDouble(9),
                        new Provider(rs.getInt(10)),new Account(rs.getInt(11)));
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
                            System.out.println(quantity);
                            Batch batch = new Batch(
                                    batchResultSet.getInt("id"),
                                    id, // product_id
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

    public static void main(String[] args) {

/*		System.out.println(getProductWithBatchesById(2));

		List<Batch> updatedBatches = new ArrayList<>();
		updatedBatches.add(new Batch(1, 1, "B001", new Date(110, 3, 10), new Date(110, 4, 10), new Date(110, 3, 12), 100, 12.34, new Provider(3, "cuimia", "cuimia")));
		updatedBatches.add(new Batch(4, 3, "B002", new Date(115, 3, 10), new Date(112, 4, 18), new Date(112, 0, 24), 500, 4.56, new Provider(3, "hehe", "hehe")));

		updateProductAndBatches(new Product(2,"hihi",12.00,"hehe","hehe",new Category(1,"hehe"),4.00),updatedBatches,4);
		System.out.println(getProductWithBatchesById(2));*/

			/*


//			System.out.println(getListExpiredProduct());


//			System.out.println(getListBatchById(3));


//			System.out.println(getBatchById(7));
//			System.out.println(getInforByIdProvider(4));
/*		System.out.println(getListProducts());
		removeProduct(2);
		System.out.println(getListProducts());*/
        System.out.println(getProductWithBatchesById(1));
        System.out.println(getProductById(1));
        System.out.println(getCategoryById1(1));
    }

}