package dao.admin;

import dao.client.JDBCUtil;
import model.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductAdminDAO {
    public static List<Product> getListProducts() {
        List<Product> list = new ArrayList<>();
        String query = "       SELECT *\n" +
                "FROM Products\n" +
                "WHERE id IN (\n" +
                "    SELECT DISTINCT product_id\n" +
                "    FROM Batch\n" +  ");";
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
                            System.out.println(quantity);
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
                            System.out.println(quantity);
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
                            System.out.println(quantity);
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
                            System.out.println(quantity);
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

    public static void main(String[] args) {
        System.out.println(getProductAlmostExpiredById(2));
    }

}
