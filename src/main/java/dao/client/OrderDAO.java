package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Account;
import model.Category;
import model.Order;
import model.OrderDetail;
import model.Product;

public class OrderDAO {

	public static List<Product> getListProductsById(int pid) {
		List<Product> listProducts = new ArrayList<Product>();
		try {
			Connection connection = JDBCUtil.getConnection();
			String sql = "SELECT * FROM Products where id=? ";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, pid);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				listProducts.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4),
						rs.getString(5), OrderDAO.getCategory(rs.getInt(6))));
			}

			// Close resources

		} catch (Exception e) {
			e.printStackTrace();
		}

		return listProducts;

	}

	public static Category getCategory(int cid) {
		try {
			Connection connection = JDBCUtil.getConnection();
			String sql = "SELECT * FROM Category where id=? ";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, cid);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				return new Category(rs.getInt(1), rs.getString(2));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;

	}

	public static List<Order> getListOrdersById(int accountId) {
		List<Order> listOrders = new ArrayList<>();

		try {
			Connection connection = JDBCUtil.getConnection();
			String sql = "SELECT * FROM Orders where account_id=? ";
			PreparedStatement preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setInt(1, accountId); // Assuming you want only shipped orders

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				listOrders.add(new Order(rs.getInt(1), rs.getString(2), AccountDAO.getAccountById(rs.getInt(3)),
						rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7)));
			}

			// Close resources

		} catch (Exception e) {
			e.printStackTrace(); // Handle or log the exception properly
		}

		return listOrders;
	}

	public static List<OrderDetail> getOrderDetailByBid(int orderId) {
		List<OrderDetail> list = new ArrayList<>();
		String query = "SELECT od.id,quantity,od.price from OrderDetails od join Orders o \r\n"
				+ "on od.order_id = o.id where  od.order_id=?";
		int i = 0;
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, orderId);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				list.add(new OrderDetail(rs.getInt(1), OrderDAO.getOrderforOrderDetail(orderId),
						OrderDAO.getListProductBybid(orderId).get(i), rs.getInt(2), rs.getDouble(3)));
				i++;
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;

	}

	public static Order getOrderforOrderDetail(int orderId) {
		String query = "SELECT * from Orders o join OrderDetails od on od.order_id = o.id where od.order_id=?";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, orderId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				return new Order(rs.getInt(1), rs.getString(2), AccountDAO.getAccountById(rs.getInt(3)),
						rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7));
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return null;

	}

	public static List<Product> getListProductBybid(int id) {
		List<Product> list = new ArrayList<>();
		String query = "SELECT * from Products p join OrderDetails od on p.id = od.product_id where od.order_id = ? ";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {
			e.printStackTrace();

		}
		return list;

	}

	public static void insertOrderdetail(OrderDetail oderDetail) {
//		List<Product> list = new ArrayList<>();
		String query = "INSERT INTO OrderDetails(order_id,product_id,quantity,price) VALUES (?,?,?,?) ";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setInt(1, oderDetail.getOrder().getId());
			ps.setInt(2, oderDetail.getProduct().getId());
			ps.setInt(3, oderDetail.getQuantity());
			ps.setDouble(4, oderDetail.getPrice());

			ps.executeUpdate();
			System.out.println("insert orderdetail success");
		} catch (Exception e) {
			e.printStackTrace();

		}

	}

	public static void insertOrder(Order order) {
//		List<Product> list = new ArrayList<>();
		String sql = "INSERT INTO Orders(date,account_id,address,orderNotes,OrderStatus) VALUES (?,?,?,?,?) ";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, order.getDate());
			ps.setInt(2, order.getAccount().getId());
			ps.setString(3, order.getAddress());
			ps.setString(4, order.getOrderNotes());
			ps.setString(5, order.getOrderStatus());
			ps.executeUpdate();
			System.out.println("insert order success");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void setCurrentIdBill(Order order) {
		String query = "SELECT IDENT_CURRENT('Orders') as LastID";
		try {
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				order.setId(rs.getInt(1));
			}
		} catch (Exception e) {

		}

	}

	public static void updateOrders(Order order) {
		try {
			Connection connect = JDBCUtil.getConnection();
			String sql = "UPDATE Orders " + "SET" + " totalMoney=? " + "where id=?";
			PreparedStatement ps = connect.prepareStatement(sql);
			ps.setDouble(1, order.getTotalMoney());
			ps.setInt(2, order.getId());
			ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}

	}

	public static List<Order> getAllOrders(String status) {
		List<Order> lists = new ArrayList<Order>();

		try {
			Connection connect = JDBCUtil.getConnection();

			String sql = "SELECT * FROM Orders where OrderStatus=?";
			PreparedStatement ps = connect.prepareStatement(sql);
			ps.setString(1, status);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				lists.add(new Order(rs.getInt(1), rs.getString(2), AccountDAO.getAccountById(rs.getInt(3)),
						rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7)));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return lists;
	}

	public static List<Order> getAllOrders() {
		List<Order> lists = new ArrayList<Order>();

		try {
			Connection connect = JDBCUtil.getConnection();

			String sql = "SELECT * FROM Orders ";
			PreparedStatement ps = connect.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				lists.add(new Order(rs.getInt(1), rs.getString(2), AccountDAO.getAccountById(rs.getInt(3)),
						rs.getDouble(4), rs.getString(5), rs.getString(6), rs.getString(7)));
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return lists;
	}

//	public static List<OrderDetail> getAllOrderDetails() {
//		List<OrderDetail> lists = new ArrayList<OrderDetail>();
//
//		try {
//			Connection connect = JDBCUtil.getConnection();
//
//			String sql = "SELECT * FROM OrderDetails";
//			PreparedStatement ps = connect.prepareStatement(sql);
//			ResultSet rs = ps.executeQuery();
//			while (rs.next()) {
//				lists.add(new OrderDetail(rs.getInt(1), OrderDAO.getOrderforOrderDetail(rs.getInt(2)),
//						OrderDAO.getProductBybid(rs.getInt(3)).get(0), rs.getInt(4), rs.getDouble(5)));
//			}
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
//		return lists;
//	}

	public static void updateOrderStatus(int id, String status) {
		try {
			Connection conect = JDBCUtil.getConnection();
			String sql = "Update Orders SET " + "orderStatus=? " + "where id=?";
			PreparedStatement ps = conect.prepareStatement(sql);
			ps.setString(1, status);
			ps.setInt(2, id);

			ps.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}

	public static List<OrderDetail> getListOrder(int id) {
		List<OrderDetail> listOrderdetails = new ArrayList<>();

		try {
			Connection connect = JDBCUtil.getConnection();
			String sql = "\r\n"
					+ "SELECT O.id , P.id ,O.orderStatus,O.address,O.account_id, P.name, P.price,OD.quantity,OD.price , P.image, P.description, P.category_Id,O.totalMoney,O.date\r\n"
					+ "FROM Orders O\r\n" + "INNER JOIN OrderDetails OD ON O.id = OD.order_id\r\n"
					+ "INNER JOIN Products P ON OD.product_id = P.id\r\n"
					+ "INNER JOIN Category C ON P.category_id = C.id\r\n" + "WHERE O.account_id = ?\r\n"
					+ "ORDER BY O.id DESC";
			PreparedStatement ps = connect.prepareStatement(sql);
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				Order order = new Order();
				order.setId(rs.getInt("id"));
				order.setDate(rs.getString("date"));
				order.setTotalMoney(rs.getFloat("totalMoney"));
				order.setOrderStatus(rs.getString(3));
				order.setAddress(rs.getString(4));
				order.setAccount(AccountDAO.getAccountById(rs.getInt(5)));

				Product product = new Product();
				product.setId(rs.getInt("id"));
				product.setName(rs.getString("name"));
				product.setPrice(rs.getDouble("price"));
				product.setImage(rs.getString("image"));
				product.setDescription(rs.getString("description"));

				Category category = new Category(id, sql);
				category.setId(rs.getInt("id"));

				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setOrder(order);
				orderDetail.setProduct(product);
				orderDetail.setQuantity(rs.getInt("quantity"));
				orderDetail.setPrice(rs.getDouble(7));

				listOrderdetails.add(orderDetail);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return listOrderdetails;
	}

	public static int getQuantityWithOderId(int orderId) {
		int sum = 0;
		try {
			Connection connect = JDBCUtil.getConnection();
			String sql = "SELECT SUM(quantity) AS totalQuantity\r\n" + "FROM OrderDetails\r\n" + "WHERE order_id = ?;";
			PreparedStatement ps = connect.prepareStatement(sql);
			ps.setInt(1, orderId);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				sum = rs.getInt(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return sum;
	}

	public static int deleteOrderDetail(int id) {
		int re = 0;

		try {
			Connection connect = JDBCUtil.getConnection();
			String sql = "DELETE from OrderDetails where order_id=?";
			PreparedStatement pre = connect.prepareStatement(sql);
			pre.setInt(1, id);
			re = pre.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return re;

	}

	public static int deleteOrder(int id) {
		int re = 0;

		try {
			Connection connect = JDBCUtil.getConnection();
			String sql = "DELETE from Orders where id=?";
			PreparedStatement pre = connect.prepareStatement(sql);
			pre.setInt(1, id);
			re = pre.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return re;


	}

	public static void main(String[] args) {
//		System.out.println(getListOrder(9));
//		System.out.println(deleteOrderDetail(3));
//		System.out.println(deleteOrder(3));

		System.out.println(getCategory(1));
	}
}
