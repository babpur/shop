package shop.dao;

import java.util.*;
import java.sql.*;

public class OrdersDAO {
	
	// 배송 받은 고객이 state를 배송 완료로 변경
	// /customer/ordersList
	public static int updateStateOrder(int ordersNo, String newState) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		String sql = "UPDATE orders SET state = ?,"
				+ " create_date = create_date,"
				+ " update_date = NOW()"
				+ " WHERE orders_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newState);
		stmt.setInt(2, ordersNo);
		
		System.out.println("updateStateOrder: " + stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// emp에서 주문 완료된 state를 배송 중으로 변경
	// /emp/orderList.jsp
	public static int updateStateOrderEmp(int ordersNo, String newState) throws Exception{
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		PreparedStatement stmt = null;
		String sql = "UPDATE orders SET state = ?,"
				+ " create_date = create_date,"
				+ " update_date = NOW()"
				+ " WHERE orders_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newState);
		stmt.setInt(2, ordersNo);
		
		System.out.println("updateStateOrderEmp: " + stmt);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	// ordersList(고객)
	public static ArrayList<HashMap<String, Object>> selectOrdersListCustomer(String mail, int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> list =
			new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT *"
				+ " FROM orders"
				+ " WHERE mail = ?"
				+ " ORDER BY create_date desc"
				+ " LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>();
			m.put("ordersNo", rs.getInt("orders_no"));
			m.put("productNo", rs.getString("product_no"));
			m.put("totalAmount", rs.getInt("total_amount"));
			m.put("totalPrice", rs.getInt("total_price"));
			m.put("address", rs.getString("address"));
			m.put("createDate", rs.getString("create_date"));
			m.put("state", rs.getString("state"));
			list.add(m);
			System.out.println("list: " + list);
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
				+ " o.address address, o.create_date createDate, total_price totalPrice,"
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
			map.put("totalAmount", rs.getString("totalAmount"));
			map.put("totalPrice", rs.getString("totalPrice"));
			map.put("address", rs.getString("address"));
			map.put("createDate", rs.getString("createDate"));
			map.put("state", rs.getString("state"));
			list.add(map);
		}
		conn.close();
		return list;
	}
	
	// addOrders.jsp
	public static int insertOrders(String mail, int productNo, int totalAmount, int totalPrice, String address)
		throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO orders(mail, product_no, total_amount, total_price, address, state)"
				+ " VALUES (?, ?, ?, ?, ?, '주문 완료')";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setInt(2, productNo);
		stmt.setInt(3, totalAmount);
		stmt.setInt(4, totalPrice);
		stmt.setString(5, address);
		row = stmt.executeUpdate();
		conn.close();
		return row;
	}
}
