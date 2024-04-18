package shop.dao;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	
	
	
	
	// 
	
	
	
	
	// 상품 상세 정보(customer)
	
	
	// 상품 list 페이징(/customer/productList.jsp)
	
	// /emp/productList - subMenu

	
	
	// 상품 상세 정보(emp)
	public static ArrayList<HashMap<String, Object>> selecetProductCustomerList(int startRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>());
				
			Connection conn = DBHelper.getConnection();
			
			String sql = "SELECT category, product_title productTitle, product_content ProductContent, product_price productPrice, product_amount productAmount, create_date createDate"
					+ " FROM product"
					+ " ORDER BY create_date desc"
					+ " limit ?, ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				
			}
	}
	
	
	
	// 상품 list 페이징(/emp/productList.jsp)
	public static ArrayList<HashMap<String, Object>> selectProductList(int startRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list = 
					new ArrayList<HashMap<String, Object>>();
			
			Connection conn = DBHelper.getConnection();
			
			String sql = "select *"
					+ " from product"
					+ " order by create_date desc"
					+ " limit ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("productNo", rs.getString("product_no"));
				m.put("category", rs.getString("category"));
				m.put("productTitle", rs.getString("product_title"));
				m.put("productContent", rs.getString("product_content"));
				m.put("productPrice", rs.getInt("product_price"));
				m.put("productAmount", rs.getInt("product_amount"));
				m.put("createDate", rs.getString("create_date"));
				m.put("imagePath,", imagePath);
				
				list.add(m);
			}
			
			conn.close();
			return list;
	}
}
