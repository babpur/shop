package shop.dao;

import java.util.*;
import java.sql.*;

public class OrdersDAO {
	
	// addOrders
	
	
	
	// ordersList(고객)
	public static ArrayList<HashMap<String, Object>> selectOrdersListCustomer(int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> list =
			new ArrayList<HashMap<String, Object>>();
		String sql = "SELECT o.orders_no ordersNo,"
				+ " o.product_no productNo, p.product_title productTitle"
				+ " INNER JOIN product p "
				+ " ON o.product_no = p.product_no"
				+ " ORDER BY o.orders_no desc"
				+ " LIMIT ?, ?";
		
		// 빈칸 채우기
		
		return list;
	}
	
	// ordersList (직원)
	public static ArrayList<HashMap<String, Object>> selectOrdersListAll(int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> list =
			new ArrayList<HashMap<String, Object>>();
		String sql = "SELECT o.orders_no ordersNo,"
				+ " o.product_no productNo, p.product_title productTitle"
				+ " INNER JOIN product p "
				+ " ON o.product_no = p.product_no"
				+ " ORDER BY o.orders_no desc"
				+ " LIMIT ?, ?";
	
		// 빈칸 채우기
		
		return list;
	}
}
