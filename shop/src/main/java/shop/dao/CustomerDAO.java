package shop.dao;

import java.sql.*;
import java.util.*;

public class CustomerDAO {
	
	// editPwAction.jsp
	public static int updatePw(String mail, String oldPw, String newPw) throws Exception {
		int row = 0;

		Connection conn = DBHelper.getConnection();
		String sql = "update customer"
				+ " set pw = ?"
				+ " where mail = ? and pw = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, mail);
		stmt.setString(3, oldPw);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// dropCustomerAction.jsp
	public static int deleteCustomer(String mail, String pw) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "delete from customer where mail = ? and pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		
		conn.close();
		
		return row;
	}
	
	
	// addCustomerAction.jsp
	public static int insertCustomer(String mail, String pw, String name, String birth, String gender) throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO customer(mail, pw, name, birth, gender) VALUES(?, password(?), ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		stmt.setString(3, name);
		stmt.setString(4, birth);
		stmt.setString(5, gender);
		
		conn.close();
		return row;
	}
	
	// customerOne.jsp
	public static ArrayList<HashMap<String, Object>> selectCustomerOne(String mail) throws Exception {
		ArrayList<HashMap<String, Object>> resultMap =
				new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "select * from customer where mail=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("mail", rs.getString("mail"));
			m.put("pw", rs.getString("pw"));
			m.put("name", rs.getString("name"));
			m.put("birth", rs.getString("birth"));
			m.put("gender", rs.getString("gender"));
			
		}
		conn.close();
		return resultMap;
	}
	
	// customerLoginAction.jsp
	public static HashMap<String, Object> login(String mail, String pw) throws Exception {
		HashMap<String, Object> resultMap = null;
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		String sql = "select mail, pw from customer where mail=? and pw=password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("mail", rs.getString("mail"));
			resultMap.put("pw", rs.getString("pw"));
		}
		conn.close();
		return resultMap;
	}
}