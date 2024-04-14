<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	System.out.println("----------");
	System.out.println("customerOne.jsp");
	
 	// 인증 분기: 세션 변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되지 않았을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	} 
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div><jsp:include page="/customer/inc/customerMenu.jsp"></jsp:include></div>

</body>
</html>