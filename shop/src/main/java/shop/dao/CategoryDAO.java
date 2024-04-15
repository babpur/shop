package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;

public class CategoryDAO {
	// categoryList.jsp
	public static ArrayList<HashMap<String, Object>> selectCategoryList() throws Exception {
		ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
				
		// DB 접근
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT category, create_date createDate FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("createDate", rs.getInt("create_date"));
			categoryList.add(m);
		}
		
		conn.close();
		return categoryList;
	}
	
	
	
	// addCategoryAction.jsp
	
	
	
	
	// deleteCategoryAction.jsp
	
	
}
