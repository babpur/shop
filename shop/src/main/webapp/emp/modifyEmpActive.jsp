<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!-- Controller Layer-->
<%
	System.out.println("----------");
	System.out.println("modifyEmpAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>

<%
	// request 
	String active = request.getParameter("active");
	
	System.out.println(active);

	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	
	// update emp set active ='ON'	
	String sql = "update emp set active = ? where active = ? and emp_id = ?";
	
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	
	
	if("ON".equals(active)) {
		stmt.setString(1, "OFF");
		stmt.setString(2, "ON");
	} else {
		stmt.setString(1, "ON");
		stmt.setString(2, "OFF");
	}
	System.out.println("stmt: " + stmt);

	int row = 0;
	
	row = stmt.executeUpdate();
	response.sendRedirect("/shop/emp/empList.jsp");
%>