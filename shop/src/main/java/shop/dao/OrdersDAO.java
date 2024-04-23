package shop.dao;

import java.util.*;
import java.sql.*;

public class OrdersDAO {
	
	// ordersList(고객)
	public static ArrayList<HashMap<String, Object>> selectOrdersListCustomer(int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> list =
			new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT o.orders_no ordersNo,"
				+ " o.product_no productNo, p.product_title productTitle"
				+ " INNER JOIN product p "
				+ " ON o.product_no = p.product_no"
				+ " ORDER BY o.orders_no desc"
				+ " LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			
		}
		
		conn.close();
		return list;
	}
	
	// ordersList (직원)
	public static ArrayList<HashMap<String, Object>> selectOrdersListAll(int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> list =
			new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT o.orders_no ordersNo,"
				+ " o.product_no productNo, p.product_title productTitle,"
				+ " o.total_amount totalAmount, p.product_price productPrice,"
				+ " o.address adress, o.create_date createDate, total_price totalPrice,"
				+ " state"
				+ " FROM orders o"
				+ " INNER JOIN product p "
				+ " ON o.product_no = p.product_no"
				+ " ORDER BY o.orders_no desc"
				+ " LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String, Object> map = new HashMap<>();
			map.put("ordersNo", rs.getInt("ordersNo"));
			map.put("productNo", rs.getInt("productNo"));
			map.put("productTitle", rs.getString("productTitle"));
			map.put("productTitle", rs.getString("productTitle"));
			map.put("productTitle", rs.getString("productTitle"));
			map.put("productTitle", rs.getString("productTitle"));
			map.put("productTitle", rs.getString("productTitle"));
			map.put("productTitle", rs.getString("productTitle"));
			map.put("state", rs.getString("state"));
			
		}
		conn.close();
		return list;
	}
	
	
	// addOrders.jsp
	
	public static int insertOrders(String mail, int totalAmount, int totalPrice, String address)
		throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO orders(mail, total_amount, total_price, address)"
				+ " VALUES (?, ?, ?, ?)";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, totalAmount);
		stmt.setInt(3, totalPrice);
		stmt.setString(4, address);
		
		conn.close();
		return row;
	}
}
