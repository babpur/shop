<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	System.out.println("--------------------");
	System.out.println("dropCustomerAction.jsp");
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>

<%
	// customerOne -> dropCustomerAction     

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