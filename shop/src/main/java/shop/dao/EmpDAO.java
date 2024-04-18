package shop.dao;

import java.util.*;
import java.sql.*;

// 해당 CLASS는 emp 테이블을 CRUD하는 static method의 컨테이너 역할을 함.
public class EmpDAO {
	
	
	// 회원 가입 
	// addEmpAction.jsp
	public static int insertEmp(String empId,String empPw, String empName, String empJob, String hireDate) 
			throws Exception{
		int row = 0;
		
		// DB 접근
		Connection conn = DBHelper.getConnection();
		String sql = "INSERT INTO emp(emp_id, emp_pw, emp_name, emp_job, hire_date)"
				+ " VALUES(?, password(?), ?, ?, ?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		stmt.setString(5, hireDate);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	
	// empLoginAction.jsp
	
	// HashMap<String, Object>: null이면 로그인 실패, 아니면 로그인 성공.
	// String empId, String empPw: 로그인 폼에서 사용자가 입력한 id / pw 
	
	// 호출 코드 HashMap<String, Object> m = EmpDAO.empLogin("admin", "1234");
	public static HashMap<String, Object> empLogin(String empId, String empPw) 
			throws Exception{
													
		HashMap<String, Object> resultMap = null;
		
		// DB 접근 코드
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT emp_id empId, emp_name empName, grade"
				+ " FROM emp"
				+ " WHERE active='ON' AND emp_id = ? AND emp_pw = password(?)";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
		
		}
		conn.close();
		return resultMap;
	}
	
	// empList.jsp
	public static ArrayList<HashMap<String, Object>> selectEmpList(int startRow, int rowPerPage)
			throws Exception {
		ArrayList<HashMap<String, Object>> empList =
			new ArrayList<HashMap<String, Object>>();
				
		
		// DB 접근
		
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT emp_id, grade, emp_name, emp_job, hire_date, active"
				+ " FROM emp"
				+ " ORDER BY hire_date desc limit ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("empId", rs.getString("emp_id"));
			m.put("grade", rs.getInt("grade"));
			m.put("empName", rs.getString("emp_name"));
			m.put("empJob", rs.getString("emp_job"));
			m.put("hireDate", rs.getString("hire_date"));
			m.put("active", rs.getString("active"));
			
			empList.add(m);
		}
		conn.close();
		return empList;
	}
	
	// empOne.jsp
	public static ArrayList<HashMap<String, Object>> selectEmpOne(String empId)
			throws Exception {
		ArrayList<HashMap<String, Object>> empOne =
				new ArrayList<HashMap<String, Object>>();
		Connection conn = DBHelper.getConnection();
		String sql = "SELECT *"
				+ " FROM emp"
				+ " WHERE emp_id=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, empId);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("empId", rs.getString("emp_id"));
			m.put("grade", rs.getInt("grade"));
			m.put("empName", rs.getString("emp_name"));
			m.put("empJob", rs.getString("emp_job"));
			m.put("hireDate", rs.getString("hire_date"));
			empOne.add(m);
		}
		conn.close();
		return empOne;
	}
	
	// modifyEmpActive.jsp
	public static int updateEmpActive(String empId, String active)
			throws Exception {
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "UPDATE emp"
				+ " SET active = ?"
				+ " WHERE emp_id = ? AND active = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		if(active.equals("ON")) {
			stmt.setString(1, "OFF");
		} else if(active.equals("OFF")){
			stmt.setString(1, "ON");
		}
		stmt.setString(2, empId);
		stmt.setString(3, active);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
}