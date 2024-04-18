package shop.dao;

import java.sql.*;
import java.util.*;

public class CategoryDAO {
	
	// addCategoryAction.jsp
	public static int insertCategory(String addCategory) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		String sql = "insert into category(category) values(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, addCategory);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	
	// deleteCategoryAction.jsp
	public static int deleteCategory(String category) throws Exception {
		int row = 0;
		Connection conn = DBHelper.getConnection();
		
		String sql = "delete from category where category=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		
		row = stmt.executeUpdate();
		
		conn.close();
		
		return row;
	}
	
	// categoryList.jsp
	public static ArrayList<HashMap<String, Object>> selectCategoryList() throws Exception {
		ArrayList<HashMap<String, Object>> categoryList =
			new ArrayList<HashMap<String, Object>>();
				
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT category, create_date FROM category";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("category", rs.getString("category"));
			m.put("createDate", rs.getString("create_date"));
			categoryList.add(m);
		}
		
		conn.close();
		return categoryList;
	}
	
}