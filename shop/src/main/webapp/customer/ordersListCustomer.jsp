<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%
	System.out.println("--------------------");
	System.out.println("/customer/ordersList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") == null) {
		// 로그인이 되었을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/customerLoginForm.jsp");
		return;
	}
%>
<!-- customerOne -> ordersList--> 
<%
	
	ArrayList<HashMap<String, Object>> list = OrdersDAO.selectOrdersListCustomer(startRow, rowPerPage);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>