<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*" %>    
<%@ page import="java.util.*" %>
<%
	System.out.println("--------------------");
	System.out.println("/emp/ordersList.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginEmp
	
	if(session.getAttribute("loginEmp") == null) {
		// 로그인이 되었을 때 empList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	// order 페이징
%>

<!-- empMenu -> orderListAll -->    
<%
	ArrayList<HashMap<String, Object>> list = OrdersDAO.selectOrdersListAll(startRow, rowPerPage);
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