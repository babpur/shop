package shop.dao;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	
	
	
	
	// 
	
	
	
	
	// 상품 상세 정보(customer)
	
	
	// 상품 list 페이징(/customer/productList.jsp)
	public static ArrayList<HashMap<String, Object>> selecetProductCustomerList(int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>();
				
			Connection conn = DBHelper.getConnection();
			
			String sql = "SELECT category, product_title productTitle, product_content ProductContent,"
					+ " product_price productPrice, product_amount productAmount, create_date createDate"
					+ " FROM product"
					+ " ORDER BY create_date desc"
					+ " LIMIT ?, ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("productNo", rs.getString("product_no")); // 상품 번호
				m.put("category", rs.getString("category")); // 상품 카테고리
				m.put("productTitle", rs.getString("product_title")); // 상품명
				m.put("productContent", rs.getString("product_content")); // 상품 상세 정보
				m.put("productPrice", rs.getInt("product_price")); // 상품 가격
				m.put("productAmount", rs.getInt("product_amount")); // 상품 수량
				m.put("createDate", rs.getString("create_date")); // 상품 등록 일자
				// m.put("imagePath,", imagePath); // 상품 썸네일
				
				list.add(m);
			}
			conn.close();
			return list;
	}
	
	// /emp/productList - subMenu
	public static ArrayList<HashMap<String, Object>> selecetSubMenuList()
			throws Exception {
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql ="SELECT category, COUNT(*) cnt"
			+ " FROM product"
			+ " GROUP BY category"
			+ " ORDER BY category asc;";	
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = 
					new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("cnt", rs.getInt("cnt"));
			
			list.add(m);
		}
		conn.close();
		return list;
	}
	
	
	// 상품 상세 정보(emp)

	// 상품 list 페이징(/emp/productList.jsp)
	public static ArrayList<HashMap<String, Object>> selectProductList(int startRow, int rowPerPage)
			throws Exception {
			ArrayList<HashMap<String, Object>> list = 
					new ArrayList<HashMap<String, Object>>();
			
			Connection conn = DBHelper.getConnection();
			
			String sql = "SELECT *"
					+ " FROM product"
					+ " ORDER BY create_date desc"
					+ " LIMIT ?, ?";
			
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("productNo", rs.getString("product_no")); // 상품 번호
				m.put("category", rs.getString("category")); // 상품 카테고리
				m.put("productTitle", rs.getString("product_title")); // 상품명
				m.put("productContent", rs.getString("product_content")); // 상품 상세 정보
				m.put("productPrice", rs.getInt("product_price")); // 상품 가격
				m.put("productAmount", rs.getInt("product_amount")); // 상품 수량
				m.put("updateDate", rs.getString("update_date")); // 수정 일자
				m.put("createDate", rs.getString("create_date")); // 상품 등록 일자
				// m.put("imagePath,", imagePath); // 상품 썸네일
				
				list.add(m);
			}
			
			conn.close();
			return list;
	}
}
