package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Product;

public class IndexDAO {
	public static List<Product> getSellProduct() {
		List<Product> list = new ArrayList<>();
		String query = "select top 4 * from Products order by price ";
		try {
			Connection conn =  JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {
		
		}

		return list;
	}

	public static List<Product> getOutstandingProduct() {
		List<Product> list = new ArrayList<>();
		String query = "select * from Products where id in (1,4,6,8)";
		try {
			Connection conn =  JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		} catch (Exception e) {
		
		}

		return list;
	}
public static void main(String[] args) {
	IndexDAO pd = new IndexDAO();
	List<Product> list = pd.getOutstandingProduct();
	for (Product product : list) {
		System.out.println(product.toString());
	}
}

}
