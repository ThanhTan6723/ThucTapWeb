package dao.client;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Product;

public class IndexDAO {
	public static List<Product> getTop8() {
		List<Product> list = new ArrayList<>();
		String query = "SELECT * FROM Products LIMIT 8;";
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

	/*public static List<Product> getOutstandingProduct() {
		List<Product> list = new ArrayList<>();
		String query = "SELECT * FROM Products ORDER BY price DESC LIMIT 4;";
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
	}*/
	public static List<Product> getNext4Product(int amount){
		List<Product> list = new ArrayList<>();
		String query = "select * from Products where price>40 order by id limit 4 offset ?;";
		try{
			Connection con = JDBCUtil.getConnection();
			PreparedStatement ps  = con.prepareStatement(query);
			ps.setInt(1,amount);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				list.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		}catch (Exception e){

		}
		return list;

	}
	public static List<Product> listRandProduct(){
		List<Product> listRandProduct = new ArrayList<>();
		String query = "select * from Products  ORDER BY RAND() LIMIT 3;";
		try{
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				listRandProduct.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		}catch (Exception e){

		}
		return listRandProduct;
	}
	public static List<Product> listRand4Product(){
		List<Product> listRandProduct = new ArrayList<>();
		String query = "select * from Products  ORDER BY RAND() LIMIT 4;";
		try{
			Connection conn = JDBCUtil.getConnection();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				listRandProduct.add(new Product(rs.getInt(1), rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5),
						OrderDAO.getCategory(rs.getInt(6))));
			}
		}catch (Exception e){

		}
		return listRandProduct;
	}





	public static void main(String[] args) {
	IndexDAO pd = new IndexDAO();
/*	List<Product> list = pd.getOutstandingProduct();
	for (Product product : list) {
		System.out.println(product.toString());
	}*/
	List<Product> list = pd.listRandProduct();
	for(Product product : list){
		System.out.println(product.toString());
	}
}

}
