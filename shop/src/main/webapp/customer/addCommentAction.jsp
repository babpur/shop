<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="shop.dao.*"%>
<%
	System.out.println("--------------------");
	System.out.println("addCommentAction.jsp");
	
	// 인증 분기: 세션 변수 이름 - loginCustomer
	
	if(session.getAttribute("loginCustomer") != null) {
	// 로그인이 되지 않았을 때 productList.jsp로 리다이렉트하겠다.
		response.sendRedirect("/shop/customer/productList.jsp");
		return;
	}
%>

<%
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	int productNo = Integer.parseInt(request.getParameter("productNo"));
	String content = request.getParameter("content");
	int score = Integer.parseInt(request.getParameter("score"));
	
	int row = CommentDAO.insertComment(ordersNo, score, content);
	if(row == 1 ){
		System.out.println("후기 작성 성공");
	} else {
		System.out.println("후기 작성 실패");
	}
	response.sendRedirect("/shop/customer/productList.jsp");
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