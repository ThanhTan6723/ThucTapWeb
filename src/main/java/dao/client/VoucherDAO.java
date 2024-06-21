package dao.client;

import model.Category;
import model.Product;
import model.Voucher;
import model.DiscountType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VoucherDAO {
    public static List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        String query = "SELECT v.*, dt.type as discount_type_name,p.id as product_id, p.name as product_name,c.id as category_id, c.name as category_name FROM Vouchers v " +
                "LEFT JOIN DiscountType dt ON v.discount_type = dt.id " +
                "LEFT JOIN Products p ON v.product_id = p.id " +
                "LEFT JOIN Category c ON v.category_id = c.id";
        try (Connection connection = JDBCUtil.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(query)) {
            while (resultSet.next()) {
                Voucher voucher = new Voucher();
                voucher.setId(resultSet.getInt("id"));
                voucher.setCode(resultSet.getString("code"));
                voucher.setDiscountType(new DiscountType(resultSet.getInt("discount_type"), resultSet.getString("discount_type_name")));
                voucher.setDiscountPercentage(resultSet.getBigDecimal("discount_percentage"));

                if (resultSet.getInt("product_id") != 0) {
                    Product product = new Product();
                    product.setId(resultSet.getInt("product_id"));
                    product.setName(resultSet.getString("product_name"));
                    voucher.setProduct(product);
                }
                if (resultSet.getInt("category_id") != 0) {
                    Category category = new Category();
                    category.setId(resultSet.getInt("category_id"));
                    category.setName(resultSet.getString("category_name"));
                    voucher.setCategory(category);
                }
                voucher.setQuantity(resultSet.getInt("quantity"));
                voucher.setStartDate(resultSet.getDate("start_date"));
                voucher.setEndDate(resultSet.getDate("end_date"));
                voucher.setActive(resultSet.getBoolean("is_active"));
                vouchers.add(voucher);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }

    public static boolean saveEVoucher(int accountId, int voucherId) {
        String queryInsert = "INSERT INTO eVouchers (account_id, voucher_id) VALUES (?, ?)";
        String queryUpdate = "UPDATE Vouchers SET quantity = quantity - 1 WHERE id = ? AND quantity > 0";

        try (Connection connection = JDBCUtil.getConnection();
             PreparedStatement preparedStatementInsert = connection.prepareStatement(queryInsert);
             PreparedStatement preparedStatementUpdate = connection.prepareStatement(queryUpdate)) {

            // Start transaction
            connection.setAutoCommit(false);

            // Update voucher quantity
            preparedStatementUpdate.setInt(1, voucherId);
            int updateResult = preparedStatementUpdate.executeUpdate();
            if (updateResult == 0) {
                connection.rollback();
                return false; // No rows updated, probably voucher out of stock
            }

            // Insert eVoucher
            preparedStatementInsert.setInt(1, accountId);
            preparedStatementInsert.setInt(2, voucherId);
            int insertResult = preparedStatementInsert.executeUpdate();

            // Commit transaction
            connection.commit();
            return insertResult > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            try (Connection connection = JDBCUtil.getConnection()) {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        }
    }

    public List<Integer> getSavedVouchers(int accountId) {
        List<Integer> savedVouchers = new ArrayList<>();
        String query = "SELECT voucher_id FROM eVouchers WHERE account_id = ?";

        try (Connection connection = JDBCUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, accountId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    savedVouchers.add(resultSet.getInt("voucher_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return savedVouchers;
    }

    // Get saved vouchers for a specific user
    public List<Voucher> getVoucherForAccount(int accountId) {
        List<Voucher> savedVouchers = new ArrayList<>();
        String query = "SELECT v.*, dt.type as discount_type_name, p.id as product_id, p.name as product_name, c.id as category_id, c.name as category_name FROM eVouchers ev " +
                "JOIN Vouchers v ON ev.voucher_id = v.id " +
                "LEFT JOIN DiscountType dt ON v.discount_type = dt.id " +
                "LEFT JOIN Products p ON v.product_id = p.id " +
                "LEFT JOIN Category c ON v.category_id = c.id " +
                "WHERE ev.account_id = ?";
        try (Connection connection = JDBCUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, accountId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Voucher voucher = new Voucher();
                    voucher.setId(resultSet.getInt("id"));
                    voucher.setCode(resultSet.getString("code"));
                    voucher.setDiscountType(new DiscountType(resultSet.getInt("discount_type"), resultSet.getString("discount_type_name")));
                    voucher.setDiscountPercentage(resultSet.getBigDecimal("discount_percentage"));

                    if (resultSet.getInt("product_id") != 0) {
                        Product product = new Product();
                        product.setId(resultSet.getInt("product_id"));
                        product.setName(resultSet.getString("product_name"));
                        voucher.setProduct(product);
                    }
                    if (resultSet.getInt("category_id") != 0) {
                        Category category = new Category();
                        category.setId(resultSet.getInt("category_id"));
                        category.setName(resultSet.getString("category_name"));
                        voucher.setCategory(category);
                    }
                    voucher.setQuantity(resultSet.getInt("quantity"));
                    voucher.setStartDate(resultSet.getDate("start_date"));
                    voucher.setEndDate(resultSet.getDate("end_date"));
                    voucher.setActive(resultSet.getBoolean("is_active"));
                    savedVouchers.add(voucher);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return savedVouchers;
    }

    public static void main(String[] args) {
        System.out.println(getAllVouchers());
        System.out.println(saveEVoucher(1, 2));
    }
}
