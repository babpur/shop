<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>    
<%@ page import="java.util.*" %>
<%
	System.out.println("--------------------");
	System.out.println("/customer/productOne.jsp");
	
	// �� login ���� �б�
	
	if(session.getAttribute("loginCustomer") == null) {
		// �α����� �Ǿ��� �� productList.jsp�� �����̷�Ʈ�ϰڴ�.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>

<%

%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>