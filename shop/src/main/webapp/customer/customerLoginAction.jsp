<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	System.out.println("--------------------");
	System.out.println("customerLoginAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") != null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>
<%	
	String customerEmail = request.getParameter("customerEmail");
	String customerPw = request.getParameter("customerPw");
	
	System.out.println("customerEmail: " + customerEmail);
	System.out.println("customerPw: " + customerPw);
	
%>
<%
	/* 
		select mail, pw from customer where mail=?, pw=?
	*/
	String sql = "select mail, pw from customer where mail=? and pw=password(?)";
	
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");	

	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerEmail);
	stmt.setString(2, customerPw);
	
	rs = stmt.executeQuery();
	
	response.sendRedirect("/shop/customer/productList.jsp");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
</body>
</html>