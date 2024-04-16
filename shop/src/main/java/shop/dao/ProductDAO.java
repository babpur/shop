package shop.dao;

import java.util.*;
import java.sql.*;

public class ProductDAO {
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
