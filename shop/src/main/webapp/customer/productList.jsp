<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
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
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<a href="/shop/customer/customerLogout.jsp">LOGOUT</a>
</body>
</html>