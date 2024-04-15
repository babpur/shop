<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	System.out.println("--------------------");
	System.out.println("addCustomerAction.jsp");

	// 인증 분기: 세션 변수 이름 - loginCustomer

	if(session.getAttribute("loginCustomer") != null) {
	// 로그인이 되지 않았을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>
<%

	String customerName = request.getParameter("customerName");
	String customerEmail = request.getParameter("customerEmail");
	String customerPw = request.getParameter("customerPw");
	String customerBirth = request.getParameter("customerBirth");
	String customerGender = request.getParameter("customerGender");

	System.out.println("customerName: " + customerName);
	System.out.println("customerEmail: " + customerEmail);
	System.out.println("customerPw: " + customerPw);
	System.out.println("customerBirth: " + customerBirth);
	System.out.println("customerGender: " + customerGender);
%>

<%
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	/* 
		insert 쿼리
		INSERT INTO customer(mail, pw, NAME, birth, gender) VALUES(?, password(?), ?, ?, ?);
	*/
	String sql = "INSERT INTO customer(mail, pw, NAME, birth, gender) VALUES(?, password(?), ?, ?, ?)";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerEmail);
	stmt.setString(2, customerPw);
	stmt.setString(3, customerName);
	stmt.setString(4, customerBirth);
	stmt.setString(5, customerGender);
	
	System.out.println("stmt: " + stmt);
	
	
	int row = 0;
	row = stmt.executeUpdate();
	if(row == 1){
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");		
		System.out.println("회원 가입 성공");
	} else {
		response.sendRedirect("/shop/customer/addCustomerForm.jsp");
		System.out.println("회원 가입 실패");
	}
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