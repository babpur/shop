<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*"%>

<%
	System.out.println("----------");
	System.out.println("empLoginAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") != null) {
		// 로그인이 되었을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw"); 

	System.out.println("empId: " + empId);
	System.out.println("empPw: " + empPw);
	
	/* 
		select emp_id empId from emp where active='ON' and emp_id = ? and emp_pw = password(?)
	*/
	String sql = "select emp_id empId, emp_name empName, grade from emp where active='ON' and emp_id = ? and emp_pw = password(?)";
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	rs = stmt.executeQuery();
	
	System.out.println("stmt: " + stmt);
	// 실패 empLoginForm.jsp
	// 성공 empList.jsp
	
	if(rs.next()){
		System.out.println("로그인 성공");
		// 세션 변수 안에 여러 개의 값을 저장하기 위해서 HashMap을 사용하겠다.
		HashMap<String, Object> loginEmp = new HashMap<String, Object>();
		loginEmp.put("empId", rs.getString("empId"));
		loginEmp.put("empName", rs.getString("empName"));
		loginEmp.put("grade", rs.getString("grade"));
		
		session.setAttribute("loginEmp", loginEmp);

		// 디버깅 (로그인 세션 변수)
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
		System.out.println((String)(m.get("empId")));
		System.out.println((String)(m.get("empName")));
		System.out.println((Integer)(m.get("grade")));
		
		response.sendRedirect("/shop/emp/empList.jsp");

	} else {
		System.out.println("로그인 실패");
		String errMsg = URLEncoder.encode("잘못된 접근입니다. \n ID와 비밀번호를 확인해 주세요", "utf-8");
		response.sendRedirect("/shop/emp/empLoginAction.jsp?errMsg=" + errMsg);
		return;
	}
%>