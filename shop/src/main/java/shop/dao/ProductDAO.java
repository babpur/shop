package shop.dao;

import java.util.*;
import java.sql.*;

public class ProductDAO {
	
	
	
	
	// 
	
	
	// 상품 상세 정보(customer)
	
	
	// 상품 list 페이징(/customer/productList.jsp)
	
	
	
	// 상품 상세 정보(emp)
	
	
	
	
	// 상품 list 페이징(/emp/productList.jsp)
	public static ArrayList<HashMap<String, Object>> selectProductList(int startRow, int rowPerPage) throws Exception {
			ArrayList<HashMap<String, Object>> list = 
					new ArrayList<HashMap<String, Object>>();
			
			Connection conn = DBHelper.getConnection();
			
			String sql = "select *"
					+ "from product"
					+ "order by create_date desc"
					+ "limit ?, ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, startRow);
			stmt.setInt(2, rowPerPage);
			
			ResultSet rs = stmt.executeQuery();
			while(rs.next()) {
				HashMap<String, Object> m = new HashMap<String, Object>();
				m.put("productNo", rs.getString("product_no"));
			
				
				list.add(m);
			}
			
			conn.close();
			return list;
	}
}
