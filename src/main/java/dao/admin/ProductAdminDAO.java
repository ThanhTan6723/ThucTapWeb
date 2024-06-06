package dao.admin;

import dao.client.JDBCUtil;
import model.*;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ProductAdminDAO {
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
                        new Category(rs.getInt(6))));

            }
        }catch (Exception e){

        }
        return list;
    }




    public static List<Product> getProductsForPage(int offset, int recordsPerPage) {
        List<Product> list = new ArrayList<>();
        String query = "SELECT * FROM Products " +
                "WHERE id IN ( " +
                "    SELECT DISTINCT product_id FROM Batch " +
                ") " +
                "LIMIT ? OFFSET ?";
        try {
            Connection con = JDBCUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, recordsPerPage);
            ps.setInt(2, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getDouble(3),
                        rs.getString(4),
                        rs.getString(5),
                        new Category(rs.getInt(6))
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public static Product getProductWithBatchesById(int id) {
        Product product = null;
        String productSql = "SELECT * FROM Products WHERE id=?";
        String batchSql = "SELECT  b.manufacturingDate, b.expiryDate,b.dateOfImporting,  " +
                "b.quantity, b.currentQuantity, b.priceImport " +
                "FROM Batch b " +  "WHERE b.product_id = ? ";

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

                            int quantity = batchResultSet.getInt("currentQuantity");
/*
                            System.out.println(quantity);
*/
                            Batch batch = new Batch(
                                    batchResultSet.getDate("manufacturingDate"),
                                    batchResultSet.getDate("expiryDate"),
                                    batchResultSet.getDate("dateOfImporting"),
                                    batchResultSet.getInt("quantity"),
                                    batchResultSet.getInt("currentQuantity")
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
    public static Product getProductStillExpiredById(int id) {
        Product product = null;
        String productSql = "SELECT * FROM Products WHERE id=?";
        String batchSql = "SELECT  b.manufacturingDate, b.expiryDate,b.dateOfImporting,  " +
                "b.quantity, b.currentQuantity, b.priceImport " +
                "FROM Batch b " +  "WHERE b.product_id = ? AND expiryDate >= CURDATE() ";

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

                            int quantity = batchResultSet.getInt("currentQuantity");
/*
                            System.out.println(quantity);
*/
                            Batch batch = new Batch(
                                    batchResultSet.getDate("manufacturingDate"),
                                    batchResultSet.getDate("expiryDate"),
                                    batchResultSet.getDate("dateOfImporting"),
                                    batchResultSet.getInt("quantity"),
                                    batchResultSet.getInt("currentQuantity")
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
    public static Product getProductExpiredById(int id) {
        Product product = null;
        String productSql = "SELECT * FROM Products WHERE id=?";
        String batchSql = "SELECT  b.manufacturingDate, b.expiryDate,b.dateOfImporting,  " +
                "b.quantity, b.currentQuantity, b.priceImport " +
                "FROM Batch b " +  "WHERE b.product_id = ? AND expiryDate < CURDATE() ";

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

                            int quantity = batchResultSet.getInt("currentQuantity");
/*
                            System.out.println(quantity);
*/
                            Batch batch = new Batch(
                                    batchResultSet.getDate("manufacturingDate"),
                                    batchResultSet.getDate("expiryDate"),
                                    batchResultSet.getDate("dateOfImporting"),
                                    batchResultSet.getInt("quantity"),
                                    batchResultSet.getInt("currentQuantity")
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
    public static Product getProductAlmostExpiredById(int id) {
        Product product = null;
        String productSql = "SELECT * FROM Products WHERE id=?";
        String batchSql = "SELECT  b.manufacturingDate, b.expiryDate,b.dateOfImporting,  " +
                "b.quantity, b.currentQuantity, b.priceImport " +
                "FROM Batch b " +  "WHERE b.product_id = ? AND (b.expiryDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 5 DAY))";

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

                            int quantity = batchResultSet.getInt("currentQuantity");
/*
                            System.out.println(quantity);
*/
                            Batch batch = new Batch(
                                    batchResultSet.getDate("manufacturingDate"),
                                    batchResultSet.getDate("expiryDate"),
                                    batchResultSet.getDate("dateOfImporting"),
                                    batchResultSet.getInt("quantity"),
                                    batchResultSet.getInt("currentQuantity")
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
 /*   public static void insertProduct(List<Product> list) {
        String productSQL = "INSERT INTO Products (name, price, image, description, category_id) VALUES (?, ?, ?, ?, ?)";
        String imageSQL = "INSERT INTO Images (imgAssetId) VALUES (?)";
        String productImageSQL = "INSERT INTO ProductImages (productId, imageId) VALUES (?, ?)";
        String batchSQL = "INSERT INTO Batch (product_id, name, manufacturingDate, expiryDate, dateOfImporting, quantity, currentQuantity, priceImport, provider_id, adminCreate_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String providerSQL = "INSERT INTO Providers (name, address) VALUES (?, ?)";

        Connection conn = null;
        PreparedStatement productStmt = null;
        PreparedStatement imageStmt = null;
        PreparedStatement productImageStmt = null;
        PreparedStatement batchStmt = null;
        PreparedStatement providerStmt = null;

        try {
            conn = JDBCUtil.getConnection();
            conn.setAutoCommit(false);

            productStmt = conn.prepareStatement(productSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            imageStmt = conn.prepareStatement(imageSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            productImageStmt = conn.prepareStatement(productImageSQL);
            batchStmt = conn.prepareStatement(batchSQL);
            providerStmt = conn.prepareStatement(providerSQL, PreparedStatement.RETURN_GENERATED_KEYS);

            for (Product product : list) {
                // Insert the product
                productStmt.setString(1, product.getName());
                productStmt.setDouble(2, product.getPrice());
                productStmt.setString(3, product.getImage());
                productStmt.setString(4, product.getDescription());
                productStmt.setInt(5, product.getCategory().getId());
                productStmt.executeUpdate();

                // Get the generated product ID
                int productId;
                try (var rs = productStmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        productId = rs.getInt(1);
                    } else {
                        throw new SQLException("Failed to retrieve product ID.");
                    }
                }

                // Insert the images
                for (Image image : product.getImages()) {
                    imageStmt.setString(1, image.getUrl());
                    imageStmt.executeUpdate();

                    // Get the generated image ID
                    int imageId;
                    try (var rs = imageStmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            imageId = rs.getInt(1);
                        } else {
                            throw new SQLException("Failed to retrieve image ID.");
                        }
                    }

                    // Insert into ProductImages table
                    productImageStmt.setInt(1, productId);
                    productImageStmt.setInt(2, imageId);
                    productImageStmt.executeUpdate();
                }

                // Insert the batches
                for (Batch batch : product.getBatches()) {
                    // Insert the provider if it doesn't exist
                    Provider provider = batch.getProvider();
                    providerStmt.setString(1, provider.getName());
                    providerStmt.setString(2, provider.getAddress());
                    providerStmt.executeUpdate();

                    int providerId;
                    try (var rs = providerStmt.getGeneratedKeys()) {
                        if (rs.next()) {
                            providerId = rs.getInt(1);
                        } else {
                            throw new SQLException("Failed to retrieve provider ID.");
                        }
                    }

                    batchStmt.setInt(1, productId);
                    batchStmt.setString(2, batch.getName());
                    batchStmt.setDate(3, new java.sql.Date(batch.getManufacturingDate().getTime()));
                    batchStmt.setDate(4, new java.sql.Date(batch.getExpiryDate().getTime()));
                    batchStmt.setDate(5, new java.sql.Date(batch.getDateOfImporting().getTime()));
                    batchStmt.setInt(6, batch.getQuantity());
                    batchStmt.setInt(7, batch.getCurrentQuantity());
                    batchStmt.setDouble(8, batch.getPriceImport());
                    batchStmt.setInt(9, providerId);
                    batchStmt.setInt(10, batch.getAdminCreate().getId());
                    batchStmt.executeUpdate();
                }
            }

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackEx) {
                    rollbackEx.printStackTrace();
                }
            }
            e.printStackTrace();

        }
    }*/
 public static void insertProduct(List<Product> list) {
     String productSQL = "INSERT INTO Products (name, price, image, description, category_id) VALUES (?, ?, ?, ?, ?)";
     String imageSQL = "INSERT INTO Images (imgAssetId) VALUES (?)";
     String productImageSQL = "INSERT INTO ProductImages (productId, imageId) VALUES (?, ?)";
     String batchSQL = "INSERT INTO Batch (product_id, name, manufacturingDate, expiryDate, dateOfImporting, quantity, currentQuantity, priceImport, provider_id, adminCreate_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
     String providerSQL = "INSERT INTO Providers (name, address) VALUES (?, ?)";
     String checkProviderSQL = "SELECT id FROM Providers WHERE name = ? AND address = ?";

     Connection conn = null;
     PreparedStatement productStmt = null;
     PreparedStatement imageStmt = null;
     PreparedStatement productImageStmt = null;
     PreparedStatement batchStmt = null;
     PreparedStatement providerStmt = null;

     try {
         conn = JDBCUtil.getConnection();
         conn.setAutoCommit(false);

         productStmt = conn.prepareStatement(productSQL, PreparedStatement.RETURN_GENERATED_KEYS);
         imageStmt = conn.prepareStatement(imageSQL, PreparedStatement.RETURN_GENERATED_KEYS);
         productImageStmt = conn.prepareStatement(productImageSQL);
         batchStmt = conn.prepareStatement(batchSQL);
         providerStmt = conn.prepareStatement(providerSQL, PreparedStatement.RETURN_GENERATED_KEYS);

         for (Product product : list) {
             // Insert the product
             productStmt.setString(1, product.getName());
             productStmt.setDouble(2, product.getPrice());
             productStmt.setString(3, product.getImage());
             productStmt.setString(4, product.getDescription());
             productStmt.setInt(5, product.getCategory().getId());
             productStmt.executeUpdate();

             // Get the generated product ID
             int productId;
             try (var rs = productStmt.getGeneratedKeys()) {
                 if (rs.next()) {
                     productId = rs.getInt(1);
                 } else {
                     throw new SQLException("Failed to retrieve product ID.");
                 }
             }

             // Insert the images
             for (Image image : product.getImages()) {
                 imageStmt.setString(1, image.getUrl());
                 imageStmt.executeUpdate();

                 // Get the generated image ID
                 int imageId;
                 try (var rs = imageStmt.getGeneratedKeys()) {
                     if (rs.next()) {
                         imageId = rs.getInt(1);
                     } else {
                         throw new SQLException("Failed to retrieve image ID.");
                     }
                 }

                 // Insert into ProductImages table
                 productImageStmt.setInt(1, productId);
                 productImageStmt.setInt(2, imageId);
                 productImageStmt.executeUpdate();
             }

             // Insert the batches
             for (Batch batch : product.getBatches()) {
                 // Check if the provider already exists
                 Provider provider = batch.getProvider();
                 int providerId;
                 try (PreparedStatement checkProviderStmt = conn.prepareStatement(checkProviderSQL)) {
                     checkProviderStmt.setString(1, provider.getName());
                     checkProviderStmt.setString(2, provider.getAddress());
                     try (ResultSet rs = checkProviderStmt.executeQuery()) {
                         if (rs.next()) {
                             // Provider already exists, retrieve its ID
                             providerId = rs.getInt("id");
                         } else {
                             // Provider doesn't exist, insert it
                             providerStmt.setString(1, provider.getName());
                             providerStmt.setString(2, provider.getAddress());
                             providerStmt.executeUpdate();

                             // Get the generated provider ID
                             try (ResultSet generatedKeys = providerStmt.getGeneratedKeys()) {
                                 if (generatedKeys.next()) {
                                     providerId = generatedKeys.getInt(1);
                                 } else {
                                     throw new SQLException("Failed to retrieve generated provider ID.");
                                 }
                             }
                         }
                     }
                 }

                 // Insert the batch
                 batchStmt.setInt(1, productId);
                 batchStmt.setString(2, batch.getName());
                 batchStmt.setDate(3, new java.sql.Date(batch.getManufacturingDate().getTime()));
                 batchStmt.setDate(4, new java.sql.Date(batch.getExpiryDate().getTime()));
                 batchStmt.setDate(5, new java.sql.Date(batch.getDateOfImporting().getTime()));
                 batchStmt.setInt(6, batch.getQuantity());
                 batchStmt.setInt(7, batch.getCurrentQuantity());
                 batchStmt.setDouble(8, batch.getPriceImport());
                 batchStmt.setInt(9, providerId);
                 batchStmt.setInt(10, batch.getAdminCreate().getId());
                 batchStmt.executeUpdate();
             }
         }
         conn.commit();
     } catch (SQLException e) {

         e.printStackTrace();
     }
 }
    public static void addBatchesToProduct(int id, List<Batch> batches) {
        try {
            Connection conn = JDBCUtil.getConnection();
            // Truy vấn để lấy provider_id hoặc thêm nhà cung cấp mới nếu cần
            String selectProviderQuery = "SELECT id FROM Providers WHERE name = ? AND address = ?";
            String insertProviderQuery = "INSERT INTO Providers (name, address) VALUES (?, ?)";

            for (Batch batch : batches) {
                Provider provider = batch.getProvider();
                int providerId = 0;

                // Kiểm tra xem nhà cung cấp đã tồn tại chưa
                PreparedStatement selectStmt = conn.prepareStatement(selectProviderQuery);
                selectStmt.setString(1, provider.getName());
                selectStmt.setString(2, provider.getAddress());
                ResultSet rs = selectStmt.executeQuery();

                if (rs.next()) {
                    // Nếu nhà cung cấp đã tồn tại, lấy provider_id
                    providerId = rs.getInt("id");
                } else {
                    // Nếu nhà cung cấp chưa tồn tại, thêm nhà cung cấp mới
                    PreparedStatement insertStmt = conn.prepareStatement(insertProviderQuery, Statement.RETURN_GENERATED_KEYS);
                    insertStmt.setString(1, provider.getName());
                    insertStmt.setString(2, provider.getAddress());
                    insertStmt.executeUpdate();
                    ResultSet generatedKeys = insertStmt.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        providerId = generatedKeys.getInt(1);
                    }
                    insertStmt.close();
                }
                selectStmt.close();
                rs.close();

                // Thêm batch mới với provider_id đã được thiết lập
                String insertQuery = "INSERT INTO Batch (product_id, name, manufacturingDate, expiryDate, dateOfImporting, quantity, currentQuantity, priceImport, provider_id, adminCreate_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(insertQuery);
                stmt.setInt(1, id);
                stmt.setString(2, batch.getName());
                stmt.setDate(3, new java.sql.Date(batch.getManufacturingDate().getTime()));
                stmt.setDate(4, new java.sql.Date(batch.getExpiryDate().getTime()));
                stmt.setDate(5, new java.sql.Date(batch.getDateOfImporting().getTime()));
                stmt.setInt(6, batch.getQuantity());
                stmt.setInt(7, batch.getCurrentQuantity());
                stmt.setDouble(8, batch.getPriceImport());
                stmt.setInt(9, providerId);
                stmt.setInt(10, batch.getAdminCreate().getId());
                stmt.executeUpdate();
                stmt.close();
            }
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            // Xử lý ngoại lệ
        }
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
                Account adminCreate = new Account(rs.getInt("admin_id"), rs.getString("admin_name")); // Giả sử Account có constructor với các tham số này
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
    public static void main(String[] args) {
        System.out.println(getListBatchById(2));
		try {
            // Định dạng ngày tháng
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			// Tạo danh sách Batch cập nhật
			List<Batch> updatedBatches = new ArrayList<>();
			Batch batch1 = new Batch();
			batch1.setName("hihihi"); // ID của lô hàng cần cập nhật
			batch1.setManufacturingDate(sdf.parse("10/10/2023")); // Ngày sản xuất
			batch1.setExpiryDate(sdf.parse("10/07/2024")); // Hạn sử dụng
			batch1.setDateOfImporting(sdf.parse("05/01/2024")); // Ngày nhập
			batch1.setQuantity(100);
			batch1.setCurrentQuantity(50); // Giả sử currentQuantity là 50
			batch1.setPriceImport(50.0);
			batch1.setProvider(new Provider( "Provider Name", "Provider Address")); // Giả sử Provider có ID là 1
            batch1.setAdminCreate(new Account(1,"hiih"));

        // Thêm Batch vào danh sách

			updatedBatches.add(batch1);

			Batch batch2 = new Batch();
			batch2.setName("heheh"); // ID của lô hàng cần cập nhật
			batch2.setManufacturingDate(sdf.parse("13/10/2023")); // Ngày sản xuất
			batch2.setExpiryDate(sdf.parse("01/07/2024")); // Hạn sử dụng
			batch2.setDateOfImporting(sdf.parse("06/01/2024")); // Ngày nhập
			batch2.setQuantity(500);
			batch2.setCurrentQuantity(35); // Giả sử currentQuantity là 50
			batch2.setPriceImport(12.34);
			batch2.setProvider(new Provider( "Provider Name", "Provider Address")); // Giả sử Provider có ID là 1
            batch2.setAdminCreate(new Account(1,"hihi"));
			updatedBatches.add(batch2);
            System.out.println(updatedBatches);
            addBatchesToProduct(2,updatedBatches);

		} catch (ParseException e) {
			e.printStackTrace();
		}
        System.out.println(getListBatchById(2));
/*
        System.out.println(getListBatchById(3));
*/

    }

}
