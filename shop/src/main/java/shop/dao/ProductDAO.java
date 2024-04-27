package shop.dao;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	
	// 상품 주문 시 수량 증감
	// /customer/addOrdersAction.jsp
	public static int updateProductAmount(int productNo, int amount) 
		throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "UPDATE product"
				+ " SET product_amount = + -?"
				+ " WHERE product_no =?";

		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setInt(1, amount);
		stmt.setInt(2, productNo);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	// 상품 등록 

	// addProductAction.jsp
	public static int insertProduct(String category, String empId, String productTitle, String filename, int productPrice, int productAmount, String productContent)
		throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO product(category, emp_id, product_title, filename, product_price, product_amount, product_content)"
				+ " VALUES(?, ?, ?, ?, ?, ?, ?)";		

		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category); 
		stmt.setString(2, empId);
		stmt.setString(3, productTitle);
		stmt.setString(4, filename);
		stmt.setInt(5, productPrice);
		stmt.setInt(6, productAmount);
		stmt.setString(7, productContent);
		
		return row;
	}
	
	// 상품 상세 정보(customer)
	// /customer/productOne.jsp
	public static ArrayList<HashMap<String, Object>> selectProductOneByCustomer(int productNo)
		throws Exception {
		ArrayList<HashMap<String, Object>> list =
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT *"
				+ " FROM product"
				+ " WHERE product_no =?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("productNo", rs.getInt("product_no"));
			m.put("category", rs.getString("category"));
			m.put("productTitle", rs.getString("product_title"));
			m.put("productContent", rs.getString("product_content"));
			m.put("productPrice", rs.getString("product_price"));
			m.put("productAmount", rs.getString("product_amount"));
			m.put("createDate", rs.getString("create_date"));
			m.put("imagePath", rs.getString("filename")); // 상품 썸네일
			list.add(m);
		}
		conn.close();
		return list;
	}
	
	
	// 상품 list 페이징(/customer/productList.jsp)
	public static ArrayList<HashMap<String, Object>> selectProductCustomerList(int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>();
				
			Connection conn = DBHelper.getConnection();
			
			String sql = "SELECT product_no productNo, category, filename, product_title productTitle, product_content ProductContent,"
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
				m.put("productNo", rs.getInt("productNo")); // 상품 번호
				m.put("category", rs.getString("category")); // 상품 카테고리
				m.put("productTitle", rs.getString("productTitle")); // 상품명
				m.put("productContent", rs.getString("productContent")); // 상품 상세 정보
				m.put("productPrice", rs.getInt("productPrice")); // 상품 가격
				m.put("productAmount", rs.getInt("productAmount")); // 상품 수량
				m.put("createDate", rs.getString("createDate")); // 상품 등록 일자
				m.put("imagePath,", rs.getString("filename")); // 상품 썸네일
				
				list.add(m);
			}
			conn.close();
			return list;
	}
	
	// /emp/productList - subMenu
	public static ArrayList<HashMap<String, Object>> selectSubMenuList()
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
	// /emp/productOne.jsp
	public static ArrayList<HashMap<String, Object>> selectProductOneByEmp(int productNo)
		throws Exception {
		ArrayList<HashMap<String, Object>> list = 
				new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT *"
				+ " FROM product"
				+ " WHERE product_no =?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, productNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("productNo",rs.getInt("product_no"));
			m.put("category",rs.getString("category"));
			m.put("empId",rs.getString("emp_id"));
			m.put("productTitle",rs.getString("product_title"));
			m.put("productContent",rs.getString("product_content"));
			m.put("productPrice",rs.getInt("product_price"));
			m.put("productAmount",rs.getInt("product_amount"));
			m.put("updateDate",rs.getString("update_date"));
			m.put("createDate",rs.getString("create_date"));
			m.put("imagePath,", rs.getString("filename")); // 상품 썸네일
			list.add(m);
		}
		conn.close();
		return list;
	}
	
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
				m.put("imagePath,", rs.getString("filename")); // 상품 썸네일
				
				list.add(m);
			}
			
			conn.close();
			return list;
	}
}
